//
//  UserMemberCardModel.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserMemberCardModel.h"

@interface UserMemberCardModel ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation UserMemberCardModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"descri" : @"description"};
}


- (void)setUsed_goods_text:(NSString *)used_goods_text {
    _used_goods_text = used_goods_text;
    if (used_goods_text.length == 0) {
        _used_goods_text = @"全部服务";
    }
}

- (void)setDescri:(NSString *)descri {
    _descri = descri;
    if (!descri || descri.length == 0) {
        _descri = @"无";
    }
}

// 下拉刷新
- (void)userCardRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCardArray, NSDictionary *options))success {
    /*/index.php?c=provider_card&a=statistic&v=1
     provider_id 	int 	是 	服务商id
     provider_card_id 	int 	是 	服务商卡id(全部为0)
     start 	int 	否 	页数，默认为0
     pageSize 	int 	否 	每页显示条数,默认为10    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_card", @"statistic", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
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
                success(userCardArray, responseObject[@"options"]);
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
- (void)userCardLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCardArray))success {
    /*/index.php?c=provider_card&a=statistic&v=1
     provider_id 	int 	是 	服务商id
     provider_card_id 	int 	是 	服务商卡id(全部为0)
     start 	int 	否 	页数，默认为0
     pageSize 	int 	否 	每页显示条数,默认为10    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_card", @"statistic", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"success" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *userCardModelArray = [UserMemberCardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (userCardModelArray.count != 20) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success(userCardModelArray);
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
