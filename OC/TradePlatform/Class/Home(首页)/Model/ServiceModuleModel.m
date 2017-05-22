//
//  ServiceModuleModel.m
//  TradePlatform
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServiceModuleModel.h"

@implementation ServiceModuleModel

/** 请求服务模块 */
+ (void)requestServiceModuleSuccess:(void(^)(NSMutableArray *moduleArray))success {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ServiceModule" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *serviceModuleArray = [ServiceModuleModel mj_objectArrayWithKeyValuesArray:dictioary[@"data"]];
    
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < serviceModuleArray.count; i++) {
        if (i % 3 == 0) {
            array1 = [[NSMutableArray alloc] init];
            [array1 addObject:serviceModuleArray[i]];
            [array2 addObject:array1];
        }else {
            [array1 addObject:serviceModuleArray[i]];
        }
    }
    
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    NSMutableArray *array4 = [[NSMutableArray alloc] init];
    for (int i = 0; i < array2.count; i++) {
        if (i % 2 == 0) {
            array3 = [[NSMutableArray alloc] init];
            [array3 addObject:array2[i]];
            [array4 addObject:array3];
        }else {
            [array3 addObject:array2[i]];
        }
    }
    
    
    if (success) {
        success(array4);
    }
}



@end
