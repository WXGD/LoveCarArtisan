//
//  ServiceViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServiceViewController.h"
// 下级控制器
#import "CommodityShowStyleViewController.h"
#import "AddCommodityViewController.h"
#import "AdminServiceClassViewController.h"
// 单利
#import "ServiceCategoryHandle.h"
// 阴影框架
#import <QuartzCore/QuartzCore.h>

@interface ServiceViewController ()<AdminServiceClassDelegate>

/** 服务管理模型 */
@property (strong, nonatomic) AdminServiceModel *adminServiceModel;
/** 已经选择的服务 */
@property (strong, nonatomic) NSMutableArray *haveServiceClassArray;
/** 0-下架 1-在售 2-全部（ */
@property (nonatomic, assign) NSInteger status;

@end

@implementation ServiceViewController

#pragma mark - get方法
- (NSMutableArray *)haveServiceClassArray {
    if (!_haveServiceClassArray) {
        _haveServiceClassArray = [[NSMutableArray alloc] init];
    }
    return _haveServiceClassArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self serviceLayoutNAV];
    // 布局视图
    [self serviceLayoutView];
    // 网络请求
    [self serviceRequestData];
}

#pragma mark - 网络请求
- (void)serviceRequestData {
    // 加载服务类别数据
    self.adminServiceModel = [ServiceCategoryHandle sharedInstance].adminServiceModel;
    /** 已经选择的服务 */
    self.haveServiceClassArray = [NSMutableArray arrayWithArray:[ServiceCategoryHandle sharedInstance].serviceWholeCategoryArray];
    // 刷新界面
    [self.magicView reloadData];
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (self.haveServiceClassArray.count == 0) {
        [ServiceCategoryHandle sharedInstance].requestCategorySuccessBlock = ^ () {
            [MBProgressHUD hideHUD];
            // 加载服务类别数据
            self.adminServiceModel = [ServiceCategoryHandle sharedInstance].adminServiceModel;
            /** 已经选择的服务 */
            self.haveServiceClassArray = [NSMutableArray arrayWithArray:[ServiceCategoryHandle sharedInstance].serviceWholeCategoryArray];
            // 刷新界面
            [self.magicView reloadData];
        };
    }
}
#pragma mark - 按钮点击方法
//
- (void)navSegmentedAction:(UISegmentedControl *)segmented {
    // 0-下架 1-在售 2-全部
    switch (segmented.selectedSegmentIndex) {
        case 0: {
            self.status = 1;
            [self.magicView reloadData];
            break;
        }
        case 1: {
            self.status = 0;
            [self.magicView reloadData];
            break;
        }
        default:
            break;
    }
}
- (void)serviceRightBarButtonItmeAction {
    AddCommodityViewController *addCommodityVC = [[AddCommodityViewController alloc] init];
    addCommodityVC.addCommoditySuccessBlock = ^() {
        [self.magicView reloadData];
    };
    [self.navigationController pushViewController:addCommodityVC animated:YES];
}


// 管理服务类别
- (void)subscribeAction {
    AdminServiceClassViewController *adminServiceClassVC = [[AdminServiceClassViewController alloc] init];
    /** 已添加服务类别数据 */
    adminServiceClassVC.haveChosenArray = [NSMutableArray arrayWithArray:self.adminServiceModel.used_goods_category];
    /** 未添加服务类别数据 */
    adminServiceClassVC.notChosenArray = [NSMutableArray arrayWithArray:self.adminServiceModel.unUsed_goods_category];
    /** 管理修改代理 */
    adminServiceClassVC.delegate = self;
    [self.navigationController pushViewController:adminServiceClassVC animated:YES];
}

