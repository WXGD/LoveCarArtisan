//
//  OpenCardSuccessViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//


// 第三方支付页面使用类型
typedef NS_ENUM(NSInteger, OpenCardSuccessType) {
    /** 开卡页使用 */
    OpenCardUseType,
    /** 充值页使用 */
    RechargeUseType,
};


#import "RootViewController.h"

@interface OpenCardSuccessViewController : RootViewController

/** 开卡页使用，充值页使用 */
@property (assign, nonatomic) OpenCardSuccessType openCardSuccessType;


@end
