//
//  DetaReportDataSource.m
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetaReportDataSource.h"

@interface DetaReportDataSource ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation DetaReportDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


// 请求报表数据
+ (void)requestReportDataParams:(NSMutableDictionary *)params success:(void(^)(ReportModel *current, ReportModel *last))success {
    /*/index.php?c=report&a=list&v=1
     provider_id 	int 	是 	服务商id
     type 	int 	是 	报表类型 1-日报 2-周报 3-月报
     start 	int 	否 	第几页， 默认为0
     pageSize 	int 	否 	每页显示条数，默认为10     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"report", @"list", APIEdition]; // 拼接请求参数
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在加载今日数据..." falseDate:@"Daily" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            DetaReportModel *detaReport = [DetaReportModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(detaReport.current, detaReport.last);
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
- (void)detaReportDropRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSInteger arrayCount, ReportModel *current, ReportModel *last))success {
    /*/index.php?c=report&a=list&v=1
     prov_no 	string 	是 	服务商编号
     type 	int 	是 	报表类型 1-日报 2-周报 3-月报
     start 	int 	否 	第几页， 默认为0
     pageSize 	int 	否 	每页显示条数，默认为10    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"report", @"list", APIEdition]; // 拼接请求参数
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"Week" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            DetaReportModel *detaReport = [DetaReportModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.rowArray = detaReport.history;
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            [tableView reloadData];
            // 请求成功
            if (success) {
                success(self.rowArray.count, detaReport.current, detaReport.last);
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
- (void)detaReportLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)())success {
    /*/index.php?c=report&a=list&v=1
     prov_no 	string 	是 	服务商编号
     type 	int 	是 	报表类型 1-日报 2-周报 3-月报
     start 	int 	否 	第几页， 默认为0
     pageSize 	int 	否 	每页显示条数，默认为10    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"report", @"list", APIEdition];    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"Week" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            DetaReportModel *detaReport = [DetaReportModel mj_objectWithKeyValues:responseObject[@"data"]];
            NSMutableArray *detaReportModelArray = detaReport.history;
            // 将数据模型添加到总模型数组中
            [self.rowArray addObjectsFromArray:detaReportModelArray];
            // 刷新tableView
            [tableView reloadData];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (detaReportModelArray.count != 20) {
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
    return [DateReportCell class];
}

// 重写下面这个方法，指定cell对应的数据模型
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    ((DateReportCell *)cell).reportModel = self.rowArray[indexPath.row];
    return cell;
}

@end
