//
//  DetaReportModel.m
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetaReportModel.h"

@implementation DetaReportModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"history" : [ReportModel class]};
}

@end
