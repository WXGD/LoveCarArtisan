//
//  OrderDataSource.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderDataSource.h"

@interface OrderDataSource ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation OrderDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


// 下拉刷新
- (void)orderRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSInteger arrayCount))success {
    /*/index.php?c=order&a=list&v=1
     staff_user_id 	int 	否 	登陆者id(商户app必传,用户自己获取时不传)
     provider_id 	int 	是 	服务商id
     order_category_id 	int 	否 	订单类型id，默认为0（代表全部）
     provider_user_id 	int 	否 	用户id,(获取用户消费记录时必传)
     order_status 	int 	否 	订单状态，默认为0（代表全部）
     sale_user_id 	int 	否 	服务师傅id,默认为0（代表全部）
     start 	int 	否 	列表开始位置，默认为0
     pageSize 	int 	否 	每页显示列表数,默认为10     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"orderList" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            self.rowArray = [OrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
- (void)orderLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)())success {
    /*/index.php?c=order&a=list&v=1
     staff_user_id 	int 	否 	登陆者id(商户app必传,用户自己获取时不传)
     provider_id 	int 	是 	服务商id
     order_category_id 	int 	否 	订单类型id，默认为0（代表全部）
     provider_user_id 	int 	否 	用户id,(获取用户消费记录时必传)
     order_status 	int 	否 	订单状态，默认为0（代表全部）
     sale_user_id 	int 	否 	服务师傅id,默认为0（代表全部）
     start 	int 	否 	列表开始位置，默认为0
     pageSize 	int 	否 	每页显示列表数,默认为10     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] = @"2"; // 服务商项目类型 1：4S店；2：洗车行；3：维修店；4：加油站；
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"orderList" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *orderModelArray = [OrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 将数据模型添加到总模型数组中
            [self.rowArray addObjectsFromArray:orderModelArray];
            // 刷新tableView
            [tableView reloadData];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (orderModelArray.count != 20) {
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
    return [OrderCell class];
}

// 重写下面这个方法，指定cell对应的数据模型
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    ((OrderCell *)cell).orderModel = self.rowArray[indexPath.row];
    return cell;
}

@end

