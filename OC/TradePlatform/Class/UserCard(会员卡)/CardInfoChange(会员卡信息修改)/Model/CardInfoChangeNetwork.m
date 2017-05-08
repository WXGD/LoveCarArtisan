//
//  CardInfoChangeNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardInfoChangeNetwork.h"

@implementation CardInfoChangeNetwork

// 修改卡信息
+ (void)cardInfoChange:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=provider_card&a=edit&v=1
     provider_card_id 	int 	是 	服务商卡id
     data 	string 	否 	编辑除了可适用的服务以外的数据必传（格式: 数据库字段名=值，字段名参考备注）
     rules 	string 	否 	编辑适用的服务必传, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_card", @"edit", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在修改..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
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
