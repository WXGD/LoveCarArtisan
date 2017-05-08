//
//  FilterConditionModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FilterConditionModel.h"

@implementation FilterConditionModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"value" : [FiterItemModel class]};
}

@end
