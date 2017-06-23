//
//  GrantRecordModel.m
//  TradePlatform
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GrantRecordModel.h"

@interface GrantRecordModel ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation GrantRecordModel

// 下拉刷新
- (void)grantRecordRefresh:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *grantRecordArray))success {
    /*/index.php?c=coupon_grant_record&a=grant_list&v=1
     provider_id 	string 	是 	服务商id
     coupon_id 	int 	否 	优惠券id，全部为0
     user_input 	string 	否 	用户输入的手机号或车牌号
     start 	int 	否 	数据显示位置
     pageSize 	int 	否 	每页显示条数        */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon_grant_record", @"grant_list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"orderList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *grantRecordArray = [GrantRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            // 请求成功
            if (success) {
                success(grantRecordArray);
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
- (void)grantRecordLoad:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *grantRecordArray))success {
    /*/index.php?c=coupon_grant_record&a=grant_list&v=1
     provider_id 	string 	是 	服务商id
     coupon_id 	int 	否 	优惠券id，全部为0
     user_input 	string 	否 	用户输入的手机号或车牌号
     start 	int 	否 	数据显示位置
     pageSize 	int 	否 	每页显示条数        */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon_grant_record", @"grant_list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] = @"2"; // 服务商项目类型 1：4S店；2：洗车行；3：维修店；4：加油站；
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"orderList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *orderArray = [GrantRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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


/** 作废用户优惠卷 */
+ (void)invalidUserCoupon:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=coupon_grant_record&a=del&v=1
     provider_id 	int 	是 	服务商id
     coupon_grant_record_id 	int 	是 	用户优惠券id       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon_grant_record", @"del", APIEdition];
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
