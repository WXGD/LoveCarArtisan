//
//  CashierPayNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashierPayNetwork : NSObject

/** 请求服务项目列表 */
+ (void)cashierPayParams:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success;
/** 请求第三方支付二维码 */
+ (void)requestThirdPartyQRCodeParams:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success;
/** 挂单，但不收银 */
+ (void)cartAddNotCashier:(NSMutableDictionary *)params success:(void(^)())success;
// 收银支付v2版
+ (void)v2CashierPayParams:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success;
// 修改挂单信息，但不收银
+ (void)editCartInfoAddNotCashier:(NSMutableDictionary *)params success:(void(^)())success;

@end
