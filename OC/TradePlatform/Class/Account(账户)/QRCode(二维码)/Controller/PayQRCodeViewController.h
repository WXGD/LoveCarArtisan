//
//  PayQRCodeViewController.h
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//


// 第三方支付页面使用类型
typedef NS_ENUM(NSInteger, PayQRCodePageType) {
    /** 收银页使用 */
    CashierUseVCPageType,
    /** 开卡页使用 */
    OpenCardUseVCPageType,
    /** 充值页使用 */
    RechargeUseVCPageType,
};


#import "RootViewController.h"
#import "UserModel.h"
// 下级控制器
#import "PaySuccessViewController.h"

@interface PayQRCodeViewController : RootViewController

/** nav标题 */
@property (strong, nonatomic) NSString *navTitle;
/** 支付参数 */
@property (strong, nonatomic) NSMutableDictionary *payParams;
/** 用户信息(修改用户信息时需要) */
@property (strong, nonatomic) UserModel *userInfo;
/** 第三方支付页面使用类型 */
@property (assign, nonatomic) PayQRCodePageType payQRCodePageType;
/** 支付成功页面来源 */
@property (assign, nonatomic) PaySuccessVCSource paySuccessVCSource;

@end
