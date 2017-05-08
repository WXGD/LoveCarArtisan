//
//  ALiPay.h
//  LoveCarEHome
//
//  Created by 弓杰 on 16/3/28.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALiPay : NSObject

@property (copy, nonatomic) void(^paymentEndBlock)();

+ (void)callALiPayOrderDic:(NSString *)alipaystr paymentEndBlock:(void(^)(NSDictionary *resultDic))paymentEndBlock;

@end
