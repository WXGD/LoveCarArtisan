//
//  UsedCarKindsModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarKindsModel.h"

@implementation UsedCarKindsModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"car_models" : [UsedCarBrandModel class]};
}



/** 请求车型数据 */
+ (void)requestCarKindsData:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *carKindsArray))success {
    /* /index.php?c=usedcar_brand_series&a=list&v=1
     brand_id 	string 	否 	获取车系、车型必传
     series_id 	string 	否 	获取车型必传    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_brand_series", @"list", APIEdition];
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"CarBrandTab" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *carKindsArray = [UsedCarKindsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (success) {
                success(carKindsArray);
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
