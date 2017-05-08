//
//  DetaReportModel.h
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GJBaseModel.h"
#import "ReportModel.h"

@interface DetaReportModel : GJBaseModel

@property (nonatomic, copy) NSString *name;

/*  "current":{ },
    "last":*/

/** 现在的数据 */
@property (nonatomic, strong) ReportModel *current;
/** 以前的数据 */
@property (nonatomic, strong) ReportModel *last;




/** 订单数据 */
@property (nonatomic, strong) NSMutableArray *history;

@end
