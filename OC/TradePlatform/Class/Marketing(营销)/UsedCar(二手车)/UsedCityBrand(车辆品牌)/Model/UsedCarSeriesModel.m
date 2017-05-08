//
//  UsedCarSeriesModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarSeriesModel.h"

@implementation UsedCarSeriesModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"series_version" : [UsedCarBrandModel class]};
}

@end
