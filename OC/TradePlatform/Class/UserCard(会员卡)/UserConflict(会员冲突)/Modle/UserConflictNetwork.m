//
//  UserConflictNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserConflictNetwork.h"

@implementation UserConflictNetwork



/** 查询冲突用户 */
+ (void)queryConflictUserParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success {
    /*/index.php?c=provider_user&a=merge_user_info&v=1
     provider_user_id 	string 	是 	冲突用户集合,字符串表示(用逗号分割)    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"merge_user_list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在获取冲突用户..." falseDate:@"providerUser" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *userArray = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(userArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
    
}

/** 合并冲突用户 */
+ (void)mergeConflictUserParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=provider_user&a=merge&v=1
     provider_user_id 	int 	是 	用户id(保留的用户)
     merged_provider_user_id 	int 	是 	被合并的用户id
     is_merge_card 	int 	是 	是否合并卡
     is_merge_car 	int 	是 	是否合并车辆     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"merge", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在合并冲突用户..." falseDate:@"providerUser" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 请求成功
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"合并失败"];
        PDLog(@"%@", error);
    }];
    
}



@end
