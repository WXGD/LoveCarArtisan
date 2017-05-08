//
//  SubBrandModel.h
//  CarRepairFactory
//
//  Created by apple on 2016/11/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarStoryModel.h"

@interface SubBrandModel : NSObject


/*car_brand_series_id = 363;
 name = "进口别克";
 "series_version" = */
/** id标识 */
@property (nonatomic, assign) NSInteger car_brand_series_id;
/** 子品牌名称 */
@property (nonatomic, copy) NSString *name;
/** 对应车型 */
@property (nonatomic, strong) NSArray *series_version;

/** 根据品牌，获取车系列 */
+ (void)requestCarSeriesCarBrand:(NSString *)carBrand success:(void(^)(NSMutableArray *subBrandArray))success;

@end
