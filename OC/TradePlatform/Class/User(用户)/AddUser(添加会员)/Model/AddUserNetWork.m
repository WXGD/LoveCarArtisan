//
//  AddUserNetWork.m
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddUserNetWork.h"

@implementation AddUserNetWork

/** 新增加用户 */
+ (void)addUserInfoParams:(NSMutableDictionary *)params success:(void(^)(AddUserNetWork *addUser))success {
    /*/index.php?c=provider_user&a=add&v=1
     provider_id 	string 	是 	服务商id
     mobile 	string 	是 	用户手机号
     car_plate_no 	string 	否 	车牌号
     car_brand_id 	int 	否 	车品牌id
     car_brand_series_id 	int 	否 	车系id
     name 	string 	否 	用户姓名
     gender 	string 	否 	用户性别 0-男 1-女
     provider_card_id 	int 	否 	服务商卡id
     card_category_id 	int 	否 	卡类型id
     card_value 	string 	否 	卡值(如果是年卡,值为日期类型)      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在增加用户..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            AddUserNetWork *addUser = [AddUserNetWork mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(addUser);
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
