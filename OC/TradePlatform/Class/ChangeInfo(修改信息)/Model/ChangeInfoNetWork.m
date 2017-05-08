//
//  ChangeInfoNetWork.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangeInfoNetWork.h"

@implementation ChangeInfoNetWork

/** 修改用户信息 */
+ (void)editUserInfoParams:(NSMutableDictionary *)params success:(void(^)(ChangeInfoNetWork *changeUserInfo))success {
    /*/index.php?c=provider_user&a=edit&v=1
     provider_user_id 	int 	是 	用户id
     data 	string 	是 	需要修改的用户信息; 数据格式：字段=值,字段1=值1 (修改信息对应字段参考下面的备注)     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"edit", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在修改用户信息..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            ChangeInfoNetWork *changeUserInfo = [ChangeInfoNetWork mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(changeUserInfo);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


/** 修改当前登陆用户密码 */
+ (void)editAccountPasswordParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=provider&a=reset_password&v=1
     staff_user_id 	int 	是 	登录者id
     old_password 	string 	是 	旧密码
     new_password 	string 	是 	新密码      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider", @"reset_password", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在修改密码..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            // 请求成功
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}

/** 修改商户信息 */
+ (void)editMerchantInfoParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=provider&a=edit&v=1
     provider_id 	int 	是 	服务商id
     data 	string 	是 	修改的信息： 数据格式： 数据库字段名=值(店名----name 地址--address 电话--service_tel)  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider", @"edit", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在修改商户信息..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            // 请求成功
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


/** 修改用户车辆信息 */
+ (void)editUserCarInfoParams:(NSMutableDictionary *)params success:(void(^)(ChangeInfoNetWork *changeUserCar))success {
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
            ChangeInfoNetWork *changeUserCar = [ChangeInfoNetWork mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(changeUserCar);
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
