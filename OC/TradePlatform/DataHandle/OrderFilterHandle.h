//
//  OrderFilterHandle.h
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterConditionModel.h"

@interface OrderFilterHandle : NSObject

/** 订单筛选 */
@property (nonatomic, strong) NSMutableArray *orderFilterArray;
/** 网络请求成功回调 */
@property (nonatomic, copy) void(^requestCategorySuccessBlock)();
/** 单例创建方法 */
+ (OrderFilterHandle *)sharedInstance;
/** 销毁单利 */
+ (void)destroyHandle;

@end
