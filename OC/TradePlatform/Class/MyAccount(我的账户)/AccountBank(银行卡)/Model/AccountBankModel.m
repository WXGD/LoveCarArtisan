//
//  AccountBankModel.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AccountBankModel.h"

@implementation AccountBankModel
// 下拉刷新
- (void)AccountBankRefreshRequestData:(UITableView *)tableView
                                params:(NSMutableDictionary *)params
                        viewController:(UIViewController *)viewController
                               success:(void (^)(AccountBankModel *accountBankModel))success {
    /**/
    NSString *URL = [NSString
                     stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_bank_account", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;

    // 发送请求
    [TPNetRequest GET:URL
           parameters:parameters
          ProgressHUD:@"加载中..."
            falseDate:@"providerbankaccountList"
     parentController:viewController
              success:^(id responseObject) {
                  PDLog(@"responseObject%@", responseObject);
                  PDLog(@"params%@", params);
                  //转json 字符串
                  
                  if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]]
                       isEqual:@"0"]) {
                      // 获取数据模型数组
                      AccountBankModel *accountBankModel = [AccountBankModel
                                                    mj_objectWithKeyValues:responseObject[@"data"]];
                      // 结束下拉刷新
                      [tableView.mj_header endRefreshing];
                      // 恢复数据加载
                      [tableView.mj_footer resetNoMoreData];
                      [tableView reloadData];
                      // 请求成功
                      if (success) {
                          success(accountBankModel);
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
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"DefaultModel" : @"default"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"common" : [BankCommonModel class]};
}
@end
@implementation BankDefaultModel

@end


@implementation BankCommonModel

@end


