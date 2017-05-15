//
//  CashierPayNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierPayNetwork.h"

@implementation CashierPayNetwork

// 收银支付
+ (void)cashierPayParams:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success {
    /*/index.php?c=order&a=add&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	否 	登陆者id， APP 必传,微信不传
     sale_user_id 	int 	否 	销售者id， APP 必传,微信不传
     goods_category_id 	int 	是 	商品分类id
     goods_id 	int 	是 	商品id
     provider_user_id 	int 	是 	用户id
     goods_name 	string 	是 	商品名称
     buy_num 	int 	是 	购买数量
     pay_amount 	string 	是 	支付方式:格式--支付方式_支付金额_卡号，(无卡的卡号为00000000) 1.支付宝 2.微信 3.次数 4.eb 5.账户余额 6.现金或刷卡 7-年卡
     save_amount 	string 	是 	优惠金额     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在发起支付..." falseDate:@"paySuccess" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 请求成功
            if (success) {
                NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
                success(mDict);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}
// 请求第三方支付二维码
+ (void)requestThirdPartyQRCodeParams:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success {
    /** /index.php?c=order&a=order_status&v=1
     order_id 	int 	是 	订单id  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"order_status", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在加载数据..." falseDate:@"commodity" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 请求成功
            if (success) {
                success(responseObject);
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
