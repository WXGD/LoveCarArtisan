//
//  CarConditionModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CarConditionModel.h"

@implementation CarConditionModel


/** 请求车况类型 */
+ (void)requestCarConditionSuccess:(void(^)(NSMutableArray *carConditionArray))success {
    //获取到假数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CarCondition" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *paymentMethodArray = [CarConditionModel mj_objectArrayWithKeyValuesArray:dictioary[@"data"]];
    if (success) {
        success(paymentMethodArray);
    }
}


@end
