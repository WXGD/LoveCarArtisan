//
//  AddCommodityNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCommodityNetwork : NSObject

// 新增商品
+ (void)addCommodityParams:(NSMutableDictionary *)params success:(void(^)())success;

@end
