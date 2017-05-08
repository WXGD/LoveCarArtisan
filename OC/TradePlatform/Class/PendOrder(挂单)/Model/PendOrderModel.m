//
//  PendOrderModel.m
//  TradePlatform
//
//  Created by 祝豪杰 on 17/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PendOrderModel.h"
@interface PendOrderModel ()

/** 请求接点 */
@property(assign, nonatomic) NSInteger start;

@end

@implementation PendOrderModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"detail" : [ShoppingCartModel class]};
}

// 下拉刷新
- (void)orderRefreshRequestData:(UITableView *)tableView
                         params:(NSMutableDictionary *)params
                 viewController:(UIViewController *)viewController
                        success:(void (^)(NSMutableArray *orderArray))success {
  /**/
  NSString *URL = [NSString
      stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"cart", @"list", APIEdition];
  // 拼接请求参数
  NSMutableDictionary *parameters = params;
  parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
  parameters[@"start"] = @"0";     // 列表开始位置 从0开始
  self.start = 20;
  // 发送请求
  [TPNetRequest GET:URL
      parameters:parameters
      ProgressHUD:nil
      falseDate:@"pendOrderList"
      parentController:viewController
      success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
                    
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]]
                isEqual:@"0"]) {
          // 获取数据模型数组
          NSMutableArray *orderArray = [PendOrderModel
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
- (void)orderLoadRequestData:(UITableView *)tableView
                      params:(NSMutableDictionary *)params
              viewController:(UIViewController *)viewController
                     success:(void (^)(NSMutableArray *orderArray))success {
  /**/
  NSString *URL = [NSString
      stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"cart", @"list", APIEdition];
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
      falseDate:@"pendOrderList"
      parentController:viewController
      success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]]
                isEqual:@"0"]) {
          // 获取数据模型数组
          NSMutableArray *orderArray = [PendOrderModel
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



// 判断是否有挂单数据
+ (void)judgeCartDataParams:(NSMutableDictionary *)params success:(void(^)(BOOL cart))success {
    /**/
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"cart", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"1"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0";     // 列表开始位置 从0开始
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:nil parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *orderArray = [PendOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (orderArray.count != 0) {
                if (success) {
                    success(YES);
                }
            }else{
                if (success) {
                    success(NO);
                }
            }
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}


@end

