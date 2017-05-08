//
//  CardInfoChangeNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardInfoChangeNetwork : NSObject

// 修改卡信息
+ (void)cardInfoChange:(NSMutableDictionary *)params success:(void(^)())success;

@end
