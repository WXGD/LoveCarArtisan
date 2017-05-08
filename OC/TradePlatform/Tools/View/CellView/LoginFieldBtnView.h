//
//  LoginFieldBtnView.h
//  CarRepairFactory
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

// 登陆cell样式类型
typedef NS_ENUM(NSInteger, LoginCellStyleType) {
    /** 纯输入框类型 */
    PureTnputBoxType,
    /** 输入框+按钮类型 */
    InputBoxAddButtonType,
};
// 分割线样式类型
typedef NS_ENUM(NSInteger, LoginCellDividingLineType) {
    /** 全屏 */
    LoginCellDividingLineFullScreenLayout = 20,
};

#import <UIKit/UIKit.h>

@interface LoginFieldBtnView : UIView

/** 内容输入框 */
@property (strong, nonatomic) UITextField *contentField;
/** 验证按钮 */
@property (strong, nonatomic) UIButton *tfBtn;
/** view分割线 */
@property (strong, nonatomic) UIView *viewDividingLine;
/** 输入框和按钮分割线 */
@property (strong, nonatomic) UIView *tfDividingLine;


/** view样式 */
@property (assign, nonatomic) LoginCellStyleType loginCellStyleType;
/** 分割线样式 */
@property (assign, nonatomic) LoginCellDividingLineType loginCellDividingLineType;

@end
