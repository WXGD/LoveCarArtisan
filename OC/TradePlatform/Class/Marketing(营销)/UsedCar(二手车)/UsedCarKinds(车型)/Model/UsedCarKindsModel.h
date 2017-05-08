//
//  UsedCarKindsModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsedCarBrandModel.h"

@interface UsedCarKindsModel : NSObject

/**  "car_models" =   车型数组;
 "sale_year" = 2002;
      */

/** 所有车型 */
@property (nonatomic, strong) NSArray *car_models;
/** 车型系列 */
@property (nonatomic, copy) NSString *sale_year;

/** 请求车型数据 */
+ (void)requestCarKindsData:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *carKindsArray))success;

@end
