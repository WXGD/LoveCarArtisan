//
//  PendOrderViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 17/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderGoodsModel.h"
#import "PendOrderCell.h"
#import "PendOrderModel.h"
// 下级控制器
#import "PendOrderViewController.h"
#import "AffirmOrderViewController.h"
#import "CashierViewController.h"

@interface PendOrderViewController () <UITableViewDelegate,
                                       UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableVi;
/** 订单数据 */
@property(strong, nonatomic) NSMutableArray *pendOrderArray;
@end

@implementation PendOrderViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // 布局导航
  [self pendOrderLayoutNAV];
  // 布局视图
  [self pendOrderLayoutView];
  // 数据请求
  [self pendOrderRequestData];
}
#pragma mark - 布局视图
- (void)pendOrderLayoutView {
    _tableVi = [[UITableView alloc] init];
    _tableVi.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableVi.delegate = self;
    _tableVi.dataSource = self;
    _tableVi.rowHeight = UITableViewAutomaticDimension;
    _tableVi.estimatedRowHeight = 60;
    _tableVi.backgroundColor = CLEARCOLOR;
    [self.view addSubview:_tableVi];
    @weakify(self)
    /** 服务商 */
    [self.tableVi mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
#pragma mark - 网络请求
- (void)pendOrderRequestData {
  PendOrderModel *orderModel = [[PendOrderModel alloc] init];
  // 下拉刷新
  @weakify(self) self.tableVi.mj_header =
      [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求

        [orderModel
            orderRefreshRequestData:self.tableVi
                             params:params
                     viewController:self
                            success:^(NSMutableArray *orderArray) {
                              // 移除无数据视图
                              [self removeNoDataView];
                              // 移除所有数据
                              [self.pendOrderArray removeAllObjects];
                              // 判断是否有数据
                              if (orderArray.count == 0) {
                                [self showNoDataView:^(UILabel *noLabel,
                                                       UIImageView *noImage) {
                                  [noLabel mas_remakeConstraints:^(
                                               MASConstraintMaker *make) {
                                    make.centerX.equalTo(
                                        self.tableVi.mas_centerX);
                                    make.centerY.equalTo(
                                        self.tableVi.mas_centerY);
                                    noLabel.text = @"暂无挂单";
                                    noImage.image =
                                        [UIImage imageNamed:@"pendorder_zero"];
                                  }];
                                }];
                              } else {
                                self.pendOrderArray = orderArray;
                              }
                              [self.tableVi reloadData];

                            }];
      }];
  // 上拉加载
  self.tableVi.mj_footer =
      [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求
        [orderModel
            orderLoadRequestData:self.tableVi
                          params:params
                  viewController:self
                         success:^(NSMutableArray *orderArray) {
                           [self.pendOrderArray addObjectsFromArray:orderArray];
                           [self.tableVi reloadData];
                         }];
      }];
  // 马上进入刷新状态
  [self.tableVi.mj_header beginRefreshing];
}
#pragma mark - 布局nav
- (void)pendOrderLayoutNAV {
  self.navigationItem.title = @"挂单"; // self.orderNavTitle;
  //  self.navigationItem.rightBarButtonItem =
  //      [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"]
  //                                       style:UIBarButtonItemStyleDone
  //                                      target:self
  //                                      action:@selector(orderRightBarBtnAction)];
}
#pragma mark - tableviewDegate、DataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return _pendOrderArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  static NSString *cellID = @"PendOrderCell";
  PendOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  if (!cell) {
    cell = [[NSBundle mainBundle] loadNibNamed:@"PendOrderCell"
                                         owner:nil
                                       options:nil][0];
  }
  cell.indP = indexPath;
  cell.deletependOrderClick =
      ^(PendOrderModel *pendOrderModel, NSIndexPath *indP) {
        //删除挂单
        [self alertActionDelete:pendOrderModel andIndexPath:indP];

      };
  cell.confirmCashClick = ^(PendOrderModel *pendOrderModel, NSIndexPath *indP) {
      //确认收银
      AffirmOrderViewController *affirmOrderVC = [[AffirmOrderViewController alloc] init];
      /** 用户手机号 */
      affirmOrderVC.userPhone = pendOrderModel.mobile;
      /** 用户车牌号 */
      affirmOrderVC.userPln = pendOrderModel.car_plate_no;
      /** 服务师傅 */
      MerchantInfoModel *merchantModel = [[MerchantInfoModel alloc] init];
      merchantModel.staff_user_id = [NSString stringWithFormat:@"%ld", pendOrderModel.sale_user_id];
      affirmOrderVC.serviceMasterModel = merchantModel;
      /** 服务商品 */
      affirmOrderVC.goodsArray = (NSMutableArray *)pendOrderModel.detail;
      /** 订单总价 */
      affirmOrderVC.orderTotal = pendOrderModel.total_price;
      /** 行驶里程 */
      affirmOrderVC.mileage = pendOrderModel.mileage;
      /** 下一次保养时间 */
      affirmOrderVC.nextMaintain = pendOrderModel.next_maintain;
      /** 购物车记录 */
      affirmOrderVC.cartID = pendOrderModel.cart_id;
      /** 订单时间 */
      affirmOrderVC.orderTime = pendOrderModel.create_time;
      /** 页面来源 */
      affirmOrderVC.viewSource = PendOrderAffirmOrderViewSource;
      [self.navigationController pushViewController:affirmOrderVC animated:YES];
  };
