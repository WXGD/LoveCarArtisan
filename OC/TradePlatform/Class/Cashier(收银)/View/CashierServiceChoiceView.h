//
//  CashierServiceChoiceView.h
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

// 收银页服务选择按钮点击类型
typedef NS_ENUM(NSInteger, CashierServiceChoiceBtnAction) {
    /** 服务类型选择 */
    ServiceTypeChoiceBtnAction,
    /** 服务商品选择 */
    ServiceGoodsChoiceBtnAction,
    /** 服务师傅选择 */
    ServiceMasterChoiceBtnAction,
    /** 支付方式选择 */
    PayMethodChoiceBtnAction,
    /** 会员卡类型选择 */
    UserCardTyoeChoiceBtnAction,
    /** 车况 */
    CarConditionTypeChoiceBtnAction,
    /** 车辆用途 */
    CarUseTypeChoiceBtnAction,
    /** 订单支付状态 */
    OrderPayStateBtnAction,
    /** 用户筛选区间 */
    UserScreenServiceBtnAction,
    /** 余额筛选区间 */
    BalanceScreenServiceBtnAction,
    /** 余次筛选区间 */
    ThanTimesScreenServiceBtnAction,
    /** 优惠劵类型选择 */
    CouponTyoeChoiceBtnAction,
};

#import <UIKit/UIKit.h>
#import "PayMethodCell.h"
#import "ServiceGoodsCell.h"


@protocol CashierServiceChoiceDelegate <NSObject>

@optional
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath;

@end

@interface CashierServiceChoiceView : UIView

/** table数据 */
@property (strong, nonatomic) NSMutableArray *choiceArray;
/** 服务选择 */
@property (assign, nonatomic) CashierServiceChoiceBtnAction serviceChoice;
/** 代理 */
@property (assign, nonatomic) id<CashierServiceChoiceDelegate>delegate;

/** 显示 */
- (void)show;
/** 销毁 */
- (void)dismiss;

@end
