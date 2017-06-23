//
//  CommodityShowStyleViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommodityShowStyleViewController.h"
// table
#import "GJBaseTabelView.h"
#import "CommodityShowStyleDataSource.h"
#import "CommodityShowStyleCell.h"
// 下级控制器
#import "AddCommodityViewController.h"
#import "EditCommodityWholeViewController.h"


@interface CommodityShowStyleViewController ()<UITableViewDelegate, UITableViewDataSource>


/** 客户信息table */
@property (strong, nonatomic) UITableView *commodityShowStyleTable;
/** 客户信息数据 */
@property (strong, nonatomic) CommodityShowStyleDataSource *commodityShowStyleTableDataSource;

@end

@implementation CommodityShowStyleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 马上进入刷新状态
    [self.commodityShowStyleTable.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self commodityShowStyleLayoutView];
    // 网络请求
    [self commodityShowStyleRequestData];
    // 界面赋值
    [self commodityShowStyleAssignment];
}
#pragma mark - 网络请求
- (void)commodityShowStyleRequestData {
    // 下拉刷新
    @weakify(self)
    self.commodityShowStyleTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        /*/index.php?c=goods&a=list&v=1
         provider_id 	int 	是 	服务id
         goods_category_id 	int 	否 	商品分类id，(获取某类商品中必传)
         status 	int 	是 	0-下架 1-在售 2-全部（为了支持旧版，新版必须传）
         start 	int 	否 	列表开始位置,默认为0
         pageSize 	int 	否 	每页显示条数,不传则显示所有  */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"goods_category_id"] = [NSString stringWithFormat:@"%ld", self.commodityTypeModel.goods_category_id]; // 商品分类id
        params[@"status"] = [NSString stringWithFormat:@"%ld", self.status]; // 0-下架 1-在售 2-全部
        // 网络请求
        [self.commodityShowStyleTableDataSource commodityRefreshRequestData:self.commodityShowStyleTable params:params viewController:self success:^(NSInteger arrayCount) {
            // 移除无数据视图
            [self removeNoDataView];
            if (arrayCount == 0) {
                // 判断是否有数据
                if (arrayCount == 0) {
                    [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                        [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(self.commodityShowStyleTable.mas_centerX);
                            make.centerY.equalTo(self.commodityShowStyleTable.mas_centerY);
                            make.top.equalTo(noImage.mas_top);
                            make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                            make.width.mas_equalTo(ScreenW);
                        }];
                    }];
                }
            }
        }];
    }];
    // 上拉加载
    self.commodityShowStyleTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /*/index.php?c=goods&a=list&v=1
         provider_id 	int 	是 	服务id
         goods_category_id 	int 	否 	商品分类id，(获取某类商品中必传)
         status 	int 	是 	0-下架 1-在售 2-全部（为了支持旧版，新版必须传）
         start 	int 	否 	列表开始位置,默认为0
         pageSize 	int 	否 	每页显示条数,不传则显示所有  */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"goods_category_id"] = [NSString stringWithFormat:@"%ld", self.commodityTypeModel.goods_category_id]; // 商品分类id
        params[@"status"] = [NSString stringWithFormat:@"%ld", self.status]; // 0-下架 1-在售 2-全部
        // 网络请求
        [self.commodityShowStyleTableDataSource commodityLoadRequestData:self.commodityShowStyleTable params:params viewController:self success:^{
            
        }];
    }];
}

