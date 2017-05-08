//
//  NewsModel.m
//  TradePlatform
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsModel.h"

@interface NewsModel ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end


@implementation NewsModel

// 下拉刷新
- (void)newsRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *newsArray))success {
    /*/index.php?c=provider_notify&a=list&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     start 	int 	否 	记录开始位置，默认为0
     pageSize 	int 	否 	每页显示条数,默认为10   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_notify", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"news" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *newsArray = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            // 请求成功
            if (success) {
                success(newsArray);
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




// 上啦加载
- (void)newsLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *newsArray))success {
    /*/index.php?c=provider_notify&a=list&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     start 	int 	否 	记录开始位置，默认为0
     pageSize 	int 	否 	每页显示条数,默认为10   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_notify", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] = @"2"; // 服务商项目类型 1：4S店；2：洗车行；3：维修店；4：加油站；
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"providerUser" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *newsArray = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (newsArray.count != 20) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success(newsArray);
            }
        }else {
            // 结束下拉刷新
            [tableView.mj_footer endRefreshing];
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
