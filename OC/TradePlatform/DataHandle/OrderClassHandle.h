//
//  OrderClassHandle.h
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderClassModel.h"

@interface OrderClassHandle : NSScanner

/** 订单类别 */
@property (nonatomic, strong) NSMutableArray *orderClassArray;
/** 订单类别（包含全部订单类别） */
@property (nonatomic, strong) NSMutableArray *orderWholeClassArray;
/** 网络请求成功回调 */
@property (nonatomic, copy) void(^requestCategorySuccessBlock)();
/** 单例创建方法 */
+ (OrderClassHandle *)sharedInstance;
/** 销毁单利 */
+ (void)destroyHandle;

@end
