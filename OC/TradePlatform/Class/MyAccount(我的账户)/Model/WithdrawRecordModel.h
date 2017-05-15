//
//  WithdrawRecordModel.h
//  TradePlatform
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawRecordModel : NSObject

/*  "withdraw_status": 2  #结算状态 1-已结算 2 -未结算,
 "withdraw_money": "0.00"  #提现金额,
 "create_time": "2017-02-06 11:11:17"  #提现时间,
 "withdraw_time": "2017-02-07 10:20:20"  #提现处理间,
 "withdraw_start_time": "2017-05-01 00:00:00"  #提现开始时间,
 "withdraw_end_time": "2017-05-07 23:59:59"  #提现结束时间,
 "receipt_url": ""  #提现回执单地址*/

/** 结算状态 1-已结算 2 -未结算 */
@property (assign, nonatomic) NSInteger withdraw_status;
/** 提现金额 */
@property (assign, nonatomic) double withdraw_money;
/** 提现时间 */
@property (copy, nonatomic) NSString *create_time;
/** 提现处理时间 */
@property (copy, nonatomic) NSString *withdraw_time;
/** 提现开始时间 */
@property (copy, nonatomic) NSString *withdraw_start_time;
/** 提现结束时间 */
@property (copy, nonatomic) NSString *withdraw_end_time;
/** 提现回执单地址 */
@property (copy, nonatomic) NSString *receipt_url;
/** 处理人姓名 */
@property (copy, nonatomic) NSString *operator_name;
@end
