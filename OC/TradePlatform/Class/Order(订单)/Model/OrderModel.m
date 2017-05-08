//
//  OrderModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderModel.h"

@interface OrderModel ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation OrderModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"order_detail" : [OrderGoodsModel class]};
}


// 下拉刷新
- (void)orderRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *orderArray))success {
    /*/index.php?c=order&a=list&v=1
     staff_user_id 	int 	否 	登陆者id(商户app必传,用户自己获取时不传)
     provider_id 	int 	是 	服务商id
     order_category_id 	int 	否 	订单类型id，默认为0（代表全部）
     provider_user_id 	int 	否 	用户id,(获取用户消费记录时必传)
     order_status 	int 	否 	订单状态，默认为0（代表全部）
     sale_user_id 	int 	否 	服务师傅id,默认为0（代表全部）
     pay_method 	int 	否 	支付方式, 1-支付宝 2-微信 3-会员卡 4-现金 (默认为0,代表全部)
     goods_category_id 	int 	否 	服务类别id,默认为0（代表全部）
     order_time 	string 	否 	订单时间区间,格式： 开始时间_截至时间,默认为''(代表全部)
     start 	int 	否 	列表开始位置，默认为0
     pageSize 	int 	否 	每页显示列表数,默认为10      */
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
            NSMutableArray *orderArray = [OrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            [tableView reloadData];
            // 请求成功
            if (success) {
                success(orderArray);
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
- (void)orderLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *orderArray))success {
    /*/index.php?c=order&a=list&v=1
     staff_user_id 	int 	否 	登陆者id(商户app必传,用户自己获取时不传)
     provider_id 	int 	是 	服务商id
     order_category_id 	int 	否 	订单类型id，默认为0（代表全部）
     provider_user_id 	int 	否 	用户id,(获取用户消费记录时必传)
     order_status 	int 	否 	订单状态，默认为0（代表全部）
     sale_user_id 	int 	否 	服务师傅id,默认为0（代表全部）
     pay_method 	int 	否 	支付方式, 1-支付宝 2-微信 3-会员卡 4-现金 (默认为0,代表全部)
     goods_category_id 	int 	否 	服务类别id,默认为0（代表全部）
     order_time 	string 	否 	订单时间区间,格式： 开始时间_截至时间,默认为''(代表全部)
     start 	int 	否 	列表开始位置，默认为0
     pageSize 	int 	否 	每页显示列表数,默认为10      */
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
            NSMutableArray *orderArray = [OrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 刷新tableView
            [tableView reloadData];
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


@end
