//
//  SearchUserCarNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchUserCarNetwork.h"
#import "UserCarModel.h"

@interface SearchUserCarNetwork ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end


@implementation SearchUserCarNetwork


// 下拉刷新
- (void)searchUserCarRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success {
    /*/index.php?c=provider_user&a=search&v=1
     provider_id 	int 	是 	服务商id
     type 	int 	否 	查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
     search_value 	string 	否 	查询值
     start 	int 	否 	记录位置
     pageSize 	int 	否 	每页显示条数    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"search", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] = @"2"; // 查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
    parameters[@"pageSize"] = @"10"; // 每页显示条数
    parameters[@"start"] = @"0"; // 记录位置
    self.start = 10;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"ServiceUserCar" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *userArray = [UserCarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            // 请求成功
            if (success) {
                success(userArray);
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
- (void)searchUserCarLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success {
    /*/index.php?c=provider_user&a=search&v=1
     provider_id 	int 	是 	服务商id
     type 	int 	否 	查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
     search_value 	string 	否 	查询值
     start 	int 	否 	记录位置
     pageSize 	int 	否 	每页显示条数    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"search", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] = @"2"; // 查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
    parameters[@"pageSize"] = @"10"; // 每页显示条数
    parameters[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 记录位置
    self.start += 10;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"providerUser" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *userArray = [UserCarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (userArray.count != 10) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success(userArray);
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



@end
