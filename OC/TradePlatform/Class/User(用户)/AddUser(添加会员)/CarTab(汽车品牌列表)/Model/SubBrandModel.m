
//
//  SubBrandModel.m
//  CarRepairFactory
//
//  Created by apple on 2016/11/17.
//  Copyright © 2016年 apple. All rights reserved.
//  子品牌模型（例如：一汽大众，上海大众）

#import "SubBrandModel.h"

@implementation SubBrandModel



+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"series_version" : [CarStoryModel class]};
}

/** 根据品牌，获取车系列 */
+ (void)requestCarSeriesCarBrand:(NSString *)carBrand success:(void(^)(NSMutableArray *subBrandArray))success {
    /*/index.php?c=car_brand_series&a=list&v=1
     brand_id 	int 	否 	获取品牌不需要传，获取车系必传  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"car_brand_series", @"list", APIEdition];
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    parame[@"brand_id"] = carBrand;
    [TPNetRequest GET:URL parameters:parame ProgressHUD:@"正在加载数据..." falseDate:@"CarBrandTab" parentController:nil success:^(id responseObject) {
        PDLog(@"%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *subBrandArray = [SubBrandModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功回调
            if (success) {
                success(subBrandArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}

@end
