//
//  UsedCarBrandModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarBrandModel.h"

@implementation UsedCarBrandModel

/** 获取所有品牌 */
+ (void)requestWholeCarBrand {
    /* /index.php?c=usedcar_brand_series&a=list&v=1    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_brand_series", @"list", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:nil falseDate:@"CarBrandTab" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *usedCarBrandArray = [UsedCarBrandModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}



@end
