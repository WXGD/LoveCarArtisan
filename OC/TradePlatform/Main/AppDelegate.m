//
//  AppDelegate.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RootController.h"
#import "AppDelegate+AppLifeCircle.h"
#import "AppDelegate+AppService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化窗口
    [self setAppWindows];
    // 重置user-agent
    [self resetUserAgent];
    // 加载第三方
    [self loadThirdParty:launchOptions];
    
    return YES;
}



@end
