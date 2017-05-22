//
//  SetUpView.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

// 设置页面按钮点击类型
typedef NS_ENUM(NSInteger, SetUpBottonAction) {
    /** 清除缓存 */
    ClearCacheBtnAction,
    /** 当前版本 */
    CurrentVersionBtnAction,
    /** 意见反馈 */
    FeedbackBtnAction,
    /** 关于我们 */
    AboutUsBtnAction,
    /** 客服电话 */
    ServiceNumBtnAction,
    /** 功能介绍 */
    funcIntroBtnAction,
    /** 退出登录 */
    SignOutBtnAction,
};

#import <UIKit/UIKit.h>

@interface SetUpView : UIView

/** 清除缓存 */
@property (strong, nonatomic) UsedCellView *clearCacheView;
/** 当前版本 */
@property (strong, nonatomic) UsedCellView *currentVersionView;
/** 意见反馈 */
@property (strong, nonatomic) UsedCellView *feedbackView;
/** 关于我们 */
@property (strong, nonatomic) UsedCellView *aboutUsView;
/** 客服电话 */
@property (strong, nonatomic) UsedCellView *serviceNumView;
/** 功能介绍 */
@property (strong, nonatomic) UsedCellView *funcIntroView;
/** 退出当前账户 */
@property (strong, nonatomic) UIButton *signOutBtn;

@end
