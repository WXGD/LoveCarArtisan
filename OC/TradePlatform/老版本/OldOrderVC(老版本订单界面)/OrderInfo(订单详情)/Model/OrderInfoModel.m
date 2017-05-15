
//
//  OrderInfoModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderInfoModel.h"

@implementation OrderInfoModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"order_detail" : [OrderDetailsModel class]};
}


/** 请求订单详细信息 */
+ (void)requestOrderInfoOrderNo:(NSString *)orderNo success:(void(^)(OrderInfoModel *orderModel))success {
    /*/index.php?c=order&a=detail&v=1
     order_id 	int 	是 	订单id    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"detail", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"order_id"] = orderNo; // 订单编号
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"orderDetails" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            OrderInfoModel *orderModel = [OrderInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(orderModel);
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
