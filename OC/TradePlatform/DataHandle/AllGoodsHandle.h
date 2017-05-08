//
//  AllGoodsHandle.h
//  TradePlatform
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//  请求全部服务类型和商品

#import <Foundation/Foundation.h>
#import "ServiceProviderModel.h"

@interface AllGoodsHandle : NSObject

/** 全部服务和商品 */
@property (strong, nonatomic) NSMutableArray *wholeServiceGoodsArray;
/** 网络请求成功回调 */
@property (nonatomic, copy) void(^requestSuccessBlock)(NSMutableArray *allGoodsArray);
/** 单例创建方法 */
+ (AllGoodsHandle *)sharedInstance;
/** 销毁单利 */
+ (void)destroyHandle;

@end
