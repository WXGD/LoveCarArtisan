//
//  PostalInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// 模型
#import "WithdrawRecordModel.h"

@interface PostalInfoViewController : RootViewController

/** 提现详情模型 */
@property (strong, nonatomic) WithdrawRecordModel *postalInfoModel;

@end
