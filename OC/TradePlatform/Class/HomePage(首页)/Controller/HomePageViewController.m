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
#import "SearchView.h"
#import "DropdownMenu.h"
// 下级控制器
#import "QueryUserViewController.h"
#import "CommodityShowStyleViewController.h"
#import "CashierViewController.h"
#import "PhotographViewController.h"
#import "UserCardViewController.h"
#import "OrderViewController.h"
#import "ShortcutViewController.h"
#import "LoginViewController.h"
// 数据模型
#import "ShopRealtimeModel.h"
#import "UpdateReminderModel.h"

@interface HomePageViewController ()<DropdownMenuDelegate>

/** 首页view */
@property (strong, nonatomic) HomePageView *homePageView;
/** 搜索框view */
@property (strong, nonatomic) SearchView *search;

@end

@implementation HomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 请求店铺实时数据
    [self homePageRepuestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self homePageLayoutNAV];
    // 布局视图
    [self homePageLayoutView];
    // 版本更新
    [UpdateReminderModel updateReminderAlreadyNewest:nil];
}
#pragma mark - 网络请求
- (void)homePageRepuestData {
    /** 店铺时时数据 */
    self.homePageView.showDataView.showDataView.viceLabel.text = @"正在刷新实时数据";
    [ShopRealtimeModel shopRealtimeRequestSuccess:^(ShopRealtimeModel *shopRealtime) {
        // 界面赋值
        [self homePageAssignment:shopRealtime];
    } noLogin:^{
        /** 店铺时时数据 */
        self.homePageView.showDataView.showDataView.viceLabel.text = @"登陆后可查看";
    } failure:^{
        /** 店铺时时数据 */
        self.homePageView.showDataView.showDataView.viceLabel.text = @"刷新失败，请重新刷新";
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
// nav右边按钮
- (void)homePageLeftBtnAction {
    
}
- (void)homePageBtnAvtion:(UIButton *)button {
    switch (button.tag) {
        /** 扫一扫 */
        case ScanBtnAction: {
            PhotographViewController *photographVC = [[PhotographViewController alloc] init];
            [self.navigationController pushViewController:photographVC animated:YES];
            break;
        }
        /** 收款 */
        case ReceiptBtnAction: {
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            [self.navigationController pushViewController:cashierVC animated:YES];
            break;
        }
        /** 店铺实时数据 */
        case ShowDataBtnAction: {
            // 判断是否登陆
            if (self.merchantInfo.provider_id) {
                // 网络请求
                [self homePageRepuestData];
            }else {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
            break;
        }
        /** 服务管理 */
        case ServiceManageBtnAction: {
            CommodityShowStyleViewController *commodityShowStyleVC = [[CommodityShowStyleViewController alloc] init];
            [self.navigationController pushViewController:commodityShowStyleVC animated:YES];
            break;
        }
        /** 会员卡 */
        case UserCardBtnAction: {
            UserCardViewController *userCardVC = [[UserCardViewController alloc] init];
            [self.navigationController pushViewController:userCardVC animated:YES];
            break;
        }
        /** 订单 */
        case OrderBtnAction: {
            OrderViewController *orderVC = [[OrderViewController alloc] init];
            orderVC.orderNavTitle = @"订单";
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        }
        /** 客户 */
        case UserBtnAction: {
            QueryUserViewController *queryUserVC = [[QueryUserViewController alloc] init];
            [self.navigationController pushViewController:queryUserVC animated:YES];
            break;
        }
        default:
            break;
    }
}
// 搜索view点击按钮
- (void)searchViewBtnAction:(UIButton *)button {
    QueryUserViewController *queryUserVC = [[QueryUserViewController alloc] init];
    [self.navigationController pushViewController:queryUserVC animated:YES];
}
#pragma mark - 界面赋值
- (void)homePageAssignment:(ShopRealtimeModel *)shopRealtime {
    /** 店铺时时数据 */
    self.homePageView.showDataView.showDataView.viceLabel.text = [NSString stringWithFormat:@"更新于%@", shopRealtime.update_time];
    /** 消费人数 */
    self.homePageView.showDataView.csmPleNumView.mainLabel.text = [NSString stringWithFormat:@"%ld", (long)shopRealtime.count];
    /** 营业额 */
    self.homePageView.showDataView.turnoverView.mainLabel.text = [NSString stringWithFormat:@"%.2f", shopRealtime.amount];
}
#pragma mark - 布局nav
- (void)homePageLayoutNAV {
    // 搜索框view
    self.search = [[SearchView alloc] init];
    self.search.isSearch = YES;
    [self.search.viewBtn addTarget:self action:@selector(searchViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.search;
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(homePageLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(homePageRightBarBtnAction)];
}
#pragma mark - 布局视图
- (void)homePageLayoutView {
    /** 首页view */
    self.homePageView = [[HomePageView alloc] init];
    /** 扫一扫 */
    [self.homePageView.scanBtn.topBotBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 收款 */
    [self.homePageView.receiptBtn.topBotBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 店铺实时数据 */
    [self.homePageView.showDataView.showDataView.usedCellBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 服务管理 */
    [self.homePageView.serviceManageView.usedCellBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 会员卡 */
    [self.homePageView.userCardView.usedCellBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 订单 */
    [self.homePageView.orderView.usedCellBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 客户 */
    [self.homePageView.userView.usedCellBtn addTarget:self action:@selector(homePageBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
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
