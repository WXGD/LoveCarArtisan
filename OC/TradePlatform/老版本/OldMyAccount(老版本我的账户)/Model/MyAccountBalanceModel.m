//
//  MyAccountBalanceModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyAccountBalanceModel.h"

@implementation MyAccountBalanceModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"withdraw_record" : [WithdrawRecordModel class]};
}

/** 请求账户余额和已经提现余额 */
+ (void)requestAccountBalance:(NSMutableDictionary *)params success:(void(^)(MyAccountBalanceModel *accountBalance))success {
    /*/index.php?c=provider&a=amount&v=1
     provider_id 	int 	是 	服务商id   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider", @"amount", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在加载数据..." falseDate:@"MyAccount" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            MyAccountBalanceModel *accountBalance = [MyAccountBalanceModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(accountBalance);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


/** 申请提现 */
+ (void)providerWithdrawParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=provider&a=withdraw&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录用户id  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider", @"withdraw", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在申请提现..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showSuccess:@"申请成功，我们将尽快与您联系"];
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


@end
