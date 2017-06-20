//
//  EditUserInfoNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditUserInfoNetwork.h"

@implementation EditUserInfoNetwork

/** 修改用户信息 */
+ (void)editUserInfoParams:(NSMutableDictionary *)params success:(void(^)(EditUserInfoNetwork *editUserInfo))success {
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
            EditUserInfoNetwork *editUserInfo = [EditUserInfoNetwork mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(editUserInfo);
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
