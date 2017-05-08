//
//  OpenCardView.h
//  TradePlatform
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 apple. All rights reserved.
//

// 自定义开卡点击类型
typedef NS_ENUM(NSInteger, OpenCardBottonAction) {
    /** 手机号 */
    PhoneBtnAction,
    /** 车牌号 */
    PlnBtnAction,
    /** 售价 */
    PriceBtnAction,
    /** 赠品 */
    PremiumBtnAction,
    /** 销售员 */
    SalespersonBtnAction,
    /** 确认开卡 */
    ConfirOpenCardBtnAction,
};


#import <UIKit/UIKit.h>
// view
#import "OpenCardInfoView.h"

@interface OpenCardView : UIView

/** 卡信息 */
@property (strong, nonatomic) OpenCardInfoView *cardInfoView;
/** 手机号 */
@property (strong, nonatomic) UsedCellView *phoneView;
/** 车牌号 */
@property (strong, nonatomic) UsedCellView *plnView;
/** 用户名view */
@property (strong, nonatomic) UsedCellView *userNameView;
/** 售价 */
@property (strong, nonatomic) UsedCellView *priceView;
/** 销售员 */
@property (strong, nonatomic) UsedCellView *salespersonView;
/** 赠品 */
@property (strong, nonatomic) UILabel *premiumContentLabel;
@property (strong, nonatomic) UIButton *premiumBtn;

/** 确认开卡 */
@property (strong, nonatomic) UIButton *confirOpenCardBtn;


@end
