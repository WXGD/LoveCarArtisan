//
//  TabbarViewController.m
//  WeiBo
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 cc. All rights reserved.
//

#import "TabbarViewController.h"
#import "NavigationViewController.h"
#import "HomePageViewController.h"
#import "AccountViewController.h"
#import "ReportTabBarViewController.h"
#import "LoginViewController.h"
#import "NewsViewController.h"

@interface TabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    // tabBar不透明
    self.tabBar.translucent = NO;
    
    // 设置子控制器
    HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
    [self addChildVC:homePageVC title:@"首页" image:@"tab_homepage_normal" selectedImage:@"tab_homepage_pressed"];
    
//    ReportTabBarViewController *reportTabBarVC = [[ReportTabBarViewController alloc] init];
//    [self addChildVC:reportTabBarVC title:@"报表" image:@"tab_report_normal" selectedImage:@"tab_report_pressed"];
    
    NewsViewController *marketingVC = [[NewsViewController alloc] init];
    [self addChildVC:marketingVC title:@"消息" image:@"tab_news_normal" selectedImage:@"tab_news_pressed"];
    
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [self addChildVC:accountVC title:@"我的" image:@"tab_account_normal" selectedImage:@"tab_account_pressed"];
}

- (void)addChildVC:(UIViewController *)view title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    view.title = title;
    view.tabBarItem.image = [UIImage imageNamed:image];
    // 声明这张图片按照原始样子显示出来，不要自动渲染
    view.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字选中的样式
    NSMutableDictionary * selectedtextAttrs = [NSMutableDictionary dictionary];
    selectedtextAttrs[NSForegroundColorAttributeName] = ThemeColor;
    [view.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];
    // 设置导航栏
    NavigationViewController *navigation = [[NavigationViewController alloc] initWithRootViewController:view];
    // 添加为子控制器
    [self addChildViewController:navigation];
}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    //这里我判断的是当前点击的tabBarItem的标题
    if ([viewController.tabBarItem.title isEqualToString:@"报表"]) {
        // 获取用户信息user
        MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
        if (merchantInfo.provider_id) {
            ReportTabBarViewController *reportTabBar = [[ReportTabBarViewController alloc] init];
            [self presentViewController:reportTabBar animated:YES completion:nil];
            return NO;
        }else {
            NavigationViewController *loginNVC = [[NavigationViewController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
            [self presentViewController:loginNVC animated:YES completion:nil];
            return NO;
        }
    }
    else
        return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
