//
//  CardInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

// 卡信息点击类型
typedef NS_ENUM(NSInteger, CardInfoBottonAction) {
    /** 卡名称view */
    CardNameBtnAction,
    /** 卡类型view */
    CardTypeBtnAction,
    /** 可用次数／可用金额view */
    CanNumMoneyBtnAction,
    /** 售价view */
    PriceBtnAction,
    /** 原价view */
    CostPriceBtnAction,
    /** 可用服务view */
    CanServiceBtnAction,
};

#import <UIKit/UIKit.h>

@interface CardInfoView : UIView

/** 卡名称view */
@property (strong, nonatomic) UsedCellView *cardNameView;
/** 卡类型view */
@property (strong, nonatomic) UsedCellView *cardTypeView;
/** 可用次数／可用金额view */
@property (strong, nonatomic) UsedCellView *canNumMoneyView;
/** 售价view */
@property (strong, nonatomic) UsedCellView *priceView;
/** 原价view */
@property (strong, nonatomic) UsedCellView *costPriceView;
/** 可用服务view */
@property (strong, nonatomic) UILabel *canServiceContentLabel;
@property (strong, nonatomic) UIButton *canServiceBtn;

@end
