//
//  QuotationModel.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QuotationModel.h"

@implementation QuotationModel
-(void)quotationRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void (^)(NSMutableArray *))success{
    /**/
    NSString *URL = [NSString
                     stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"detail", APITWOEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL
           parameters:parameters
          ProgressHUD:@"加载中..."
            falseDate:@"inquiryRecordList"
     parentController:viewController
              success:^(id responseObject) {
                  PDLog(@"responseObject%@", responseObject);
                  PDLog(@"params%@", params);
                  
                  if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]]
                       isEqual:@"0"]) {
                      // 获取数据模型数组
                      NSMutableArray *orderArray = [QuotationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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


+ (NSDictionary *)objectClassInArray{
    return @{@"insurance_quote" : [InsuranceQuoteModel class]};
}
@end

@implementation InsuranceQuoteModel

@end


