//
//  OrderViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderViewController.h"
// view
#import "OrderView.h"
// 模型
#import "OrderModel.h"
// 下级控制器
#import "FilterConditionViewController.h"
#import "OrderInfoViewController.h"
// 接收上级页面的参数
#import "UIViewController+DCURLRouter.h"

@interface OrderViewController ()<OrderDeleSelectDelegate>

/** 订单view */
@property (strong, nonatomic) OrderView *orderView;
/** 保存选中支付方式 */
@property (strong, nonatomic) FiterItemModel *saveSelPay;
/** 保存选中订单类型 */
@property (strong, nonatomic) FiterItemModel *saveSelOrderClass;
/** 保存选中服务类型 */
@property (strong, nonatomic) FiterItemModel *saveSelServiceClass;
/** 开始日期 */
@property (copy, nonatomic) NSString *startDataStr;
/** 结束日期 */
@property (copy, nonatomic) NSString *endDataStr;
/** 筛选数据 */
@property (strong, nonatomic) NSMutableArray *filterArray;
/** 选中条件 */
@property (strong, nonatomic) NSMutableArray *selectedConditionArray;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self orderLayoutNAV];
    // 布局视图
    [self orderLayoutView];
    // 请求订单数据
    [self orderRequestData];
}

#pragma mark - 网络请求
- (void)orderRequestData {
    // 初始化订单请求类
    OrderModel *orderModel = [[OrderModel alloc] init];
    /*/index.php?c=order&a=list&v=1
     staff_user_id 	int 	否 	登陆者id(商户app必传,用户自己获取时不传)
     provider_id 	int 	是 	服务商id
     order_category_id 	int 	否 	订单类型id，默认为0（代表全部）
     provider_user_id 	int 	否 	用户id,(获取用户消费记录时必传)
     order_status 	int 	否 	订单状态，默认为0（代表全部）
     sale_user_id 	int 	否 	服务师傅id,默认为0（代表全部）
     pay_method 	int 	否 	支付方式, 1-支付宝 2-微信 3-会员卡 4-现金 (默认为0,代表全部)
     goods_category_id 	int 	否 	服务类别id,默认为0（代表全部）
     order_time 	string 	否 	订单时间区间,格式： 开始时间_截至时间,默认为''(代表全部     */
    // 下拉刷新
    @weakify(self)
    self.orderView.orderTableView.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"order_category_id"] = [NSString stringWithFormat:@"%ld", self.saveSelOrderClass.ID]; // 订单类型，默认为0（代表全部）
        params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfoMode.provider_user_id]; // 用户编号
        params[@"order_status"] = [NSString stringWithFormat:@"%ld", self.orderView.orderPayStateModel.chioceCategoriesId]; // 订单状态，默认为0（代表全部）
        params[@"sale_user_id"] = self.orderView.merchantModel.staff_user_id; // 服务师傅id,默认为0（代表全部）
        params[@"pay_method"] = [NSString stringWithFormat:@"%ld", self.saveSelPay.ID]; // 支付方式id,默认为0（代表全部）
        params[@"goods_category_id"] = [NSString stringWithFormat:@"%ld", self.saveSelServiceClass.ID]; // 服务类别id,默认为0（代表全部）
        if ([self.startDataStr isEqualToString:@"选择开始时间"] && [self.endDataStr isEqualToString:@"选择结束时间"]) {             params[@"order_time"] = @"";
        }else {
            params[@"order_time"] = [NSString stringWithFormat:@"%@_%@", self.startDataStr, self.endDataStr]; // 开始时间_截至时间,默认为0（代表全部）
        }
        // 网络请求
        [orderModel orderRefreshRequestData:self.orderView.orderTableView params:params viewController:self success:^(NSMutableArray *orderArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.orderView.orderTableArray removeAllObjects];
            // 判断是否有数据
            if (orderArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    noImage.image = [UIImage imageNamed:@"placeholder_order"];
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.orderView.orderTableView.mas_centerX);
                        make.centerY.equalTo(self.orderView.orderTableView.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.orderView.orderTableArray = orderArray;
            }
            [self.orderView.orderTableView reloadData];
            
        }];
    }];
    // 上拉加载
    self.orderView.orderTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"order_category_id"] = [NSString stringWithFormat:@"%ld", self.saveSelOrderClass.ID]; // 订单类型，默认为0（代表全部）
        params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfoMode.provider_user_id]; // 用户编号
        params[@"order_status"] = [NSString stringWithFormat:@"%ld", self.orderView.orderPayStateModel.chioceCategoriesId]; // 订单状态，默认为0（代表全部）
        params[@"sale_user_id"] = self.orderView.merchantModel.staff_user_id; // 服务师傅id,默认为0（代表全部）
        params[@"pay_method"] = [NSString stringWithFormat:@"%ld", self.saveSelPay.ID]; // 支付方式id,默认为0（代表全部）
        params[@"goods_category_id"] = [NSString stringWithFormat:@"%ld", self.saveSelServiceClass.ID]; // 服务类别id,默认为0（代表全部）
        if ([self.startDataStr isEqualToString:@"选择开始时间"] && [self.endDataStr isEqualToString:@"选择结束时间"]) { 
            params[@"order_time"] = @"";
        }else {
            params[@"order_time"] = [NSString stringWithFormat:@"%@_%@", self.startDataStr, self.endDataStr]; // 开始时间_截至时间,默认为0（代表全部）
        }
        // 网络请求
        [orderModel orderLoadRequestData:self.orderView.orderTableView params:params viewController:self success:^(NSMutableArray *orderArray) {
            [self.orderView.orderTableArray addObjectsFromArray:orderArray];
            [self.orderView.orderTableView reloadData];
        }];
    }];
    // 马上进入刷新状态
    [self.orderView.orderTableView.mj_header beginRefreshing];
}

