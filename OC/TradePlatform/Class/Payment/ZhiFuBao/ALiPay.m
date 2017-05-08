//
//  ALiPay.m
//  LoveCarEHome
//
//  Created by 弓杰 on 16/3/28.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import "ALiPay.h"
// 支付宝
#import <AlipaySDK/AlipaySDK.h>


@implementation ALiPay

+ (void)callALiPayOrderDic:(NSString *)alipaystr paymentEndBlock:(void(^)(NSDictionary *resultDic))paymentEndBlock {
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:alipaystr fromScheme:@"LoverCarCraftsman" callback:^(NSDictionary *resultDic) {
            if (paymentEndBlock) {
                paymentEndBlock(resultDic);
            }
        }];

}



@end
