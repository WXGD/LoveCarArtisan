//
//  EditCarInfoNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCarInfoNetwork.h"

@implementation EditCarInfoNetwork

/** 修改用户车辆信息 */
+ (void)editUserCarInfoParams:(NSMutableDictionary *)params success:(void(^)(EditCarInfoNetwork *editCarInfo))success {
    /*/index.php?c=provider_user_car&a=edit&v=1
     provider_user_id 	int 	否 	编辑和删除车辆时必传，设置默认非必传
     provider_user_car_id 	int 	是 	用户车辆id
     car_plate_no 	string 	是 	车牌号
     car_brand_id 	int 	否 	品牌id, 编辑车辆必传
     car_brand_series_id 	int 	否 	车系id, 编辑车辆必传
     type 	string 	是 	操作类型： edit-更新 del-删除 set-设为默认
     is_default 	int 	否 	删除车辆时必传   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user_car", @"edit", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在修改车辆信息..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            EditCarInfoNetwork *editCarInfo = [EditCarInfoNetwork mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(editCarInfo);
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
