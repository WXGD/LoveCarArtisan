//
//  UserDataSource.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserDataSource.h"

@interface UserDataSource ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end


@implementation UserDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}



// 下拉刷新
- (void)userRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSInteger arrayCount))success {
    /*/index.php?c=provider_user&a=list&v=1
     provider_id 	int 	是 	服务商id
     user_input 	string 	否 	用户手机号(支持模糊输入)
     start 	int 	否 	查询开始位置，默认为0
     pageSize 	int 	否 	每页显示条数，默认为10   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"providerUser" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            self.rowArray = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            [tableView reloadData];
            // 请求成功
            if (success) {
                success(self.rowArray.count);
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
- (void)userLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)())success {
    /*/index.php?c=provider_user&a=list&v=1
     provider_id 	int 	是 	服务商id
     mobile 	string 	否 	用户手机号(支持模糊输入)
     start 	int 	否 	查询开始位置，默认为0
     pageSize 	int 	否 	每页显示条数，默认为10   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] = @"2"; // 服务商项目类型 1：4S店；2：洗车行；3：维修店；4：加油站；
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"providerUser" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *queryUserModelArray = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 将数据模型添加到总模型数组中
            [self.rowArray addObjectsFromArray:queryUserModelArray];
            // 刷新tableView
            [tableView reloadData];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (queryUserModelArray.count != 20) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success();
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




- (Class)tableViewCellClass {
    return [UserCell class];
}

// 重写下面这个方法，指定cell对应的数据模型
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    ((UserCell *)cell).userModel = self.rowArray[indexPath.row];
    return cell;
}

@end


