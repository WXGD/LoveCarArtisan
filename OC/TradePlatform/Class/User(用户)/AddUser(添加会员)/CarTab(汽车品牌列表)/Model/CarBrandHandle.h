//
//  CarBrandHandle.h
//  CarRepairFactory
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarBrandHandle : NSObject

/** 存放所有分组 */
@property (nonatomic, strong) NSMutableArray *groupArray;
/** 存放所有分组后的数据模型 */
@property (nonatomic, strong) NSArray *modelSectionArray;
/** 存放热门品牌 */
@property (nonatomic, strong) NSArray *hotBrandArray;
/** 网络请求完成回调 */
@property (nonatomic, copy) void((^carBrandNetSucBlock)(NSMutableArray *groupArray, NSArray *modelSectionArray, NSArray *hotBrandArray));
/** 单例创建方法 */
+ (CarBrandHandle *)sharedInstance;

@end
