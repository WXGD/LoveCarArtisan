//
//  MarketingView.h
//  TradePlatform
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

// 营销页点击类型
typedef NS_ENUM(NSInteger, MarketingBottonAction) {
    /** 保险 */
    BenefitBtnAction,
    /** 二手车 */
    UsedCarBtnAction,
    /** 会员卡到期 */
    CardExpireBtnAction,
    /** 会员卡余额不足 */
    BalanceNotEnoughBtnAction,
    /** 长期未到店 */
    LongNotShopBtnAction,
};

#import <UIKit/UIKit.h>
#import "MarketingCell.h"

@interface MarketingView : UIView

/** 保险 */
@property (strong, nonatomic) MarketingCell *benefitView;
/** 二手车 */
@property (strong, nonatomic) MarketingCell *usedCarView;
/** 用户跟踪 */
@property (strong, nonatomic) MarketingCell *userTrackingView;
/** 会员卡到期 */
@property (strong, nonatomic) UIButton *cardExpireBtn;
/** 会员卡余额不足 */
@property (strong, nonatomic) UIButton *balanceNotEnoughBtn;
/** 长期未到店 */
@property (strong, nonatomic) UIButton *longNotShopBtn;

@end
