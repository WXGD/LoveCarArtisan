//
//  CouponViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponViewController.h"
// view
#import "CouponView.h"
// model
#import "CouponModel.h"

@interface CouponViewController ()<CouponTabChoiceDelegate>

/** 优惠券 */
@property (strong, nonatomic) CouponView *couponView;

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self couponLayoutNAV];
    // 布局视图
    [self couponLayoutView];
    // 网络请求可用优惠券
    [self usableCouponRequestData];
    // 网络请求不可用优惠券
    [self noUsableCouponRequestData];
}


#pragma mark - 网络请求
// 可用优惠券
- (void)usableCouponRequestData {
    // 初始化优惠券请求类
    CouponModel *couponModel = [[CouponModel alloc] init];
    /*/index.php?c=coupon_grant_record&a=list&v=1
     provider_id 	string 	是 	服务商id
     mobile 	string 	是 	手机号
     car_plate_no 	string 	是 	车牌号
     goods_id 	int 	是 	商品id
     price 	float 	是 	商品实际价格
     is_useful 	int 	否 	是否可用，0-不可用 1-可用 默认为1     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"mobile"] = self.userInfo.mobile; // 手机号
    params[@"car_plate_no"] = [CustomObject isPlnNumber:self.userInfo.car_plate_no] ? self.userInfo.car_plate_no : @""; // 车牌号
    params[@"goods_id"] = [NSString stringWithFormat:@"%ld", self.defaultCommodity.goods_id]; // 商品id
    params[@"price"] = [NSString stringWithFormat:@"%.2f", self.defaultCommodity.total]; // 商品实际价格
    params[@"is_useful"] = @(1); // 是否可用
    // 下拉刷新
    @weakify(self)
    self.couponView.usableCouponTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求
        [couponModel couponRefreshRequestData:self.couponView.usableCouponTable params:params success:^(CouponModel *couponModel) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.couponView.usableCouponArray removeAllObjects];
            // 判断是否有数据
            if (couponModel.coupons.count == 0) {
                [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.couponView.usableCouponTable.mas_centerX);
                        make.centerY.equalTo(self.couponView.usableCouponTable.mas_centerY);
                    }];
                }];
            }else {
                // 遍历优惠券模型,标记优惠券可用
                [couponModel.coupons enumerateObjectsUsingBlock:^(CouponInfoModel *couponInfoModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    couponInfoModel.is_useful = YES;
                }];
                self.couponView.usableCouponArray = [NSMutableArray arrayWithArray:couponModel.coupons];
            }
            [self.couponView.usableCouponTable reloadData];
            // 优惠券个数赋值
            [self couponAssignment:couponModel];
        }];
    }];
    // 上拉加载
    self.couponView.usableCouponTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [couponModel couponLoadRequestData:self.couponView.usableCouponTable params:params success:^(CouponModel *couponModel) {
            // 遍历优惠券模型,标记优惠券可用
            [couponModel.coupons enumerateObjectsUsingBlock:^(CouponInfoModel *couponInfoModel, NSUInteger idx, BOOL * _Nonnull stop) {
                couponInfoModel.is_useful = YES;
            }];
            [self.couponView.usableCouponArray addObjectsFromArray:couponModel.coupons];
            [self.couponView.usableCouponTable reloadData];
        }];
    }];
    // 马上进入刷新状态
    [self.couponView.usableCouponTable.mj_header beginRefreshing];
}

// 不可用优惠券
- (void)noUsableCouponRequestData {
    // 初始化优惠券请求类
    CouponModel *couponModel = [[CouponModel alloc] init];
    /*/index.php?c=coupon_grant_record&a=list&v=1
     provider_id 	string 	是 	服务商id
     mobile 	string 	是 	手机号
     car_plate_no 	string 	是 	车牌号
     goods_id 	int 	是 	商品id
     price 	float 	是 	商品实际价格
     is_useful 	int 	否 	是否可用，0-不可用 1-可用 默认为1     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"mobile"] = self.userInfo.mobile; // 手机号
    params[@"car_plate_no"] = self.userInfo.car_plate_no; // 车牌号
    params[@"goods_id"] = [NSString stringWithFormat:@"%ld", self.defaultCommodity.goods_id]; // 商品id
    params[@"price"] = [NSString stringWithFormat:@"%.2f", self.defaultCommodity.total]; // 商品实际价格
    params[@"is_useful"] = @(0); // 是否可用
    // 下拉刷新
    @weakify(self)
    self.couponView.noUsableCouponTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求
        [couponModel couponRefreshRequestData:self.couponView.noUsableCouponTable params:params success:^(CouponModel *couponModel) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.couponView.noUsableCouponArray removeAllObjects];
            // 判断是否有数据
            if (couponModel.coupons.count == 0) {
                [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.couponView.noUsableCouponTable.mas_centerX);
                        make.centerY.equalTo(self.couponView.noUsableCouponTable.mas_centerY);
                    }];
                }];
            }else {
                // 遍历优惠券模型,标记优惠券不可用
                [couponModel.coupons enumerateObjectsUsingBlock:^(CouponInfoModel *couponInfoModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    couponInfoModel.is_useful = NO;
                }];
                self.couponView.noUsableCouponArray = [NSMutableArray arrayWithArray:couponModel.coupons];
            }
            [self.couponView.noUsableCouponTable reloadData];
            // 优惠券个数赋值
            [self couponAssignment:couponModel];
        }];
    }];
    // 上拉加载
    self.couponView.noUsableCouponTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [couponModel couponLoadRequestData:self.couponView.noUsableCouponTable params:params success:^(CouponModel *couponModel) {
            // 遍历优惠券模型,标记优惠券不可用
            [couponModel.coupons enumerateObjectsUsingBlock:^(CouponInfoModel *couponInfoModel, NSUInteger idx, BOOL * _Nonnull stop) {
                couponInfoModel.is_useful = NO;
            }];
            [self.couponView.noUsableCouponArray addObjectsFromArray:couponModel.coupons];
            [self.couponView.noUsableCouponTable reloadData];
        }];
    }];
}


