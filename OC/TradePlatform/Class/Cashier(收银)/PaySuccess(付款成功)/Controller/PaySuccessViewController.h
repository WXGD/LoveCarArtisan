//
//  PaySuccessViewController.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

// 支付成功页面来源
typedef NS_ENUM(NSInteger, PaySuccessVCSource) {
    /** 收银页 */
    CashierPaySuccessVCSource,
    /** 挂单页 */
    PendOrderPaySuccessVCSource,
};

#import "RootViewController.h"
#import "UserModel.h"

@interface PaySuccessViewController : RootViewController

/** 用户信息(修改用户信息时需要) */
@property (strong, nonatomic) UserModel *userInfo;
/** 页面来源 */
@property (assign, nonatomic) PaySuccessVCSource paySuccessVCSource;

@end
