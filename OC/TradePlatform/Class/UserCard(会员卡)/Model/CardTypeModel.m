//
//  CardTypeModel.m
//  TradePlatform
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardTypeModel.h"

@implementation CardTypeModel

/** 适用服务 */

- (void)setUsed_goods_text:(NSString *)used_goods_text {
    _used_goods_text = used_goods_text;
    if (used_goods_text.length == 0) {
        _used_goods_text = @"全部服务";
    }
}

// 请求所有会员卡类型
+ (void)requestCardTypeListDataParams:(NSMutableDictionary *)params tableView:(UITableView *)tableView success:(void(^)(NSMutableArray *cardTypeArray))success {
    /* /index.php?c=provider_card&a=list&v=1
     provider_id 	int 	是 	服务商id     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_card", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"providerCardType" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 获取数据模型数组
            NSMutableArray *cardTypeArray = [CardTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(cardTypeArray);
            }
        }else {
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        // 结束下拉刷新
        [tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}

// 请求所有会员卡类型
+ (void)requestCardTypeDataProgressHUDParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *cardTypeArray))success {
    /* /index.php?c=provider_card&a=list&v=1
     provider_id 	int 	是 	服务商id     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_card", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"providerCardType" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *cardTypeArray = [CardTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(cardTypeArray);
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
