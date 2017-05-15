//
//  HomePageViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePageViewController.h"
// view
#import "HomePageView.h"
#import "DropdownMenu.h"
#import "SearchView.h"
// 下级控制器
#import "UserViewController.h"
#import "ServiceViewController.h"
#import "CashierViewController.h"
#import "PhotographViewController.h"
#import "UserCardViewController.h"
#import "OrderViewController.h"
#import "ShortcutViewController.h"
#import "ReportTabBarViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "MarketingViewController.h"
#import "CommercialCityWebViewController.h"
#import "PendOrderViewController.h"
#import "MyAccountViewController.h"

// 模型
#import "BannerModel.h"
#import "ShopRealtimeModel.h"
#import "UpdateReminderModel.h"
#import "ServiceCategoryHandle.h"
#import "ServiceMasterHandle.h"
#import "CityModel.h"
#import "OrderClassHandle.h"
#import "PendOrderModel.h"

@interface HomePageViewController ()<DropdownMenuDelegate>

/** 首页view */
@property (strong, nonatomic) HomePageView *homePageView;
/** 搜索框view */
@property (strong, nonatomic) SearchView *search;

@end

@implementation HomePageViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 请求时时数据,马上进入刷新状态
    [self.homePageView.homePageScrollView.mj_header beginRefreshing];
    // 网络请求,请求banner数据
    [self homePageRequestBannerData];
    // 请求挂单数据
    [self pendOrderRequestData];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self homePageLayoutNAV];
    // 布局视图
    [self homePageLayoutView];
    // 网络请求,请求时时数据
    [self homePageRepuestShowData];
    // 网络请求,版本更新
    [UpdateReminderModel updateReminderAlreadyNewest:nil];
    // 加载服务类别数据
    [ServiceCategoryHandle sharedInstance];
    // 服务师傅数据
    [ServiceMasterHandle sharedInstance];
    // 请求城市列表
    [CityModel establishCitySqliteForm];
    // 请求订单类型数据
    [OrderClassHandle sharedInstance];
}
#pragma mark - 网络请求
// 请求banner数据
- (void)homePageRequestBannerData {
    /*/index.php?c=app_config&a=list&v=1
     position_type 	int 	否 	展示位置 ,默认为1 ，1-banner  */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [BannerModel requestBannerDataParams:params success:^(NSMutableArray *bannerArray) {
        [self.homePageView.bannerView bannerLayoutViewModelArray:(NSArray *)bannerArray];
    }];
}
// 请求时时数据
- (void)homePageRepuestShowData {
    // 下拉刷新
    @weakify(self)
    self.homePageView.homePageScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        /*/index.php?c=order&a=statistic_amount&v=1
         provider_id 	int 	是 	商家id
         staff_user_id 	int 	是 	登录者id      */
        // 网络请求参数
        NSMutableDictionary *parame = [NSMutableDictionary dictionary];
        parame[@"provider_id"] = self.merchantInfo.provider_id; // 商家编号；
        parame[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id；
        /** 店铺时时数据 */
        [ShopRealtimeModel shopRealtimeRequestParame:parame success:^(ShopRealtimeModel *shopRealtime) {
            // 界面赋值
            [self homePageAssignment:shopRealtime];
        } scrollView:self.homePageView.homePageScrollView noLogin:nil failure:nil];
    }];
    // 马上进入刷新状态
    [self.homePageView.homePageScrollView.mj_header beginRefreshing];
}
//请求挂单数据
- (void)pendOrderRequestData {
    // 拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    [PendOrderModel judgeCartDataParams:parameters success:^(BOOL cart) {
        self.homePageView.btnPendOrder.selected = cart;
    }];
}

