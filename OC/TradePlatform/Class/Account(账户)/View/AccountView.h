//
//  AccountView.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

// 账户页面按钮点击类型
typedef NS_ENUM(NSInteger, AccountBottonAction) {
    /** 当前用户 */
    CurrentUserBtnAction,
    /** 商户信息 */
    TenantsInfoBtnAction,
    /** 二维码 */
    QRCodeBtnAction,
    /** 我的账户 */
    MyAccountBtnAction,
    /** 设置 */
    SetUpBtnAction,
    /** 关于我们 */
    aboutUsBtnAction,
};

#import <UIKit/UIKit.h>

@interface AccountView : UIView

/** 当前用户 */
@property (strong, nonatomic) UsedCellView *currentUserView;
/** 商户信息 */
@property (strong, nonatomic) UsedCellView *tenantsInfoView;
/** 二维码 */
@property (strong, nonatomic) UsedCellView *QRCodeView;
/** 我的账户 */
//@property (strong, nonatomic) UsedCellView *myAccountView;
/** 设置 */
@property (strong, nonatomic) UsedCellView *setUpView;
/** 关于我们 */
@property (strong, nonatomic) UsedCellView *aboutUsView;

@end
