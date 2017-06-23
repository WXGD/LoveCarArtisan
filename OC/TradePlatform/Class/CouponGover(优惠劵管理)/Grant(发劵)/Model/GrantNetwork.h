//
//  GrantNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrantNetwork : NSObject

/** 商家赠送优惠券列表 */
+ (void)grantCoupon:(NSMutableDictionary *)params success:(void(^)())success;

@end
