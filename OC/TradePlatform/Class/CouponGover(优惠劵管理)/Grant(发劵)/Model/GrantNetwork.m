//
//  GrantNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GrantNetwork.h"

@implementation GrantNetwork

/** 商家赠送优惠券列表 */
+ (void)grantCoupon:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=coupon_grant_record&a=donate&v=1
    provider_user_id 	int 	是 	用户id
    coupon_id 	int 	是 	优惠券id       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon_grant_record", @"donate", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
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
