//
//  ReportTabBarViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ReportTabBarViewController.h"
#import "NavigationViewController.h"
#import "WeekViewController.h"
#import "MonthsViewController.h"
#import "DailyViewController.h"
#import "AnalysisViewController.h"

@interface ReportTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation ReportTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // tabBar不透明
    self.tabBar.translucent = NO;
    // 设置子控制器
    DailyViewController *dailyVC = [[DailyViewController alloc] init];
    [self addChildVC:dailyVC title:@"日报" image:@"tab_daily_normal" selectedImage:@"tab_daily_pressed"];
    
    WeekViewController *weekVC = [[WeekViewController alloc] init];
    [self addChildVC:weekVC title:@"周报" image:@"tab_week_normal" selectedImage:@"tab_week_pressed"];

    MonthsViewController *monthsVC = [[MonthsViewController alloc] init];
    [self addChildVC:monthsVC title:@"月报" image:@"tab_months_normal" selectedImage:@"tab_months_pressed"];
    
//    AnalysisViewController *analysisVC = [[AnalysisViewController alloc] init];
//    [self addChildVC:analysisVC title:@"商品分析" image:@"tab_analysis_normal" selectedImage:@"tab_analysis_pressed"];
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
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:view];
    // 添加为子控制器
    [self addChildViewController:nav];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
