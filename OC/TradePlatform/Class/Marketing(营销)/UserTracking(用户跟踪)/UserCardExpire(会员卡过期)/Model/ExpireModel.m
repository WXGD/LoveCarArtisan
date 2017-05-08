//
//  ExpireModel.m
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ExpireModel.h"

@implementation ExpireModel


// 获取数据区间信息
+ (void)requestDataSection:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *sectionArray))success {
    /* /index.php?c=user_track&a=section&v=1
     provider_id 	int 	是 	服务商id
     type 	int 	是 	获取区间的类型 1-会员卡到期区间 2-会员卡余额不足区间 3-会员卡余次不足区间 4-会员长期未到店区间 5-用户消费区间      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"user_track", @"section", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"UserTrackDataSection" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *sectionArray = [ExpireModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(sectionArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


// 添加数据区间信息
+ (void)addDataSection:(NSMutableDictionary *)params success:(void(^)())success {
    /* /index.php?c=user_track&a=add_section&v=1
     provider_id 	int 	是 	服务商i的
     type 	int 	是 	数据类型 1-会员卡到期区间 2-会员卡余额不足区间 3-会员卡余次不足区间 4-会员长期未到店区间 5-用户消费区间
     min_value 	int 	是 	区间最小值
     max_value 	int 	是 	区间最大值    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"user_track", @"add_section", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
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

// 删除数据区间信息
+ (void)delDataSection:(NSMutableDictionary *)params success:(void(^)())success {
    /* /index.php?c=user_track&a=del_section&v=1
     user_track_id 	int 	是 	区间id     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"user_track", @"del_section", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
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
