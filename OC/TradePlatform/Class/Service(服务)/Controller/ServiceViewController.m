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
// 单利
#import "ServiceCategoryHandle.h"

@interface ServiceViewController ()

@property (nonatomic, strong) NSMutableArray *commodityTypeArray;
/** 0-下架 1-在售 2-全部（ */
@property (nonatomic, assign) NSInteger status;

@end

@implementation ServiceViewController

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
    self.commodityTypeArray = [ServiceCategoryHandle sharedInstance].serviceWholeCategoryArray;
    [self.magicView reloadData];
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (self.commodityTypeArray.count == 0) {
        [ServiceCategoryHandle sharedInstance].requestCategorySuccessBlock = ^ () {
            self.commodityTypeArray = [ServiceCategoryHandle sharedInstance].serviceWholeCategoryArray;
            [self.magicView reloadData];
        };
    }

//    // 获取商户信息user
//    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
//    // 请求商品类型
//    /*/index.php?c=goods_category&a=list&v=1
//     provider_id 	int 	是 	服务商id
//     start 	int 	否 	记录开始位置,默认为0
//     pageSize 	int 	否 	每页显示条数，默认为0 (代表全部)     */
//    // 网络请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"provider_id"] = merchantInfo.provider_id; // 服务商id
//    [ServiceProviderModel requestServiceTypeListParams:params success:^(NSMutableArray *commodityTypeArray) {
//        self.commodityTypeArray = commodityTypeArray;
//        [self.magicView reloadData];
//    }];
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
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(serviceRightBarButtonItmeAction)];
}

#pragma mark - 布局视图
- (void)serviceLayoutView {
    self.magicView.navigationColor = WhiteColor;
    self.magicView.sliderColor = ThemeColor;
    self.magicView.sliderWidth = 30;
    self.magicView.separatorHidden = YES;
}
#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (ServiceProviderModel *commodityType in self.commodityTypeArray) {
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
    commodityShowStyleVC.commodityTypeModel = self.commodityTypeArray[pageIndex];
    commodityShowStyleVC.status = self.status;
    return commodityShowStyleVC;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
