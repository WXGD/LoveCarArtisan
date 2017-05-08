//
//  CashierView.h
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//


// 收银页按钮点击类型
typedef NS_ENUM(NSInteger, CashierBottonAction) {
    /** 查询用户 */
    QueryUserBtnAction,
    /** 用户信息完善 */
    PerfectUserInfoBtnAction,
    /** 用户信息不完善 */
    NoPerfectUserInfoBtnAction,
    /** 类别 */
    ClassBtnAction,
    /** 服务 */
    ServiceBtnAction,
    /** 数量操作 */
    NumberOperationBtnAction,
    /** 服务师傅 */
    ServiceMasterBtnAction,
    /** 总价view */
    PriceBtnAction,
    /** 确认收款 */
    ConfirmationCollectionBtnAction,
};


#import <UIKit/UIKit.h>
#import "leftRigText.h"
#import "AddSubNumView.h"

@interface CashierView : UIView

/** 输入框 */
@property (strong, nonatomic) UIView *textFieldView;
@property (strong, nonatomic) UITextField *queryTF;
@property (strong, nonatomic) UIButton *queryBtn;
/** 用户信息view */
@property (strong, nonatomic) UIView *userInfoView;
/** 用户信息完善 */
@property (strong, nonatomic) UIButton *perfectUserInfoBtn;
/** 用户信息不完善 */
@property (strong, nonatomic) UIButton *noPerfectUserInfoBtn;
/** 姓名 */
@property (strong, nonatomic) leftRigText *userNameLabel;
/** 车牌号  */
@property (strong, nonatomic) leftRigText *userPlnLabel;
/** 手机号 */
@property (strong, nonatomic) leftRigText *userPhoneLabel;
/** 类别view */
@property (strong, nonatomic) UsedCellView *classView;
/** 服务view */
@property (strong, nonatomic) UsedCellView *serviceView;
/** 数量操作 */
@property (strong, nonatomic) AddSubNumView *numberOperationBtn;
/** 服务师傅 */
@property (strong, nonatomic) UsedCellView *serviceMasterView;
/** 总价view */
@property (strong, nonatomic) UsedCellView *priceView;
/** 确认收款 */
@property (strong, nonatomic) UIButton *confirmationCollectionBtn;


// 创建查询提示view
- (void)establishQueryPromptView;
// 回收键盘
- (void)cashierTapAction;

@end
