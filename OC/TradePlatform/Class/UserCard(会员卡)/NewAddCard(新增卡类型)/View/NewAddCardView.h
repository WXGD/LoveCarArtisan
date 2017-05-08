//
//  NewAddCardView.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

// 新增卡按钮点击方法
typedef NS_ENUM(NSInteger, ChangeInfoExhibitionType) {
    /** 卡类型 */
    CardTypeBtnAction,
    /** 卡适用范围 */
    CardApplyBtnAction,
};

#import "KeyBoardView.h"

@interface NewAddCardView : KeyBoardView

/** 卡名称 */
@property (strong, nonatomic) UsedCellView *cardName;
/** 卡类型 */
@property (strong, nonatomic) UsedCellView *cardType;
/** 卡次数/余额 */
@property (strong, nonatomic) UsedCellView *cardNumber;
/** 卡原价 */
@property (strong, nonatomic) UsedCellView *cardOriginalPrice;
/** 卡销售价 */
@property (strong, nonatomic) UsedCellView *cardSalesPrice;
/** 卡适用范围 */
@property (strong, nonatomic) UILabel *canServiceContentLabel;
@property (strong, nonatomic) UIButton *canServiceBtn;

@end