#pragma mark - 按钮点击方法
/** 上架 */
- (void)serviceCommodityShelvesBtnAction:(UIButton *)button {
    [AlertAction determineStayLeft:self title:@"温馨提示" message:@"上架后本服务将在用户端显示！是否确认上架？" determineBlock:^{
        // 首先获取到要被上架的商家服务商品
        CommodityShowStyleModel *commodityShowModel = self.commodityShowStyleTableDataSource.rowArray[button.tag];
        /*/index.php?c=goods&a=off&v=1
         goods_id 	int 	是 	商品id
         staff_user_id 	int 	是 	登录者id   */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"goods_id"] = [NSString stringWithFormat:@"%ld", commodityShowModel.goods_id]; // 服务商服务id(服务商服务商品列表返回的ps_id)
        params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id登录者id
        [self.commodityShowStyleTableDataSource shelvesServiceParams:params success:^{
            // 下架数组中的元素
            [self.commodityShowStyleTableDataSource.rowArray removeObjectAtIndex:button.tag];
            // 刷新
            [self.commodityShowStyleTable reloadData];
            // 移除无数据页面
            [self removeNoDataView];
            if (self.commodityShowStyleTableDataSource.rowArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.commodityShowStyleTable.mas_centerX);
                        make.centerY.equalTo(self.commodityShowStyleTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }
        }];
    }];
}
/** 下架 */
- (void)serviceCommodityTheShelfBtnAction:(UIButton *)button {
    [AlertAction determineStayLeft:self title:@"温馨提示" message:@"下架后本服务将不再用户端显示！是否确认下架？" determineBlock:^{
        // 首先获取到要被下架的商家服务商品
        CommodityShowStyleModel *commodityShowModel = self.commodityShowStyleTableDataSource.rowArray[button.tag];
        /*/index.php?c=goods&a=off&v=1
         goods_id 	int 	是 	商品id
         staff_user_id 	int 	是 	登录者id   */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"goods_id"] = [NSString stringWithFormat:@"%ld", commodityShowModel.goods_id]; // 服务商服务id(服务商服务商品列表返回的ps_id)
        params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id登录者id
        [self.commodityShowStyleTableDataSource deleServiceParams:params success:^{
            // 下架数组中的元素
            [self.commodityShowStyleTableDataSource.rowArray removeObjectAtIndex:button.tag];
            // 刷新
            [self.commodityShowStyleTable reloadData];
            // 移除无数据页面
            [self removeNoDataView];
            if (self.commodityShowStyleTableDataSource.rowArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.commodityShowStyleTable.mas_centerX);
                        make.centerY.equalTo(self.commodityShowStyleTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }
        }];
    }];
}
#pragma mark - 界面赋值
- (void)commodityShowStyleAssignment {
    
}

#pragma mark - 布局视图
- (void)commodityShowStyleLayoutView {
    @weakify(self)
    /** 客户信息table */
    self.commodityShowStyleTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.commodityShowStyleTableDataSource = [[CommodityShowStyleDataSource alloc] init];
    self.commodityShowStyleTable.dataSource = self;
    self.commodityShowStyleTable.delegate = self;
    self.commodityShowStyleTable.backgroundColor = CLEARCOLOR;
    self.commodityShowStyleTable.rowHeight = 72;
    [self.view addSubview:self.commodityShowStyleTable];
    [self.commodityShowStyleTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    // tableview高度随数据高度变化而变化
    [self.commodityShowStyleTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // table头部view
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 9)];
    self.commodityShowStyleTable.tableHeaderView = tableHeaderView;
}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commodityShowStyleTableDataSource.rowArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"BusinessProjectTableViewCell";
    CommodityShowStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CommodityShowStyleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.commodityShowModel = self.commodityShowStyleTableDataSource.rowArray[indexPath.row];
    /** 商品状态 0-下架 1-在售 */
    cell.status = self.status;
    /** 上架 */
    cell.shelvesBtn.tag = indexPath.row;
    /** 下架 */
    cell.theShelfBtn.tag = indexPath.row;
    /** 上架 */
    [cell.shelvesBtn addTarget:self action:@selector(serviceCommodityShelvesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 下架 */
    [cell.theShelfBtn addTarget:self action:@selector(serviceCommodityTheShelfBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 分店不能编辑，商品信息
    if (self.merchantInfo.is_initial_provider == 1) { // 总店
        CommodityShowStyleModel *commodityShowModel = self.commodityShowStyleTableDataSource.rowArray[indexPath.row];
        EditCommodityWholeViewController *editCommodityWholeVC = [[EditCommodityWholeViewController alloc] init];
        editCommodityWholeVC.commodityShowModel = commodityShowModel;
        [self.navigationController pushViewController:editCommodityWholeVC animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
