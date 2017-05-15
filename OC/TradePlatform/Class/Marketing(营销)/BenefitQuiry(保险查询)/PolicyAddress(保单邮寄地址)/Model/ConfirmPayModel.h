//
//  ConfirmPayModel.h
//  TradePlatform
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmPayModel : UIView

// 发起第三方支付
+ (void)launchThirdPartyPayParame:(NSMutableDictionary *)parame success:(void(^)(NSMutableDictionary *responseObject))success;
// 支付完成，验证支付结果
+ (void)payCompletionVerification:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success;

@end
