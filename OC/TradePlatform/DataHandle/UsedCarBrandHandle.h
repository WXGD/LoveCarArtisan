//
//  UsedCarBrandHandle.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsedCarBrandModel.h"

@interface UsedCarBrandHandle : NSObject

/** 全部二手车品牌数据 */
@property (nonatomic, strong) NSMutableDictionary *usedCarBrandDic;
/** 全部二手车品牌分组数据数据 */
@property (nonatomic, strong) NSMutableArray *usedCarBrandDicKeys;
/** 网络请求成功回调 */
@property (nonatomic, copy) void(^requestUsedCarBrandBlock)();
/** 单例创建方法 */
+ (UsedCarBrandHandle *)sharedInstance;
/** 销毁单利 */
+ (void)destroyHandle;

@end
