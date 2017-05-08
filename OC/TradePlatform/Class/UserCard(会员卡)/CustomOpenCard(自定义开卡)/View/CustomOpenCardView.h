//
//  CustomOpenCardView.h
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

// 自定义开卡点击类型
typedef NS_ENUM(NSInteger, CustomOpenCardBottonAction) {
    /** 手机号 */
    PhoneBtnAction,
    /** 车牌号 */
    PlnBtnAction,
    /** 卡名称 */
    CardNameBtnAction,
    /** 卡类型 */
    CardTypeBtnAction,
    /** 可用服务 */
    UsableServiceBtnAction,
    /** 次数 */
    NumberBtnAction,
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

@interface CustomOpenCardView : UIView

/** 手机号view */
@property (strong, nonatomic) UsedCellView *phoneView;
/** 车牌号view */
@property (strong, nonatomic) UsedCellView *plnView;
/** 用户名view */
@property (strong, nonatomic) UsedCellView *userNameView;
/** 卡名称view */
@property (strong, nonatomic) UsedCellView *cardNameView;
/** 卡类型view */
@property (strong, nonatomic) UsedCellView *cardTypeView;
/** 可用服务view */
@property (strong, nonatomic) UILabel *usableServiceLabel;
@property (strong, nonatomic) UIButton *usableServiceBtn;
/** 次数view */
@property (strong, nonatomic) UsedCellView *numView;
/** 售价view */
@property (strong, nonatomic) UsedCellView *priceView;
/** 赠品view */
@property (strong, nonatomic) UILabel *premiumContentLabel;
@property (strong, nonatomic) UIButton *premiumBtn;
/** 销售员view */
@property (strong, nonatomic) UsedCellView *salespersonView;
/** 确认开卡 */
@property (strong, nonatomic) UIButton *confirOpenCardBtn;

/** 聚合输入框信息 */
@property (strong, nonatomic) RACSignal *aggregationInfo;

@end
