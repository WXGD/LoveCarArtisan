//
//  ShopRealtimeModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShopRealtimeModel.h"

@implementation ShopRealtimeModel

// 请求店铺实时数据
+ (void)shopRealtimeRequestParame:(NSMutableDictionary *)parame success:(void(^)(ShopRealtimeModel *shopRealtime))success scrollView:(UIScrollView *)scrollView noLogin:(void(^)())noLogin failure:(void(^)())failure {
    /*/index.php?c=order&a=statistic_amount&v=1
     provider_id 	int 	是 	商家id
     staff_user_id 	int 	是 	登录者id      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"statistic_amount", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"realTimeData" parentController:nil success:^(id responseObject) {
        PDLog(@"请求店铺实时数据%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            ShopRealtimeModel *shopRealtime = [ShopRealtimeModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 保存更新时间
            NSDate *currentDate = [NSDate date];//获取当前时间，日期
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"hh:mm"];
            NSString *dateString = [dateFormatter stringFromDate:currentDate];
            shopRealtime.update_time = dateString;
            // 结束下拉刷新
            [scrollView.mj_header endRefreshing];
            // 请求成功
            if (success) {
                success(shopRealtime);
            }
        }else if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"4"]) {
            // 结束下拉刷新
            [scrollView.mj_header endRefreshing];
            if (noLogin) {
                noLogin();
            }
        }else {
            // 结束下拉刷新
            [scrollView.mj_header endRefreshing];
            if (failure) {
                failure();
            }
        }
    } failure:^(NSError *error) {
        // 结束下拉刷新
        [scrollView.mj_header endRefreshing];
        if (failure) {
            failure();
        }
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}

@end
