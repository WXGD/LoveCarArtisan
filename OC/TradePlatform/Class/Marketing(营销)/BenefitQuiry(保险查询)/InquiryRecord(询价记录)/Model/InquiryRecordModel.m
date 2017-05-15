//
//  InquiryRecordModel.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "InquiryRecordModel.h"
@interface InquiryRecordModel ()

/** 请求接点 */
@property(assign, nonatomic) NSInteger start;

@end
@implementation InquiryRecordModel
// 下拉刷新
- (void)inquiryRecordRefreshRequestData:(UITableView *)tableView
                         params:(NSMutableDictionary *)params
                 viewController:(UIViewController *)viewController
                        success:(void (^)(NSMutableArray *orderArray))success {
    /**/
    NSString *URL = [NSString
                     stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"list", APITWOEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0";     // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL
           parameters:parameters
          ProgressHUD:nil
            falseDate:@"insurancequeryList"
     parentController:viewController
              success:^(id responseObject) {
                  PDLog(@"responseObject%@", responseObject);
                  PDLog(@"params%@", params);
                  //转json 字符串

                  if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]]
                       isEqual:@"0"]) {
                      // 获取数据模型数组
                      NSMutableArray *orderArray = [InquiryRecordModel
                                                    mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                      // 结束下拉刷新
                      [tableView.mj_header endRefreshing];
                      // 恢复数据加载
                      [tableView.mj_footer resetNoMoreData];
                      [tableView reloadData];
                      // 请求成功
                      if (success) {
                          success(orderArray);
                      }
                  } else {
                      // 结束下拉刷新
                      [tableView.mj_header endRefreshing];
                      [MBProgressHUD showError:responseObject[@"msg"]];
                  }
              }
              failure:^(NSError *error) {
                  // 结束下拉刷新
                  [tableView.mj_header endRefreshing];
                  // 恢复数据加载
                  [tableView.mj_footer resetNoMoreData];
                  [MBProgressHUD showError:@"请求失败"];
                  PDLog(@"%@", error);
              }];
}

// 上啦加载
- (void)inquiryRecordRequestData:(UITableView *)tableView
                      params:(NSMutableDictionary *)params
              viewController:(UIViewController *)viewController
                     success:(void (^)(NSMutableArray *orderArray))success {
    /**/
    NSString *URL = [NSString
                     stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"list", APITWOEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] =
    @"2";                        // 服务商项目类型 1：4S店；2：洗车行；3：维修店；4：加油站；
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString
                        stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL
           parameters:parameters
          ProgressHUD:nil
            falseDate:@"insurancequeryList"
     parentController:viewController
              success:^(id responseObject) {
                  PDLog(@"responseObject%@", responseObject);
                  PDLog(@"params%@", params);
                  if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]]
                       isEqual:@"0"]) {
                      // 获取数据模型数组
                      NSMutableArray *orderArray = [InquiryRecordModel
                                                    mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
                  } else {
                      [MBProgressHUD showError:responseObject[@"msg"]];
                  }
              }
              failure:^(NSError *error) {
                  // 结束刷新
                  [tableView.mj_footer endRefreshing];
                  [MBProgressHUD showError:@"请求失败"];
                  PDLog(@"%@", error);
              }];
}
@end



