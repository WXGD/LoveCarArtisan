//
//  CouponGoverModel.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponGoverModel.h"

@interface CouponGoverModel ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation CouponGoverModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"descri" : @"description"};
}


// 请求全部优惠劵种类
+ (void)requesWholeCouponType:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *couponListArray))success {
    /*/index.php?c=coupon&a=all_list&v=1
     provider_id 	int 	是 	服务商id
     start 	int 	否 	记录位置,默认0
     status 	int 	否 	优惠券状态: 0-禁用 1-启用 2-过期
     pageSize 	int 	否 	每页显示条数,默认0,显示全部       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon", @"all_list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"CouponList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *couponListArray = [CouponGoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(couponListArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}



// 下拉刷新
- (void)couponGoverRefresh:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *couponListArray))success {
    /*/index.php?c=coupon&a=all_list&v=1
     provider_id 	int 	是 	服务商id
     start 	int 	否 	记录位置,默认0
     status 	int 	否 	优惠券状态: 0-禁用 1-启用 2-过期
     pageSize 	int 	否 	每页显示条数,默认0,显示全部       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon", @"all_list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"CouponList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *couponListArray = [CouponGoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            // 请求成功
            if (success) {
                success(couponListArray);
            }
        }else {
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        // 结束下拉刷新
        [tableView.mj_header endRefreshing];
        // 恢复数据加载
        [tableView.mj_footer resetNoMoreData];
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}

// 上啦加载
- (void)couponGoverLoad:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *couponListArray))success {
    /*/index.php?c=coupon&a=all_list&v=1
     provider_id 	int 	是 	服务商id
     start 	int 	否 	记录位置,默认0
     status 	int 	否 	优惠券状态: 0-禁用 1-启用 2-过期 
     pageSize 	int 	否 	每页显示条数,默认0,显示全部       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon", @"all_list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] = @"2"; // 服务商项目类型 1：4S店；2：洗车行；3：维修店；4：加油站；
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *orderArray = [CouponGoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (orderArray.count != 20) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success(orderArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        // 结束刷新
        [tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}

/** 编辑优惠劵状态 */
+ (void)editCouponState:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=coupon&a=change_status&v=1
     provider_id 	int 	是 	服务商id
     coupon_id 	int 	是 	优惠券id
     status 	int 	是 	要修改的状态值： 0-禁用 1-启用        */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon", @"change_status", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
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
