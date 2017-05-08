//
//  EditCommodityNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCommodityNetwork.h"

@implementation EditCommodityNetwork

// 请求商品项目列表
+ (void)editCommodity:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=goods&a=edit&v=1
     goods_id 	int 	是 	商品id
     price 	string 	是 	原价
     sale_price 	string 	是 	售价   
     goods_name 	string 	是 	商品名称
     staff_user_id string 	是 	登陆者ID */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods", @"edit", APIEdition];
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

