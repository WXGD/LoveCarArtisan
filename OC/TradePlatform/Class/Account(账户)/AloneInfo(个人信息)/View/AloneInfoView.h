//
//  AloneInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

// 个人信息页面按钮点击类型
typedef NS_ENUM(NSInteger, AccountBottonAction) {
    /** 名字 */
    AccountNameBtnAction,
    /** 手机号 */
    TelPhoneBtnAction,
    /** 修改密码 */
    DelPasswordBtnAction,
};


#import <UIKit/UIKit.h>

@interface AloneInfoView : UIView

/** 名字 */
@property (strong, nonatomic) CustomCell *accountName;
/** 手机号 */
@property (strong, nonatomic) CustomCell *telPhone;
/** 修改密码 */
@property (strong, nonatomic) CustomCell *delPassword;

@end
