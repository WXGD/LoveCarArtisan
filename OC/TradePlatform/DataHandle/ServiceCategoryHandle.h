//
//  ServiceCategoryHandle.h
//  TradePlatform
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceProviderModel.h"

@interface ServiceCategoryHandle : NSObject

/** 服务类别 */
@property (nonatomic, strong) NSMutableArray *serviceCategoryArray;
/** 服务类别（包含全部服务类别） */
@property (nonatomic, strong) NSMutableArray *serviceWholeCategoryArray;
/** 网络请求成功回调 */
@property (nonatomic, copy) void(^requestCategorySuccessBlock)();
/** 单例创建方法 */
+ (ServiceCategoryHandle *)sharedInstance;
/** 销毁单利 */
+ (void)destroyHandle;

@end
