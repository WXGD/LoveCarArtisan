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
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在发起支付..." falseDate:@"error" parentController:nil success:^(id responseObject) {
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


// 收银支付v2版
+ (void)v2CashierPayParams:(NSMutableDictionary *)params success:(void(^)(NSMutableDictionary *responseObject))success {
    /*/index.php?c=order&a=add&v=2
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     sale_user_id 	int 	是 	服务师傅
     mobile 	string 	是 	手机号
     car_plate_no 	string 	是 	车牌号
     goods_data 	string 	是 	商品数据,格式： 服务类别id_商品id_购买数量_售价， 多个商品用逗号分割
     pay_amount 	string 	是 	支付方式:格式--支付方式_支付金额_卡号，(无卡的卡号为00000000) 1.支付宝 2.微信 3.次数 4.eb 5.账户余额 6.现金或刷卡 7-年卡
     mileage 	float 	否 	行驶里程
     next_maintain 	string 	否 	下一次保养时间,
     cart_id 	int 	否 	购物车记录[挂单列表] id (挂单界面直接收银时必传)
     coupon_grant_record_id 	string 	否 	选择用户优惠券的id集合,多个用逗号分割，默认为空
     save_amount 	float 	否 	优惠金额，默认为0       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"add", APITWOEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在发起支付..." falseDate:@"error" parentController:nil success:^(id responseObject) {
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



// 挂单，但不收银
+ (void)cartAddNotCashier:(NSMutableDictionary *)params success:(void(^)())success {
    /** /index.php?c=cart&a=add&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     sale_user_id 	int 	是 	服务师傅
     mobile 	string 	是 	手机号
     car_plate_no 	string 	是 	车牌号
     goods_data 	string 	是 	商品数据,格式： 服务类别id_商品id_购买数量_售价， 多个商品用逗号分割
     total_price 	float 	是 	总价
     mileage 	float 	否 	行驶里程
     next_maintain 	string 	否 	下一次保养时间,  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"cart", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showError:@"挂单成功"];
            // 请求成功
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"挂单失败"];
        PDLog(@"%@", error);
    }];
}

// 修改挂单信息，但不收银
+ (void)editCartInfoAddNotCashier:(NSMutableDictionary *)params success:(void(^)())success {
    /** /index.php?c=cart&a=edit&v=1
     cart_id 	int 	是 	挂单列表id
     sale_user_id 	int 	是 	服务师傅
     mobile 	string 	是 	手机号
     car_plate_no 	string 	是 	车牌号
     goods_data 	string 	是 	商品数据,格式： 服务类别id_商品id_购买数量_售价， 多个商品用逗号分割
     total_price 	float 	是 	总价
     mileage 	float 	否 	行驶里程
     next_maintain 	string 	否 	下一次保养时间,   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"cart", @"edit", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showError:@"挂单成功"];
            // 请求成功
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"挂单失败"];
        PDLog(@"%@", error);
    }];
}

@end
