//
//  CashierView.h
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

// 收银页按钮点击类型
typedef NS_ENUM(NSInteger, CashierBottonAction) {
    /** 确认收款 */
    ConfirCashierBtnAction,
    /** 暂不收银 */
    TemporCashierBtnAction,
    /** 手机号 */
    PhoneBtnAction,
    /** 车牌号 */
    PlnBtnAction,
    /** 省份简称 */
    CaftaBtnAction,
    /** 用户名 */
    UserNameBtnAction,
    /** 类别 */
    ClassBtnAction,
    /** 服务 */
    ServiceBtnAction,
    /** 服务师傅 */
    ServiceMasterBtnAction,
    /** 优惠券 */
    CouponBtnAction,
};

#import <UIKit/UIKit.h>
#import "AddSubNumView.h"
#import "CashierBomView.h"
#import "PlnCellView.h"
#import "CashierBomView.h"

@protocol CashierViewDelegate <NSObject>

@optional
/** 修改销售价 */
- (void)editPretiumDelegate;

@end

@interface CashierView : UIView


/** 底部view */
@property (strong, nonatomic) CashierBomView *cashierBomView;
/** 手机号view */
@property (strong, nonatomic) CustomCell *phoneView;
/** 车牌号view */
@property (strong, nonatomic) PlnCellView *plnCellView;
/** 用户名 */
@property (strong, nonatomic) CustomCell *userNameView;
/** 类别view */
@property (strong, nonatomic) CustomCell *classView;
/** 服务view */
@property (strong, nonatomic) CustomCell *serviceView;
/** 数量操作 */
@property (strong, nonatomic) AddSubNumView *numberOperationBtn;
/** 销售价view */
@property (strong, nonatomic) CustomCell *pretiumView;
/** 服务师傅 */
@property (strong, nonatomic) CustomCell *serviceMasterView;
/** 优惠券 */
@property (strong, nonatomic) CustomCell *couponView;
/** 优惠券选择前 */
@property (assign, nonatomic) NSInteger couponChoiceBefore;
/** 优惠券选择后 */
@property (assign, nonatomic) double couponChoiceAfter;
/** 行驶里程 */
@property (strong, nonatomic) CustomCell *mileageView;
/** 下次保养时间 */
@property (strong, nonatomic) CustomCell *nextTimeView;
/** 收银代理 */
@property (assign, nonatomic) id<CashierViewDelegate>delegate;

@end
