//
//  ShareView.h
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

// 分享方式点击类型
typedef NS_ENUM(NSInteger, ShareOptionBottonAction) {
    /** 微信分享 */
    WeiXinShareBtnAction,
    /** 手机号分享 */
    PhoneShareBtnAction,
    /** 短信分享 */
    SmsShareBtnAction,
};

#import <UIKit/UIKit.h>
/** 分享项目选择代理 */
@protocol ShareOptionChoiceDelegate <NSObject>

@optional
- (void)shareOptionChoiceBtnAction:(UIButton *)button;

@end

@interface ShareView : UIView

/** 分享项目选择代理 */
@property (assign, nonatomic) id<ShareOptionChoiceDelegate>delegate;

/** 显示 */
- (void)show;
/** 销毁 */
- (void)dismiss;



@end
