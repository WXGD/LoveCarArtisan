//
//  EditCouponNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCouponNetwork.h"

@implementation EditCouponNetwork

/** 编辑优惠劵 */
+ (void)editCoupon:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=coupon&a=edit&v=1
     provider_id 	int 	是 	服务商id
     coupon_id 	int 	是 	优惠券id
     description 	string 	是 	描述
     grant_start_time 	string 	是 	发放开始时间
     grant_end_time 	string 	是 	发放结束时间
     num 	int 	是 	发放总数量
     limit_num_type 	int 	是 	发放限制：0-不限制，一人可领多张 1-限制一人只能领一张
     expire_day 	int 	是 	领取之后可以可使用天数,默认为0，不限制
     rules 	string 	是 	适用服务，默认为‘’，格式： goods_id=1,goods_id=2,goods_category_id=1..        */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon", @"edit", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
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
