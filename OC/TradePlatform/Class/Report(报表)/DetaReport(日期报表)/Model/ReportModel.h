//
//  ReportModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJBaseModel.h"

@interface ReportModel : GJBaseModel

/*"count": 1  #用户数,
 "amount": "0"  #金额数
 data: 日期*/
/** 用户数 */
@property (nonatomic, assign) NSInteger count;
/** 金额数 */
@property (nonatomic, assign) double amount;
/** 日期 */
@property (nonatomic, copy) NSString *date;

@end
