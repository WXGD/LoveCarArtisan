//
//  leftRigText.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//


// 自定义左右label样式类型
typedef NS_ENUM(NSInteger, leftRigTextTypeChoice) {
    /** 两个label横向布局，并且相对父视图剧左 */
    VerticallyLayoutAndLeftAlign,
    /** 两个label横向布局，并且相对父视图剧中 */
    VerticallyLayoutAndCenter,
    /** 两个label横向布局，并且相对父视图剧左，右边label可换行 */
    VerticallyLayoutAndLeftAlignAndRightWrap,
};

#import <UIKit/UIKit.h>

@interface leftRigText : UIView

/** 左边文字 */
@property (strong, nonatomic) UILabel *leftText;
/** 右边文字 */
@property (strong, nonatomic) UILabel *rightText;
/** text样式 */
@property (assign, nonatomic) leftRigTextTypeChoice leftRigTextTypeChoice;

@end
