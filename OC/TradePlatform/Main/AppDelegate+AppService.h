//
//  AppDelegate+AppService.h
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//  app的服务管理


#import "AppDelegate.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
// 支付宝
#import <AlipaySDK/AlipaySDK.h>
#import "ALiPayHandle.h"
// 微信
#import "WXApiManager.h"

@interface AppDelegate (AppService)<JPUSHRegisterDelegate>

/** 重置user-agent */
- (void)resetUserAgent;
/**
 *  URL跳转界面
 */
- (void)urlNavController;
/**
 *  加载第三方
 */
- (void)loadThirdParty:(NSDictionary *)launchOptions;

@end
