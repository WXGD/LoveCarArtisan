//
//  CarBrandListViewController.m
//  CarRepairFactory
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarBrandListViewController.h"
//#import "BrandModel.h"
#import "CarBrandHandle.h"
#import "HotView.h"
#import "CarBrandListTableViewCell.h"

@interface CarBrandListViewController ()<UITableViewDelegate, UITableViewDataSource, HotViewDelegate>
/** 分组数据 */
@property (strong, nonatomic) NSMutableArray *groupArray;
/** 所有模型数据 */
@property (strong, nonatomic) NSArray *modelSectionArray;
/** tableview */
@property (strong, nonatomic) UITableView *carBrandListTable;
/** 热门车品牌 */
@property (strong, nonatomic) HotView *hotView;

@end

@implementation CarBrandListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 布局视图
    [self carBrandListLayoutView];
    // 布局nav
    [self carBrandListLayoutNav];
    // 界面赋值
    [self carBrandListViewAssignment];
}
#pragma mark - 界面赋值
- (void)carBrandListViewAssignment {
    // 标题
    self.navigationItem.title = @"汽车品牌";
    // 请求所有品牌数据
    CarBrandHandle *carBrandHandle = [CarBrandHandle sharedInstance];
    carBrandHandle.carBrandNetSucBlock = ^(NSMutableArray *groupArray, NSArray *modelSectionArray, NSArray *hotBrandArray) {
        // 获取车辆品牌数据
        self.modelSectionArray = modelSectionArray;
        self.groupArray = groupArray;
        // 刷新品牌数据展示
        [self.carBrandListTable reloadData];
        // 获取热门品牌数据
        self.hotView.hotDataArray = hotBrandArray;
        // 展示热门品牌数据
        [self.hotView hotBrandLayoutView];
    };
    if (carBrandHandle.modelSectionArray.count != 0) {
        // 获取车辆品牌数据
        self.modelSectionArray = carBrandHandle.modelSectionArray;
        self.groupArray = carBrandHandle.groupArray;
        // 刷新品牌数据展示
        [self.carBrandListTable reloadData];
        // 获取热门品牌数据
        self.hotView.hotDataArray = carBrandHandle.hotBrandArray;
        // 展示热门品牌数据
        [self.hotView hotBrandLayoutView];
    }
}


#pragma mark - 按钮点击方法
// 车系view轻扫手势，用来回收车系view
- (void)carSystemViewSwipeGestureRecognizer {
    [UIView animateWithDuration:1 animations:^{
        self.carSystemView.frame = CGRectMake(ScreenW, 0, 0, ScreenH);
    }];
}
// 品牌cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    @weakify(self)
    [UIView animateWithDuration:1 animations:^{
        @strongify(self)
        // 获取点击的数据模型
        NSArray *array = self.modelSectionArray[indexPath.section];
        CarBrandModel *brandModel = array[indexPath.row];
        self.carSystemView.carBrandSystem = brandModel;
        self.carSystemView.frame = CGRectMake(100, 0, ScreenW - 100, ScreenH);
    }];
}
// 热门品牌点击
- (void)hotViewBtnAction:(CarBrandModel *)brandModel {
    @weakify(self)
    [UIView animateWithDuration:1 animations:^{
        @strongify(self)
        self.carSystemView.carBrandSystem = brandModel;
        self.carSystemView.frame = CGRectMake(100, 0, ScreenW - 100, ScreenH);
    }];
}
// 返回按钮点击方法
- (void)carBrandListLeftBarBtnAction {
//    if (self.navigationController.viewControllers.count > 2 && ![[self.navigationController.viewControllers objectAtIndex:2] isKindOfClass:[MyCarViewController class]]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}
#pragma mark - 布局nav
- (void)carBrandListLayoutNav {
    self.navigationItem.title = @"车辆信息";
    // 左边边按钮
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(carBrandListLeftBarBtnAction)];
}

#pragma mark - 布局视图
- (void)carBrandListLayoutView {
    // 列表视图
    self.carBrandListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.carBrandListTable.delegate = self;
    self.carBrandListTable.dataSource = self;
    [self.view addSubview:self.carBrandListTable];
    [self.carBrandListTable registerNib:[UINib nibWithNibName:@"CarBrandListTableViewCell" bundle:nil] forCellReuseIdentifier:@"carBrandListCell"];
    // 热门车品牌
    self.hotView = [HotView loadBlueViewFromXIB];
    self.hotView.delegate = self;
    self.hotView.frame = CGRectMake(0, 0, ScreenW, 150);
    self.carBrandListTable.tableHeaderView = self.hotView;
    // 车系
    self.carSystemView = [[CarSystemView alloc] initWithFrame:CGRectMake(ScreenW, 0, 0, ScreenH)];
    @weakify(self)
    self.carSystemView.carSystemBlack = ^(CWFUserCarModel *selectCarSystem) {
        @strongify(self)
        if (self.carSystemBlack) {
            self.carSystemBlack(selectCarSystem);
        }
    };
    [self.view addSubview:self.carSystemView];
    // 给车系view添加轻扫收拾
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(carSystemViewSwipeGestureRecognizer)];
    [self.carSystemView addGestureRecognizer:swipe];
}
#pragma mark - TableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelSectionArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.modelSectionArray[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"carBrandListCell";
    CarBrandListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CarBrandListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSArray *array = self.modelSectionArray[indexPath.section];
    CarBrandModel *brandModel = array[indexPath.row];
    cell.brandModel = brandModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    customView.backgroundColor = VCBackground;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, customView.frame.size.width, customView.frame.size.height)];
    headerLabel.textColor = GrayH1;
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.text = self.groupArray[section];
    [customView addSubview:headerLabel];
    return customView;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.groupArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
