//
//  OrderViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderView.h"
// 下级控制器
#import "OrderInfoViewController.h"
// 数据模型
#import "OrderTypeListModel.h"

@interface OrderViewController ()<OrderCellSelectDelegate>

/** 订单view */
@property (strong, nonatomic) OrderView *orderView;
/** 订单类型数据 */
@property (strong, nonatomic) NSMutableArray *orderTypeListArray;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self orderLayoutNAV];
    // 请求订单类型
    [self requestOrderTypeData];
}
#pragma mark - 网络请求
- (void)orderRequestData {
    /*/index.php?c=order&a=list&v=1
     staff_user_id 	int 	否 	登陆者id(商户app必传,用户自己获取时不传)
     provider_id 	int 	是 	服务商id
     order_category_id 	int 	否 	订单类型id，默认为0（代表全部）
     provider_user_id 	int 	否 	用户id,(获取用户消费记录时必传)
     order_status 	int 	否 	订单状态，默认为0（代表全部）
     sale_user_id 	int 	否 	服务师傅id,默认为0（代表全部）    */
    // 下拉刷新
    @weakify(self)
    self.orderView.orderTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"order_category_id"] = [NSString stringWithFormat:@"%ld", self.orderView.orderPayClassModel.order_category_id]; // 订单类型，默认为0（代表全部）
        params[@"order_status"] = [NSString stringWithFormat:@"%ld", self.orderView.orderPayStateModel.chioceCategoriesId]; // 订单状态，默认为0（代表全部）
        params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfoMode.provider_user_id]; // 用户编号
        params[@"sale_user_id"] = self.orderView.currentMerchantModel.staff_user_id; // 服务师傅id,默认为0（代表全部）
        // 网络请求
        [self.orderView.orderDataSource orderRefreshRequestData:self.orderView.orderTable params:params viewController:self success:^(NSInteger arrayCount) {
            // 移除无数据视图
            [self removeNoDataView];
            // 判断是否有数据
            if (arrayCount == 0) {
                [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.orderView.orderTable.mas_centerX);
                        make.centerY.equalTo(self.orderView.orderTable.mas_centerY);
                    }];
                }];
            }
        }];
    }];
    // 上拉加载
    self.orderView.orderTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"order_category_id"] = [NSString stringWithFormat:@"%ld", self.orderView.orderPayClassModel.order_category_id]; // 订单类型，默认为0（代表全部）
        params[@"order_status"] = [NSString stringWithFormat:@"%ld", self.orderView.orderPayStateModel.chioceCategoriesId]; // 订单状态，默认为0（代表全部）
        params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfoMode.provider_user_id]; // 用户编号
        params[@"sale_user_id"] = self.orderView.currentMerchantModel.staff_user_id; // 服务师傅id,默认为0（代表全部）
        // 网络请求
        [self.orderView.orderDataSource orderLoadRequestData:self.orderView.orderTable params:params viewController:self success:^{
            
        }];
    }];
    // 马上进入刷新状态
    [self.orderView.orderTable.mj_header beginRefreshing];
}

// 请求订单类型
- (void)requestOrderTypeData {
    [OrderTypeListModel requesOrderTypeListDataSuccess:^(NSMutableArray *orderList) {
        self.orderTypeListArray = orderList;
        // 布局视图
        [self orderLayoutView];
        // 下拉刷新，网络请求，请求订单列表
        [self orderRequestData];
        // 界面赋值
        [self orderAssignment];
    }];
}

#pragma mark - 按钮点击方法
//  账户页面按钮点击方法
- (void)orderBtnAction:(UIButton *)button {
    
}
// 订单点击
- (void)orderRowDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *order = [self.orderView.orderDataSource.rowArray objectAtIndex:indexPath.row];
    OrderInfoViewController *orderInfoVC = [[OrderInfoViewController alloc] init];
    orderInfoVC.orderID = order.order_id;
    [self.navigationController pushViewController:orderInfoVC animated:YES];
}
// 修改订单状态或类型
- (void)alertModelChooseActionBoxView {
    // 马上进入刷新状态
    [self.orderView.orderTable.mj_header beginRefreshing];
}

#pragma mark - 界面赋值
- (void)orderAssignment {
    
}
#pragma mark - 布局nav
- (void)orderLayoutNAV {
    self.navigationItem.title = self.orderNavTitle;
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)orderLayoutView {
    /** 账户view */
    self.orderView = [[OrderView alloc] init];
    self.orderView.delegate = self;
    self.orderView.orderPayClassArray = self.orderTypeListArray;
    [self.view addSubview:self.orderView];
    @weakify(self)
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
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
