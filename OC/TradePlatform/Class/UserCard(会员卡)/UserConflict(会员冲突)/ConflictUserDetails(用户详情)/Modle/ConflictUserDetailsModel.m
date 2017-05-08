//
//  ConflictUserDetailsModel.m
//  TradePlatform
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConflictUserDetailsModel.h"

@implementation ConflictUserDetailsModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"user_card" : [UserMemberCardModel class], @"user_car" : [CWFUserCarModel class]};
}



/** 获取冲突用户详情 */
+ (void)requstConflictUserDetailsParams:(NSMutableDictionary *)params success:(void(^)(ConflictUserDetailsModel *conflictUserDetails))success {
    /*/index.php?c=provider_user&a=merge_user_detail&v=1
     provider_user_id 	int 	是 	用户id     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"merge_user_detail", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在获取用户详情..." falseDate:@"providerUser" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            ConflictUserDetailsModel *conflictUserDetails = [ConflictUserDetailsModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(conflictUserDetails);
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
