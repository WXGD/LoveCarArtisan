//
//  AddCouponNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCouponNetwork : NSObject

/** 新增优惠劵 */
+ (void)addCoupon:(NSMutableDictionary *)params success:(void(^)())success;

@end
