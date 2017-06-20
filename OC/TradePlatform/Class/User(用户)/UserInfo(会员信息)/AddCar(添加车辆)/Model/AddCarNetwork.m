//
//  AddCarNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCarNetwork.h"

@implementation AddCarNetwork

/** 添加用户车辆 */
+ (void)addUserCarParams:(NSMutableDictionary *)params success:(void(^)(AddCarNetwork *addCarNetwork))success {
    /*/index.php?c=provider_user_car&a=add&v=1
     provider_user_id 	int 	是 	用户id
     car_brand_id 	int 	是 	车品牌id
     car_brand_series_id 	int 	是 	车系id
     car_plate_no 	string 	是 	车辆车牌号      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user_car", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在添加车辆..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            AddCarNetwork *addCarNetwork = [AddCarNetwork mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(addCarNetwork);
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
