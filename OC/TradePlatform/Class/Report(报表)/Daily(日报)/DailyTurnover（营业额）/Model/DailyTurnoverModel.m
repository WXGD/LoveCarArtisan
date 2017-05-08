//
//  DailyTurnoverModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailyTurnoverModel.h"

@implementation DailyTurnoverModel

/* 请求日营业额数据 */
+ (void)requestDailyTurnoverModelDataParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *dailyTurnoverArray, NSMutableDictionary *options))success {
    /*/index.php?c=report&a=amount_list&v=1
     provider_id 	int 	是 	服务商id
     date 	string 	否 	报表日期，默认为当天数据     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"report", @"amount_list", APIEdition]; // 拼接请求参数
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在加载今日营业额数据..." falseDate:@"DailyTurnover" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *dailyTurnoverArray = [DailyTurnoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(dailyTurnoverArray, responseObject[@"options"]);
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
