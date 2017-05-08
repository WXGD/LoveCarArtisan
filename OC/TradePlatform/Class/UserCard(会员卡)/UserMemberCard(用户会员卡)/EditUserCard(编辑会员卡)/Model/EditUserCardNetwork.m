//
//  EditUserCardNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditUserCardNetwork.h"

@implementation EditUserCardNetwork

/** 保存编辑后的用户信息 */
+ (void)preservedEditUserCardParame:(NSMutableDictionary *)parame isCashPay:(BOOL)isCashPay success:(void(^)(NSMutableDictionary *thirdPartyDic))success {
    /*/index.php?c=provider_user_card&a=edit&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登陆者id
     sale_user_id 	int 	是 	销售者id
     provider_user_card_id 	int 	是 	用户卡id
     data 	string 	是 	编辑的信息 格式： 数据库字段名=值, 数据库字段名1=值1(对应数据库字段名见备注)
     price 	string 	否 	实收金额(充值时必传)  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user_card", @"edit", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在修改..." falseDate:@"error" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            // 请求成功
            if (success) {
                NSMutableDictionary *thirdPartyDic = [[NSMutableDictionary alloc] init];
                // 判断是否为现金支付
                if (!isCashPay) { // 不是现金支付
                    thirdPartyDic = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
                }
                success(thirdPartyDic);
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
