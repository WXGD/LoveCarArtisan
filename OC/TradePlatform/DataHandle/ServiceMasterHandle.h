//
//  ServiceMasterHandle.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceMasterHandle : NSObject

/** 服务师傅 */
@property (nonatomic, strong) NSMutableArray *serviceMasterArray;
/** 服务师傅（包含全部服务师傅选项） */
@property (nonatomic, strong) NSMutableArray *wholeServiceMasterArray;
/** 网络请求成功回调 */
@property (nonatomic, copy) void(^requestSuccessBlock)();
/** 单例创建方法 */
+ (ServiceMasterHandle *)sharedInstance;
/** 销毁单利 */
+ (void)destroyHandle;

@end
