//
//  EditCouponNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditCouponNetwork : NSObject

/** 编辑优惠劵 */
+ (void)editCoupon:(NSMutableDictionary *)params success:(void(^)())success;

@end
