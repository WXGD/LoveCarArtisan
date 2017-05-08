//
//  CarBrandListModle.m
//  CarRepairFactory
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarBrandListModle.h"
#import "CarBrandModel.h"

@implementation CarBrandListModle

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"hot_brand" : [CarBrandModel class], @"brand" : [CarBrandModel class]};
}


@end
