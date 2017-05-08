//
//  NewAddCardNetWork.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewAddCardNetWork.h"

@implementation NewAddCardNetWork


/** 新增会员卡类型 */
+ (void)newAddCardTypeParame:(NSMutableDictionary *)parame success:(void(^)())success {
    /*/index.php?c=provider_card&a=add&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     name 	string 	是 	卡名
     card_category_id 	int 	是 	卡类型id
     card_value 	string 	是 	卡面值（可以为次数、储值数或年数）
     price 	string 	是 	原价
     sale_price 	string 	是 	售价
     description 	string 	否 	卡描述
     rules 	string 	否 	适用的服务, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_card", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在添加新卡..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showSuccess:@"添加成功"];
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
