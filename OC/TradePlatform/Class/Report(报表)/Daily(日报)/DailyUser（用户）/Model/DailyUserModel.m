//
//  DailyUserModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailyUserModel.h"

@implementation DailyUserModel

/* 请求日用户数据 */
+ (void)requestDailyUserDataParams:(NSMutableDictionary *)params success:(void(^)(DailyUserModel *dailyUserModel))success {
    /*/index.php?c=report&a=user_list&v=1
     provider_id 	int 	是 	服务商id
     date 	string 	否 	报表日期，默认为当天数据      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"report", @"user_list", APIEdition]; // 拼接请求参数
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在加载今日用户数据..." falseDate:@"DailyUser" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            DailyUserModel *dailyUserModel = [DailyUserModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(dailyUserModel);
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
