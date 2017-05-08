//
//  AppDelegate+RootController.m
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//  app的跟视图控制器实例

#import "AppDelegate+RootController.h"
// 控制器
#import "NavigationViewController.h"
#import "TabbarViewController.h"
#import "NewfeatureViewController.h"
#import "LoginViewController.h"
@interface AppDelegate ()


@end

@implementation AppDelegate (RootController)




// window实例
- (void)setAppWindows {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self createLoadingScrollView];
    [self.window makeKeyAndVisible];
}


// 首次启动轮播图
- (void)createLoadingScrollView {
    // 取出上一次的版本号
    NSString *lastVersion = [USER_DEFAULT objectForKey:@"build"];
    // 判断
    if ([BUILD isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
        // 判断是否登陆
        if (merchantInfo.provider_id) {
            self.window.rootViewController = [[TabbarViewController alloc] init];
        }else {
            self.window.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        }
    }else {
        self.window.rootViewController = [[NewfeatureViewController alloc] init];
        // 当版本号不同的时候，保存版本号
        [USER_DEFAULT setObject:BUILD forKey:@"build"];
        [USER_DEFAULT synchronize];
    }
}
// 当前app主控制器
+ (UINavigationController *)rootNavigationController {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return (UINavigationController *)app.window.rootViewController;
}

// 当前app主窗口
+ (UIWindow *)rootWindows {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return window;
}


@end