//  PendOrderModel *pendOrderModel = [[PendOrderModel alloc] init];
  cell.model = _pendOrderArray[indexPath.section];
  return cell;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取cell模型
    PendOrderModel *pendOrderModel = _pendOrderArray[indexPath.section];
    // 收银页
    CashierViewController *cashierVC = [[CashierViewController alloc] init];
    /** 用户手机号 */
    cashierVC.userPhone = pendOrderModel.mobile;
    /** 用户车牌号 */
    cashierVC.userPln = pendOrderModel.car_plate_no;
    /** 服务师傅 */
    MerchantInfoModel *merchantModel = [[MerchantInfoModel alloc] init];
    merchantModel.staff_user_id = [NSString stringWithFormat:@"%ld", pendOrderModel.sale_user_id];
    cashierVC.serviceMasterModel = merchantModel;
    /** 服务商品 */
    cashierVC.goodsArray = (NSMutableArray *)pendOrderModel.detail;
    /** 订单总价 */
    cashierVC.shoppingCartTotal = pendOrderModel.total_price;
    /** 行驶里程 */
    cashierVC.mileage = pendOrderModel.mileage;
    /** 下一次保养时间 */
    cashierVC.nextMaintain = pendOrderModel.next_maintain;
    /** 购物车记录 */
    cashierVC.cartID = pendOrderModel.cart_id;
    /** 订单时间 */
    cashierVC.orderTime = pendOrderModel.create_time;
    /** 页面来源 */
    cashierVC.cashierVCSource = PendOrderCashierViewSource;
    [self.navigationController pushViewController:cashierVC animated:YES];
}

#pragma mark - 删除确认弹出框
- (void)alertActionDelete:(PendOrderModel *)mo
             andIndexPath:(NSIndexPath *)indP {
  [AlertAction determineStayLeft:self
                           title:@"提示"
                           admit:@"确定"
                         noadmit:@"取消"
                         message:@"您确定删除该挂单吗?"
                      admitBlock:^{
                        [self deleteCartList:mo andIndexPath:indP];
                      }
                    noadmitBlock:nil];
}

#pragma mark - 删除请求
- (void)deleteCartList:(PendOrderModel *)mo andIndexPath:(NSIndexPath *)indP {
  //- (void)deleteCartList {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"cart_id"] = @(mo.cart_id); // 购物车列表Id
  NSString *URL = [NSString
      stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"cart", @"del", APIEdition];
    
    [TPNetRequest POST:URL parameters:params ProgressHUD:@"删除挂单" falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]]
             isEqual:@"0"]) {
            // 删除成功
            [_pendOrderArray removeObjectAtIndex:indP.section];
            [_tableVi reloadData];
        } else {
            // 失败
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
    
    
    
    

}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
