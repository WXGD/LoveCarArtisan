//
//  OpenCardNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OpenCardNetwork.h"

@implementation OpenCardNetwork


/** 开卡 */
+ (void)openCardParame:(NSMutableDictionary *)parame isCashPay:(BOOL)isCashPay success:(void(^)(NSMutableDictionary *successDic))success  conflict:(void(^)(OpneUserConflictModel *userConflict))conflict{
    /*/index.php?c=provider_card&a=allocate&v=1
     provider_card_id 	int 	是 	服务商卡id
     staff_user_id 	int 	是 	登录者id
     sale_user_id 		是 	销售者id
     provider_id 	int 	是 	服务商id
     mobile 	string 	是 	用户手机号
     car_plate_no 	string 	否 	车牌号
     donate 	string 	否 	赠送次数或余额
     donate_service 	string 	否 	赠送的服务,格式： 商品id=赠送次数 eg:1=10(1.0.4新增)
     sale_price 	float 	否 	开卡售价(1.0.4版本新增) 
     pay_method_id 	int 	否 	支付方式:1-支付宝 2-微信 6-现金  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_card", @"allocate", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            OpneUserConflictModel *userConflict = [OpneUserConflictModel mj_objectWithKeyValues:responseObject[@"data"]];
            if (userConflict.conflict == 1) {
                if (conflict) {
                    conflict(userConflict);
                }
            }else {
                NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
                // 判断是否为现金支付
                if (!isCashPay) { // 不是现金支付
                    mDict = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
                }
                // 请求成功
                if (success) {
                    success(mDict);
                }
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
