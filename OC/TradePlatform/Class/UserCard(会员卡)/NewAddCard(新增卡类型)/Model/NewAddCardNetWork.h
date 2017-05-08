//
//  NewAddCardNetWork.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewAddCardNetWork : NSObject

/** 新增会员卡类型 */
+ (void)newAddCardTypeParame:(NSMutableDictionary *)parame success:(void(^)())success;

@end
