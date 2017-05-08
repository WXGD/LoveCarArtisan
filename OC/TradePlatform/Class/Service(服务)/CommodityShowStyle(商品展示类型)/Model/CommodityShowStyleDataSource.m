//
//  CommodityShowStyleDataSource.m
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommodityShowStyleDataSource.h"

@interface CommodityShowStyleDataSource ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end


@implementation CommodityShowStyleDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


// 上架服务
- (void)shelvesServiceParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=goods&a=on&v=1
     goods_id 	int 	是 	商品id
     staff_user_id 	int 	是 	登录者id    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods", @"on", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:nil falseDate:@"success" parentController:nil success:^(id responseObject) {
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


// 下架服务
- (void)deleServiceParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=goods&a=off&v=1
     goods_id 	int 	是 	商品id
     staff_user_id 	int 	是 	登录者id   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods", @"off", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:nil falseDate:@"success" parentController:nil success:^(id responseObject) {
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



// 下拉刷新
- (void)commodityRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSInteger arrayCount))success {
    /*/index.php?c=goods&a=list&v=1
     provider_id 	int 	是 	服务id
     goods_category_id 	int 	否 	商品分类id，(获取某类商品中必传)
     status 	int 	是 	0-下架 1-在售 2-全部（为了支持旧版，新版必须传）
     start 	int 	否 	列表开始位置,默认为0
     pageSize 	int 	否 	每页显示条数,不传则显示所有  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    NSString *falseDate = [params[@"status"] isEqualToString:@"0"] ? @"FromSaleCommodity" : @"providerWholeCommodity";
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:falseDate parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            self.rowArray = [CommodityShowStyleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
- (void)commodityLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)())success {
    /*/index.php?c=goods&a=list&v=1
     provider_id 	int 	是 	服务id
     goods_category_id 	int 	否 	商品分类id，(获取某类商品中必传)
     status 	int 	是 	0-下架 1-在售 2-全部（为了支持旧版，新版必须传）
     start 	int 	否 	列表开始位置,默认为0
     pageSize 	int 	否 	每页显示条数,不传则显示所有  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    NSString *falseDate = [params[@"status"] isEqualToString:@"0"] ? @"FromSaleCommodity" : @"providerWholeCommodity";
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:falseDate parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *commodityModelArray = [CommodityShowStyleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 将数据模型添加到总模型数组中
            [self.rowArray addObjectsFromArray:commodityModelArray];
            // 刷新tableView
            [tableView reloadData];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (commodityModelArray.count != 20) {
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



@end