#pragma mark - 按钮点击方法
- (void)orderRightBarBtnAction {
    /** 筛选展示view */
    CGFloat screenShowsViewHeight = [CustomString heightForString:self.orderView.selScreenConditionLabel.text textFont:ElevenTypeface textWidth:ScreenW - 16 - 16 - 33 - 16] + 18;
    [self.orderView.screenShowsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(screenShowsViewHeight);
    }];
    [self.orderView.screenShowsView setHidden:NO];
}
// 删除筛选条件
- (void)delScreenBtnAction:(UIButton *)button {
    /** 筛选展示view */
    [self.orderView.screenShowsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@0);
    }];
    [self.orderView.screenShowsView setHidden:YES];
    // 删除筛选条件
    /** 删除选中支付方式 */
    self.saveSelPay = nil;
    /** 删除选中订单类型 */
    self.saveSelOrderClass = nil;
    /** 删除选中服务类型 */
    self.saveSelServiceClass = nil;
    /** 删除开始日期 */
    self.startDataStr = nil;
    /** 删除结束日期 */
    self.endDataStr = nil;
    /** 删除筛选数据 */
    self.filterArray = nil;
    /** 删除选中条件 */
    self.selectedConditionArray = nil;
    /** 开始日期 */
    self.startDataStr = nil;
    /** 结束日期 */
    self.endDataStr = nil;
    // 刷新数据
    [self.orderView.orderTableView.mj_header beginRefreshing];
}
// 更多筛选条件
- (void)screenExistBtnAction:(UIButton *)button {
    FilterConditionViewController *filterConditionVC = [[FilterConditionViewController alloc] init];
    /** 筛选数据 */
    filterConditionVC.filterArray = self.filterArray;
    /** 选中条件 */
    filterConditionVC.selectedConditionArray = self.selectedConditionArray;
    /** 保存选中支付方式 */
    filterConditionVC.saveSelPay = self.saveSelPay;
    /** 保存选中订单类型 */
    filterConditionVC.saveSelOrderClass = self.saveSelOrderClass;
    /** 保存选中服务类型 */
    filterConditionVC.saveSelServiceClass = self.saveSelServiceClass;
    /** 开始日期 */
    filterConditionVC.startDataStr = self.startDataStr;
    /** 结束日期 */
    filterConditionVC.endDataStr = self.endDataStr;
    // 选中回调
    filterConditionVC.makingSelectionBlock = ^(FiterItemModel *saveSelPay, FiterItemModel *saveSelOrderClass, FiterItemModel *saveSelServiceClass, NSString *startDataStr, NSString *endDataStr, NSString *filterConditionStr, NSMutableArray *filterArray, NSMutableArray *selectedConditionArray) {
        /** 筛选展示view */
        self.orderView.selScreenConditionLabel.text = filterConditionStr;
        CGFloat screenShowsViewHeight = [CustomString heightForString:self.orderView.selScreenConditionLabel.text textFont:ElevenTypeface textWidth:ScreenW - 16 - 16 - 33 - 16] + 18;
        [self.orderView.screenShowsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(screenShowsViewHeight);
        }];
        [self.orderView.screenShowsView setHidden:NO];
        // 保存筛选条件
        /** 保存选中支付方式 */
        self.saveSelPay = saveSelPay;
        /** 保存选中订单类型 */
        self.saveSelOrderClass = saveSelOrderClass;
        /** 保存选中服务类型 */
        self.saveSelServiceClass = saveSelServiceClass;
        /** 开始日期 */
        self.startDataStr = startDataStr;
        /** 结束日期 */
        self.endDataStr = endDataStr;
        /** 筛选数据 */
        self.filterArray = filterArray;
        /** 选中条件 */
        self.selectedConditionArray = selectedConditionArray;
        // 刷新数据
        [self.orderView.orderTableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:filterConditionVC animated:YES];
}

#pragma mark - cell点击代理
- (void)orderDidSelectDelegate:(OrderModel *)orderModel {
    OrderInfoViewController *orderInfoVC = [[OrderInfoViewController alloc] init];
    /** 订单编号 */
    orderInfoVC.orderID = [NSString stringWithFormat:@"%ld", orderModel.order_id];
    [self.navigationController pushViewController:orderInfoVC animated:YES];
}


#pragma mark - 布局nav
- (void)orderLayoutNAV {
    if (self.orderNavTitle.length == 0) {
        self.navigationItem.title = self.params[@"nav_title"];
    }else {
        self.navigationItem.title = self.orderNavTitle;
    }
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(orderRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)orderLayoutView {
    /** 订单view */
    self.orderView = [[OrderView alloc] init];
    self.orderView.delegate = self;
    /** 删除筛选展示按钮 */
    [self.orderView.delScreenBtn addTarget:self action:@selector(delScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 添加筛选展示按钮 */
    [self.orderView.screenExistBtn.filterConditionBtn addTarget:self action:@selector(screenExistBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.orderView];
    @weakify(self)
    /** 订单view */
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
