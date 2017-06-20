//
//  AdminServiceClassNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AdminServiceClassNetwork.h"

@implementation AdminServiceClassNetwork

/** 修改服务类别 */
+ (void)editServiceClass:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=subbranch_goods_category&a=manage&v=1
     provider_id 	int 	是 	服务商id
     data 	string 	是 	服务类别数据，格式： 服务类别id_类别排序，多个用逗号分割    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"subbranch_goods_category", @"manage", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
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
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


@end
