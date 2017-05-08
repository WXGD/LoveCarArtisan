//
//  CarUseModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CarUseModel.h"

@implementation CarUseModel


/** 请求车辆用途 */
+ (void)requestCarPurposeSuccess:(void(^)(NSMutableArray *carPurposeArray))success {
    //获取到假数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CarPurpose" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *paymentMethodArray = [CarUseModel mj_objectArrayWithKeyValuesArray:dictioary[@"data"]];
    if (success) {
        success(paymentMethodArray);
    }
}

@end
