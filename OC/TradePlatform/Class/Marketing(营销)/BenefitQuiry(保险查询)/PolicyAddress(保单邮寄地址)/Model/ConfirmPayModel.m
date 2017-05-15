//
//  ConfirmPayModel.m
//  TradePlatform
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConfirmPayModel.h"

@implementation ConfirmPayModel

// 发起第三方支付
+ (void)launchThirdPartyPayParame:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success {
    
    
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_order", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"提交保单中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            if (success) {
                success(responseObject[@"data"]);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


// 支付完成，验证支付结果
+ (void)payCompletionVerification:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success {
    /* /index.php?c=insurance_order&a=confirm&v=1
     insurance_order_id 	int 	是 	保单id
     confirm_status 	int 	是 	-1：失败 1-成功     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_order", @"confirm", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"ValuationInfo" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 请求成功
            if (success) {
                success(responseObject[@"data"]);
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
