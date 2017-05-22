//
//  StoreViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreCell.h"
#import "StoreModel.h"
// 下级页面
#import "StoreInfoViewController.h"

@interface StoreViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 门店列表 */
@property (nonatomic, strong) UITableView *storeTable;
/** 门店数据源 */
@property (nonatomic, strong) NSMutableArray *storeArr;
@end

@implementation StoreViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 马上进入刷新状态
    [self.storeTable.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self storeLayoutNAV];
    // 布局视图
    [self storeLayoutView];
    // 网络请求
    [self storeRequestData];
}
#pragma mark - 网络请求
- (void)storeRequestData {
    StoreModel *storeModel = [[StoreModel alloc] init];
    // 下拉刷新
    @weakify(self) self.storeTable.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求
        
        [storeModel
         storeRefreshRequestData:self.storeTable
         params:params
         viewController:self
         success:^(NSMutableArray *orderArray) {
             // 移除无数据视图
             [self removeNoDataView];
             // 移除所有数据
             [self.storeArr removeAllObjects];
             // 判断是否有数据
             if (orderArray.count == 0) {
                 [self showNoDataView:^(UILabel *noLabel,
                                        UIImageView *noImage) {
                     [noLabel mas_remakeConstraints:^(
                                                      MASConstraintMaker *make) {
                         make.centerX.equalTo(
                                              self.storeTable.mas_centerX);
                         make.centerY.equalTo(
                                              self.storeTable.mas_centerY);
                         noLabel.text = @"暂无挂单";
                         noImage.image =
                         [UIImage imageNamed:@"pendorder_zero"];
                     }];
                 }];
             } else {
                 self.storeArr = orderArray;
             }
             [self.storeTable reloadData];
             
         }];
    }];
    // 上拉加载
    self.storeTable.mj_footer =
    [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求
        [storeModel
         storeLoadRequestData:self.storeTable
         params:params
         viewController:self
         success:^(NSMutableArray *orderArray) {
             [self.storeArr addObjectsFromArray:orderArray];
             [self.storeTable reloadData];
         }];
    }];
    
}
#pragma mark - 布局nav
- (void)storeLayoutNAV {
    self.navigationItem.title = @"门店";
    // 左边
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_account_account_bank"] style:UIBarButtonItemStyleDone target:self action:@selector(bankCardManagement)];
}
#pragma mark - 布局视图
- (void)storeLayoutView {
    /** 门店 */
    _storeTable = [[UITableView alloc] init];
    _storeTable.delegate = self;
    _storeTable.dataSource = self;
    _storeTable.rowHeight = 110;
    _storeTable.backgroundColor = VCBackground;
    [self.view addSubview:_storeTable];
    @weakify(self)
    /** 挂单 */
    [self.storeTable mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
#pragma mark - tableviewDegate、DataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _storeArr.count;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return _storeArr.count;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"StoreCell";
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.storeModel = _storeArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取cell模型
    StoreModel *storeModel = _storeArr[indexPath.row];
    StoreInfoViewController *storeInfoVC = [[StoreInfoViewController alloc] init];
    storeInfoVC.storeModel = storeModel;
    [self.navigationController pushViewController:storeInfoVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
