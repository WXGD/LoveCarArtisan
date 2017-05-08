//
//  LogInView.h
//  CarRepairFactory
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

// 登陆页面按钮点击类型
typedef NS_ENUM(NSInteger, SetUpBottonAction) {
    /** 获取验证码 */
    VerificationBtnAction,
    /** 登陆 */
    LoginBtnAction,
};

#import <UIKit/UIKit.h>
#import "LoginFieldBtnView.h"

@interface LogInView : UIView

/** 登录按钮（密码登陆） */
@property (strong, nonatomic) UIButton *passwordLoginBtn;
/** 登录按钮（验证码登陆） */
@property (strong, nonatomic) UIButton *verificationLoginBtn;
/** 用户名（密码登陆） */
@property (strong, nonatomic) LoginFieldBtnView *passwordUserName;
/** 用户名（验证码登陆） */
@property (strong, nonatomic) LoginFieldBtnView *verificationUserName;
/** 用户密码 */
@property (strong, nonatomic) LoginFieldBtnView *userPassword;
/** 验证码 */
@property (strong, nonatomic) LoginFieldBtnView *verification;
/** 切换登录方式 */
@property (strong, nonatomic) UIButton *loginMode;

@end
