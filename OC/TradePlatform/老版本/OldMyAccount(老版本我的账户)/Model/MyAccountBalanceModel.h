//
//  MyAccountBalanceModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WithdrawRecordModel.h"

@interface MyAccountBalanceModel : NSObject

/*  "withdraw": "0"  #已提现金额,
 "amount": "100.00"  #账户余额
 "withdraw_record": 提现记录 */
/** 已提现金额 */
@property (assign, nonatomic) double withdraw;
/** 账户余额 */
@property (assign, nonatomic) double amount;
/** 提现记录 */
@property (strong, nonatomic) NSMutableArray *withdraw_record;



/** 申请提现 */
+ (void)providerWithdrawParams:(NSMutableDictionary *)params success:(void(^)())success;
/** 请求账户余额和已经提现余额 */
+ (void)requestAccountBalance:(NSMutableDictionary *)params success:(void(^)(MyAccountBalanceModel *accountBalance))success;

@end
