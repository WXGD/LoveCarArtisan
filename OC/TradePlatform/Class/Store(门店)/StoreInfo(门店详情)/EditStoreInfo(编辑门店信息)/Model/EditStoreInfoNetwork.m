//
//  EditStoreInfoNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditStoreInfoNetwork.h"

@implementation EditStoreInfoNetwork

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


@end
