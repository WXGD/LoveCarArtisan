//
//  AccountBankViewController.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "AccountBankModel.h"
// 银行卡跳转
typedef NS_ENUM(NSInteger, BankViewFrom) {
    /** 选择银行卡 */
    BankSelect = 1,
    /** 银行卡管理 */
    management = 2,

};
@interface AccountBankViewController : RootViewController
/** 银行卡跳转 */
@property (assign, nonatomic) BankViewFrom bankViewFrom;
/** 选择银行block */
@property(copy, nonatomic) void (^selextBankClick)(BankCommonModel *bankCommonModel);
@end
