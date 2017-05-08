//
//  OpenCardSuccessView.h
//  TradePlatform
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

// 开卡成功页按钮点击类型
typedef NS_ENUM(NSInteger, OpenCardSuccessBottonAction) {
    /** 继续开卡 */
    ContinueOpenCardBtnAction,
    /** 返回首页 */
    ReturnHomeBtnAction,
};

#import <UIKit/UIKit.h>

@interface OpenCardSuccessView : UIView


/** 成功提示 */
@property (strong, nonatomic) UILabel *sucPromptLabel;
/** 继续开卡 */
@property (strong, nonatomic) UIButton *continueOpenCardBtn;
/** 返回首页 */
@property (strong, nonatomic) UIButton *returnHomeBtn;

@end
