//
//  AddCommodityNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCommodityNetwork.h"

@implementation AddCommodityNetwork

// 新增商品
+ (void)addCommodityParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=goods&a=add&v=1
     provider_id 	int 	是 	服务商id
     goods_category_id 	int 	是 	商品类别id
     name 	string 	是 	商品名称
     price 	string 	是 	原价
     sale_price 	string 	是 	售价
     staff_user_id 	int 	是 	登录者id(登录后返回的staff_user_id)   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:nil falseDate:@"success" parentController:nil success:^(id responseObject) {
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
