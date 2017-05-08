//
//  NavigationViewController.m
//  WeiBo
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 cc. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

+ (void)initialize {
    
    // 取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    // nav不透明
    navBar.translucent = NO;
    // 背景颜色
    navBar.barTintColor = ThemeColor;
    // 设置导航栏的渐变色（iOS7中返回箭头的颜色变为这个颜色）
    navBar.tintColor = WhiteColor;
    // 设置导航栏标题颜色
    [navBar setTitleTextAttributes:@{
                                     //字体颜色
                                     NSForegroundColorAttributeName : WhiteColor,
                                     //字体大小
                                     NSFontAttributeName:EighteenTypefaceBold
                                     }];
    // 设置导航栏按钮文字颜色
    [barItem setTitleTextAttributes:@{
                                      //字体大小
                                      NSFontAttributeName:FifteenTypeface
                                      } forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/** 重写这个方法目的：能够拦截所有push进来的控制器 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        /* 设置导航栏上面的内容 */
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}


- (void)back {
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