#pragma mark - 管理修改代理
// 确认修改
- (void)confirmReviseDelegate:(NSMutableArray *)haveChosenArray notChosenArray:(NSMutableArray *)notChosenArray {
//    // 销毁服务类别单利
//    [ServiceCategoryHandle destroyHandle];
//    [MBProgressHUD showMessage:@"加载中..."];
//    // 网络请求
//    [self serviceRequestData];
//    // 刷新界面
//    [self.magicView reloadData];
    /** 已经选择的服务 */
    self.haveServiceClassArray = [NSMutableArray arrayWithArray:haveChosenArray];
    ServiceProviderModel *wholeTypeModel = [[ServiceProviderModel alloc] init];
    wholeTypeModel.goods_category_id = 0;
    wholeTypeModel.name = @"全部";
    [self.haveServiceClassArray insertObject:wholeTypeModel atIndex:0];
    // 刷新界面
    [self.magicView reloadData];
    /** 修改单利数据 */
    // 加载服务类别数据
    [ServiceCategoryHandle sharedInstance].adminServiceModel.used_goods_category = [NSMutableArray arrayWithArray:haveChosenArray];
    [ServiceCategoryHandle sharedInstance].adminServiceModel.unUsed_goods_category = [NSMutableArray arrayWithArray:notChosenArray];
    // 可用服务数组
    [ServiceCategoryHandle sharedInstance].serviceCategoryArray = [NSMutableArray arrayWithArray:haveChosenArray];
    // 添加全部选项的可用服务
    [ServiceCategoryHandle sharedInstance].serviceWholeCategoryArray = [NSMutableArray arrayWithArray:haveChosenArray];
    [[ServiceCategoryHandle sharedInstance].serviceWholeCategoryArray insertObject:wholeTypeModel atIndex:0];
}


#pragma mark - 布局nav
- (void)serviceLayoutNAV {
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"在售",@"下架",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, 150, 28);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = WhiteColor;
    [segmentedControl addTarget:self  action:@selector(navSegmentedAction:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentedControl];
    // 默认选择在售商品展示
    self.status = 1;
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    
    // 获取商户信息user
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    // 分店不能添加商品
    if (merchantInfo.is_initial_provider == 1) { // 总店
        // 右边
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(serviceRightBarButtonItmeAction)];
    }
}

#pragma mark - 布局视图
- (void)serviceLayoutView {
    self.magicView.navigationColor = WhiteColor;
    self.magicView.sliderColor = ThemeColor;
    self.magicView.sliderWidth = 30;
    self.magicView.separatorHidden = YES;
    
    // 获取商户信息user
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    // 判断如果是分店，有管理按钮
    if (merchantInfo.is_initial_provider == 0) {
        // 管理按钮
        UIButton *adminBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 44)];
        [adminBtn setBackgroundColor:WhiteColor];
        [adminBtn setImage:[UIImage imageNamed:@"service_admin"] forState:UIControlStateNormal];
        [adminBtn addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
        self.magicView.rightNavigatoinItem = adminBtn;
        adminBtn.layer.shadowOpacity = 0.5;// 阴影透明度
        adminBtn.layer.shadowColor = GrayH5.CGColor;// 阴影的颜色
        adminBtn.layer.shadowRadius = 3;// 阴影扩散的范围控制
        adminBtn.layer.shadowOffset  = CGSizeMake(-2, 0);// 阴影的范围
    }
}
#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (ServiceProviderModel *commodityType in self.haveServiceClassArray) {
        [titleList addObject:commodityType.name];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:Black forState:UIControlStateNormal];
        menuItem.titleLabel.font = FourteenTypeface;
        [menuItem setTitleColor:ThemeColor forState:UIControlStateSelected];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *recomId = @"serviceVC";
    CommodityShowStyleViewController *commodityShowStyleVC = [magicView dequeueReusablePageWithIdentifier:recomId];
    if (!commodityShowStyleVC) {
        commodityShowStyleVC = [[CommodityShowStyleViewController alloc] init];
    }
    commodityShowStyleVC.commodityTypeModel = self.haveServiceClassArray[pageIndex];
    commodityShowStyleVC.status = self.status;
    return commodityShowStyleVC;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
