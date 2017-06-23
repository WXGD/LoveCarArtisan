//
//  CouponContentViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponContentViewController.h"
// view
#import "CouponContentView.h"
// 下级控制器
#import "AddCouponViewController.h"
#import "EditCouponViewController.h"
#import "GrantRecordViewController.h"
#import "GrantViewController.h"

@interface CouponContentViewController ()<CouponContentDelegate>

/** 优惠劵内容 */
@property (strong, nonatomic) CouponContentView *couponContentView;

@end

@implementation CouponContentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 马上进入刷新状态
    [self.couponContentView.contentTable.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self couponContentLayoutView];
    // 网络请求
    [self couponContentRequestData];
}
#pragma mark - 网络请求
- (void)couponContentRequestData {
    // 初始化请求模型
    CouponGoverModel *couponGoverModel = [[CouponGoverModel alloc] init];
    // 下拉刷新
    @weakify(self)
    self.couponContentView.contentTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        /*/index.php?c=coupon&a=all_list&v=1
         provider_id 	int 	是 	服务商id
         start 	int 	否 	记录位置,默认0
         status 	int 	否 	优惠券状态: 0-禁用 1-启用 2-过期
         pageSize 	int 	否 	每页显示条数,默认0,显示全部       */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"status"] = [NSString stringWithFormat:@"%ld", self.couponState]; // 优惠券状态
        // 网络请求
        [couponGoverModel couponGoverRefresh:self.couponContentView.contentTable params:params success:^(NSMutableArray *couponListArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.couponContentView.couponArray removeAllObjects];
            // 判断是否有数据
            if (couponListArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.couponContentView.contentTable.mas_centerX);
                        make.centerY.equalTo(self.couponContentView.contentTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.couponContentView.couponArray = couponListArray;
            }
            [self.couponContentView.contentTable reloadData];
        }];
    }];
    // 上拉加载
    self.couponContentView.contentTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /*/index.php?c=coupon&a=all_list&v=1
         provider_id 	int 	是 	服务商id
         start 	int 	否 	记录位置,默认0
         status 	int 	否 	优惠券状态: 0-禁用 1-启用 2-过期 
         pageSize 	int 	否 	每页显示条数,默认0,显示全部       */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"status"] = [NSString stringWithFormat:@"%ld", self.couponState]; // 优惠券状态
        // 网络请求
        [couponGoverModel couponGoverLoad:self.couponContentView.contentTable params:params success:^(NSMutableArray *couponListArray) {
            [self.couponContentView.couponArray addObjectsFromArray:couponListArray];
            [self.couponContentView.contentTable reloadData];
        }];
    }];
}

#pragma mark - 按钮点击方法
// 添加优惠劵
- (void)addCouponBtnAction:(UIButton *)button {
    AddCouponViewController *addCouponVC = [[AddCouponViewController alloc] init];
    [self.navigationController pushViewController:addCouponVC animated:YES];
}
/** 发劵记录 */
- (void)grantRecordAction:(UIButton *)button {
    GrantRecordViewController *grantRecordVC = [[GrantRecordViewController alloc] init];
    grantRecordVC.couponGoverModel = [self.couponContentView.couponArray objectAtIndex:button.tag];
    grantRecordVC.couponArray = self.couponContentView.couponArray;
    [self.navigationController pushViewController:grantRecordVC animated:YES];
}
/** 禁用 */
- (void)disableAction:(UIButton *)button {
    // 优惠卷模型
    CouponGoverModel *couponGoverModel = [self.couponContentView.couponArray objectAtIndex:button.tag];
    [AlertAction determineStayLeft:self title:@"提示" message:@"禁用之后不可以再发放该优惠劵，是否确认？" determineBlock:^{
        /*/index.php?c=coupon&a=change_status&v=1
         provider_id 	int 	是 	服务商id
         coupon_id 	int 	是 	优惠券id
         status 	int 	是 	要修改的状态值： 0-禁用 1-启用        */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"coupon_id"] = [NSString stringWithFormat:@"%ld", couponGoverModel.coupon_id]; // 优惠券id
        params[@"status"] = @"0"; // 服务id
        [CouponGoverModel editCouponState:params success:^{
            // 马上进入刷新状态
            [self.couponContentView.contentTable.mj_header beginRefreshing];
        }];
    }];
}
/** 发劵 */
- (void)grantAction:(UIButton *)button {
    GrantViewController *grantVC = [[GrantViewController alloc] init];
    grantVC.couponGoverModel = [self.couponContentView.couponArray objectAtIndex:button.tag];
    [self.navigationController pushViewController:grantVC animated:YES];
}
/** 编辑优惠劵 */
- (void)editCoupon:(NSIndexPath *)indexPath {
    EditCouponViewController *editCouponVC = [[EditCouponViewController alloc] init];
    editCouponVC.couponGoverModel = [self.couponContentView.couponArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:editCouponVC animated:YES];
}
/** 启用 */
- (void)enableAction:(UIButton *)button {
    // 优惠卷模型
    CouponGoverModel *couponGoverModel = [self.couponContentView.couponArray objectAtIndex:button.tag];
    [AlertAction determineStayLeft:self title:@"提示" message:@"确定启用该优惠劵吗？" determineBlock:^{
        /*/index.php?c=coupon&a=change_status&v=1
         provider_id 	int 	是 	服务商id
         coupon_id 	int 	是 	优惠券id
         status 	int 	是 	要修改的状态值： 0-禁用 1-启用        */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"coupon_id"] = [NSString stringWithFormat:@"%ld", couponGoverModel.coupon_id]; // 优惠券id
        params[@"status"] = @"1"; // 服务id
        [CouponGoverModel editCouponState:params success:^{
            // 马上进入刷新状态
            [self.couponContentView.contentTable.mj_header beginRefreshing];
        }];
    }];
}

#pragma mark - 布局视图
- (void)couponContentLayoutView {
    /** 优惠劵内容 */
    self.couponContentView = [[CouponContentView alloc] init];
    /** 新增优惠劵 */
    [self.couponContentView.addCouponBtn addTarget:self action:@selector(addCouponBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 代理 */
    self.couponContentView.delegate = self;
    /** 优惠劵状态 */
    self.couponContentView.couponState = self.couponState;
    [self.view addSubview:self.couponContentView];
    @weakify(self)
    [self.couponContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
