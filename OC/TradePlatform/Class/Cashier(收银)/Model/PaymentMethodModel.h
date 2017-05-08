//
//  PaymentMethodModel.h
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentMethodModel : NSObject

/**  "name" : "银联支付",
 "image_url" : "cashier_cash_pay"  */



/** 支付方式名称 */
@property (copy, nonatomic) NSString *name;
/** 支付方式图片 */
@property (copy, nonatomic) NSString *image_url;
/** 支付方式ID （1-支付宝 2-微信 3或4-卡支付 6-现金） */
@property (assign, nonatomic) NSInteger pay_method_id;


/** 请求支付方式 */
+ (void)requestPaymentMethodSuccess:(void(^)(NSMutableArray *paymentMethodArray))success;

@end
