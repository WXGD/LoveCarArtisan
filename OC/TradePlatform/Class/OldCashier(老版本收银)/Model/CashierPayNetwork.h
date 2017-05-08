//
//  CashierPayNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashierPayNetwork : NSObject

// 请求服务项目列表
+ (void)cashierPayParams:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success;
// 请求第三方支付二维码
+ (void)requestThirdPartyQRCodeParams:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success;

@end
