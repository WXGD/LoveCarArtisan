//
//  DetaReportDataSource.h
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GJBaseDataSource.h"
#import "DateReportCell.h"
#import "DetaReportModel.h"

@interface DetaReportDataSource : GJBaseDataSource


// 请求报表数据
+ (void)requestReportDataParams:(NSMutableDictionary *)params success:(void(^)(ReportModel *current, ReportModel *last))success;


// 下拉刷新
- (void)detaReportDropRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSInteger arrayCount, ReportModel *current, ReportModel *last))success;

// 上啦加载
- (void)detaReportLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)())success;

@end