#pragma mark - 按钮点击方法
// nav右边按钮
- (void)homePageRightBarBtnAction {
    // 创建下拉菜单
    DropdownMenu *menu = [DropdownMenu menu];
    menu.delegate = self;
    // 设置内容
    ShortcutViewController *shortcutVC = [[ShortcutViewController alloc] init];
    shortcutVC.view.height = 150;
    shortcutVC.view.width = 150;
    menu.contentController = shortcutVC;
    shortcutVC.shortcutNav = self.navigationController;
    shortcutVC.ShortcutBtnActionBlock = ^() {
        [menu dismiss];
    };
    // 显示
    [menu showFrom:self.search];
}
// 搜索view点击按钮
- (void)searchViewBtnAction:(UIButton *)button {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:searchVC] animated:nil completion:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
}
#pragma mark - 首页功能选择按钮
- (void)homePageBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 扫一扫 */
        case ScanBtnAction: {
            PhotographViewController *photographVC = [[PhotographViewController alloc] init];
            photographVC.photographViewType = CashierAssignment;
            [self.navigationController pushViewController:photographVC animated:YES];
            break;
        }
            /** 收款 */
        case ReceiptBtnAction: {
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            [self.navigationController pushViewController:cashierVC animated:YES];
            break;
        }
            /** 服务管理 */
        case ServiceManageBtnAction: {
            ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
            [self.navigationController pushViewController:serviceVC animated:NO];
            break;
        }
            /** 会员卡 */
        case UserCardBtnAction: {
            UserCardViewController *userCardVC = [[UserCardViewController alloc] init];
            [self.navigationController pushViewController:userCardVC animated:YES];
            break;
        }
            /** 客户 */
        case CustomerBtnAction: {
            UserViewController *queryUserVC = [[UserViewController alloc] init];
            [self.navigationController pushViewController:queryUserVC animated:NO];
            break;
        }
            /** 订单 */
        case OrderBtnAction: {
            OrderViewController *orderVC = [[OrderViewController alloc] init];
            orderVC.orderNavTitle = @"订单";
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        }
            /**  营销 */
        case MarketingBtnAction: {
            MarketingViewController *marketingVC = [[MarketingViewController alloc] init];
            [self.navigationController pushViewController:marketingVC animated:YES];
            break;
        }
            /** 报表 */
        case ReportBtnAction: {
            CommercialCityWebViewController *commercialCityWebVC = [[CommercialCityWebViewController alloc] init];
            NSString *WEBURL = [NSString stringWithFormat:@"%@analyse/dataAnalysis.html?provider_id=%@", WEBAPI, self.merchantInfo.provider_id];
            commercialCityWebVC.webUrl = WEBURL;
            [self.navigationController pushViewController:commercialCityWebVC animated:YES];
            break;
        }
            /** 商城 */
        case CommercialCityBtnAction: {
            CommercialCityWebViewController *commercialCityWebVC = [[CommercialCityWebViewController alloc] init];
            NSString *WEBURL = [NSString stringWithFormat:@"%@%@", MallsWEBAPI, @"#/1/2?_k=l01xoq"];
            commercialCityWebVC.webUrl = WEBURL;
            [self.navigationController pushViewController:commercialCityWebVC animated:YES];
            break;
        }
            /** 挂单 */
        case PendOrderBtnActio: {
            PendOrderViewController *pendVC = [[PendOrderViewController alloc] init];
            [self.navigationController pushViewController:pendVC animated:YES];
            break;
        }
            /** 账户 */
        case AccountBtnAction: {
            MyAccountViewController *myAccountVC = [[MyAccountViewController alloc] init];
            [self.navigationController pushViewController:myAccountVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 界面赋值
- (void)homePageAssignment:(ShopRealtimeModel *)shopRealtime {
    /** 营业额 */
    self.homePageView.showDataView.turnoverLabel.text = [NSString stringWithFormat:@"%.2f", shopRealtime.amount];
    /** 消费人数 */
    self.homePageView.showDataView.csmPleNumLabel.text = [NSString stringWithFormat:@"%ld", (long)shopRealtime.user_count];
    /** 订单数 */
    self.homePageView.showDataView.orderNumLabel.text = [NSString stringWithFormat:@"%ld", (long)shopRealtime.order_count];
}


#pragma mark - 布局nav
- (void)homePageLayoutNAV {
    // 搜索框view
    self.search = [[SearchView alloc] init];
    self.search.isSearch = YES;
    self.search.isSearchWidth = YES;
    [self.search.viewBtn addTarget:self action:@selector(searchViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.search;
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(homePageRightBarBtnAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(homePageRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)homePageLayoutView {
    /** 首页view */
    self.homePageView = [[HomePageView alloc] init];
    /** 扫一扫 */
    [self.homePageView.showDataView.scanBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 收款 */
    [self.homePageView.showDataView.cashierBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 服务管理 */
    [self.homePageView.serviceModuleView.serviceBtn.moduleBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 会员卡 */
    [self.homePageView.serviceModuleView.membershipCardBtn.moduleBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 客户 */
    [self.homePageView.serviceModuleView.customerBtn.moduleBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /**  营销 */
    [self.homePageView.serviceModuleView.marketingBtn.moduleBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 报表 */
    [self.homePageView.serviceModuleView.reportBtn.moduleBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 订单 */
    [self.homePageView.serviceModuleView.orderBtn.moduleBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 商城 */
    [self.homePageView.serviceModuleView.commercialCityBtn.moduleBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 挂单 */
    [self.homePageView.btnPendOrder addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 账户 */
    [self.homePageView.serviceModuleView.accountBtn.moduleBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.homePageView];
    @weakify(self)
    [self.homePageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
