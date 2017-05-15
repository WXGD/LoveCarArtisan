//
//  PaymentMethodModel.m
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PaymentMethodModel.h"

@implementation PaymentMethodModel

/** 请求支付方式 */
+ (void)requestPaymentMethodSuccess:(void(^)(NSMutableArray *paymentMethodArray))success {
    //获取到假数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PaymentMethod" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *paymentMethodArray = [PaymentMethodModel mj_objectArrayWithKeyValuesArray:dictioary[@"data"]];
    if (success) {
        success(paymentMethodArray);
    }
}
/** 请求第三方支付方式 */
+ (void)requestThirdPartyPayMethodSuccess:(void(^)(NSMutableArray *paymentMethodArray))success {
    //获取到假数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ThirdPartyPay" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *paymentMethodArray = [PaymentMethodModel mj_objectArrayWithKeyValuesArray:dictioary[@"data"]];
    if (success) {
        success(paymentMethodArray);
    }
}

@end