#pragma mark - 优惠券选项卡选择代理
- (void)couponTabChoiceAction:(UIButton *)button {
    if ([button isEqual:self.couponView.noUsableCouponBtn]) {
        // 网络请求不可用优惠券
        if (self.couponView.noUsableCouponArray.count == 0) {
            // 马上进入刷新状态
            [self.couponView.noUsableCouponTable.mj_header beginRefreshing];
        }
    }else {
        // 网络请求可用优惠券
        if (self.couponView.usableCouponArray.count == 0) {
            // 马上进入刷新状态
            [self.couponView.usableCouponTable.mj_header beginRefreshing];
        }
    }
}

// 确认选择按钮
- (void)confirmChoiceBtnAction:(UIButton *)button {
    NSString *couponID = [[NSString alloc] init];
    double offerSum = 0.0;
    for (CouponInfoModel *couponInfoModel in self.couponView.usableCouponArray) {
        if (couponInfoModel.checkMark) {
            if (couponID.length == 0) {
                couponID = [NSString stringWithFormat:@"%ld", (long)couponInfoModel.coupon_grant_record_id];
            }else {
                couponID = [NSString stringWithFormat:@"%@,%ld", couponID, (long)couponInfoModel.coupon_grant_record_id];
            }
            offerSum += couponInfoModel.money;
        }
    }
    if (_CouponChioceBlock) {
        _CouponChioceBlock(couponID, offerSum);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 界面赋值
- (void)couponAssignment:(CouponModel *)couponModel {
    /** 可用优惠券 */
    [self.couponView.usableCouponBtn setTitle:[NSString stringWithFormat:@"可用优惠券（%ld）", couponModel.useful_count] forState:UIControlStateNormal];
    /** 不可用优惠券 */
    [self.couponView.noUsableCouponBtn setTitle:[NSString stringWithFormat:@"不可用优惠券（%ld）", couponModel.unuseful_count] forState:UIControlStateNormal];
}

#pragma mark - 布局nav
- (void)couponLayoutNAV {
    self.navigationItem.title = @"优惠券";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(homePageRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(homePageRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)couponLayoutView {
    /** 优惠券 */
    self.couponView = [[CouponView alloc] init];
    self.couponView.delegate = self;
    /** 确认选择view */
    [self.couponView.confirmChoiceBtn addTarget:self action:@selector(confirmChoiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.couponView];
    @weakify(self)
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
