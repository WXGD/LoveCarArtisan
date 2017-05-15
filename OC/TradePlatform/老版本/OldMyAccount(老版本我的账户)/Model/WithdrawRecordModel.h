//
//  WithdrawRecordModel.h
//  TradePlatform
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawRecordModel : NSObject

/* "withdraw_status": 2  #结算状态 1-已结算 2 -未结算,
 "withdraw_money": "0.00"  #提现金额,
 "create_time": "2017-02-06 11:11:17"  #提现时间,
 "withdraw_time": "2017-02-07 10:20:20"  #提现处理时间*/

/** 结算状态 */
@property (assign, nonatomic) NSInteger withdraw_status;
/** 提现金额 */
@property (assign, nonatomic) double withdraw_money;
/** 提现时间 */
@property (copy, nonatomic) NSString *create_time;
/** 提现处理时间 */
@property (copy, nonatomic) NSString *withdraw_time;

@end
