//
//  AccountBankAddViewController.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "AccountBankModel.h"

@interface AccountBankAddViewController : RootViewController
/** 保存并使用银行卡 */
@property(copy, nonatomic) void (^saveUseBtnClick)(BankCommonModel *bankCommonModel);
@end
