//
//  AppDelegate+AppLifeCircle.m
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//  app的生命周期管理

#import "AppDelegate+AppLifeCircle.h"
#import "AppDelegate+AppService.h"
#import "MerchantInfoModel.h"
// 单利
#import "OrderFilterHandle.h"
#import "OrderClassHandle.h"
#import "UsedCarBrandHandle.h"
#import "AllGoodsHandle.h"
#import "ServiceMasterHandle.h"
#import "ServiceCategoryHandle.h"


@implementation AppDelegate (AppLifeCircle)


- (void)applicationWillResignActive:(UIApplication *)application {
    PDLog(@"aa");
    // 销毁单利
    [OrderFilterHandle destroyHandle];
    [OrderClassHandle destroyHandle];
    [UsedCarBrandHandle destroyHandle];
    [AllGoodsHandle destroyHandle];
    [ServiceMasterHandle destroyHandle];
    [ServiceCategoryHandle destroyHandle];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 设置角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    PDLog(@"cc");

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [MerchantInfoModel updata:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    PDLog(@"ee");

}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            PDLog(@"result = %@",resultDic);
            // 支付宝支付状态
            ALiPayHandle *aLiPay = [ALiPayHandle sharedManager];
            [aLiPay aLiPay:resultDic];
        }];
    } else {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}

// 收到内存警告的时候，sdWepimage清除缓存
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];//可有可无
}

@end
