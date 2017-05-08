//
//  UserCardListNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardListNetwork.h"

@interface UserCardListNetwork ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation UserCardListNetwork


// 下拉刷新
- (void)cardListRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCardArray))success {
    /*/index.php?c=provider_user_card&a=list&v=1
     provider_id 	int 	是 	服务商id
     provider_user_id 	int 	否 	用户id(用户信息中查看卡信息必传)
     user_input 	string 	否 	用户输入的值(支付时获取卡信息必传)
     start 	int 	否 	记录开始位置，默认为0
     pageSize 	int 	否 	每页显示条数,默认为10     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user_card", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 每页显示条数,默认为10
    parameters[@"start"] = @"0"; // 记录开始位置，默认为0
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"providerUserCardList" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *userCardArray = [UserMemberCardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            // 请求成功
            if (success) {
                success(userCardArray);
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
- (void)cardListLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCardArray))success {
    /*/index.php?c=provider_user_card&a=list&v=1
     provider_id 	int 	是 	服务商id
     provider_user_id 	int 	否 	用户id(用户信息中查看卡信息必传)
     user_input 	string 	否 	用户输入的值(支付时获取卡信息必传)
     start 	int 	否 	记录开始位置，默认为0
     pageSize 	int 	否 	每页显示条数,默认为10     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user_card", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 每页显示条数,默认为10
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 记录开始位置，默认为0
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"providerUserCardList" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *userCardArray = [UserMemberCardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (userCardArray.count != 20) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success(userCardArray);
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
