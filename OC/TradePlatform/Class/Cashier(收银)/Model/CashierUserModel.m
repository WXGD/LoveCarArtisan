//
//  CashierUserModel.m
//  TradePlatform
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierUserModel.h"

@implementation CashierUserModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"available_order" : [CancellationModel class], @"cards" : [UserMemberCardModel class]};
}

/** 根据用户手机号，获取用户信息，用户会员卡信息 (收银页使用)*/
+ (void)foundationUserPhoneObtainUserInfoParams:(NSMutableDictionary *)params success:(void(^)(CashierUserModel *cashierUserModel))success {
    /*/index.php?c=provider_user_card&a=list&v=1
     provider_id 	int 	是 	服务商id
     provider_user_id 	int 	否 	用户id(用户信息中查看卡信息必传)
     user_input 	string 	否 	用户输入的值(支付时获取卡信息必传)
     start 	int 	否 	记录开始位置，默认为0
     pageSize 	int 	否 	每页显示条数,默认为10     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user_card", @"list", APITWOEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在获取用户信息..." falseDate:@"queryUser" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *array = [CashierUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (array.count) {
                return;
            }
            // 获取用户信息
            CashierUserModel *cashierUserModel = [CashierUserModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(cashierUserModel);
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
