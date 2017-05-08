//
//  DateReportView.h
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportHeaderView.h"
#import "OrderTypeTitleView.h"
// table
#import "GJBaseTabelView.h"
#import "DetaReportDataSource.h"

@interface DateReportView : UIView

/** 报表头部view */
@property (strong, nonatomic) ReportHeaderView *reportHeaderView;
/** 订单列表 */
@property (strong, nonatomic) GJBaseTabelView *orderListTable;
/** 订单列表数据 */
@property (strong, nonatomic) DetaReportDataSource *detaReportDataSource;

@end
