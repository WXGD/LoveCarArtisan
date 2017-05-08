//
//  EditCommodityNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditCommodityNetwork : NSObject

// 请求服务项目列表
+ (void)editCommodity:(NSMutableDictionary *)params success:(void(^)())success;

@end
