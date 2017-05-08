//
//  DailyView.h
//  TradePlatform
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 apple. All rights reserved.
//

// 日报表页面按钮点击类型
typedef NS_ENUM(NSInteger, HomePageBottonAction) {
    /** 用户 */
    UserBtnAction,
    /** 营业额 */
    TurnoverBtnAction,
};



#import <UIKit/UIKit.h>
#import "TwoWordsLabel.h"

@interface DailyView : UIView

/** 用户 */
@property (strong, nonatomic) UIButton *userViewBtn;
/** 营业额 */
@property (strong, nonatomic) UIButton *turnoverViewBtn;

/** 今日用户 */
@property (strong, nonatomic) TwoWordsLabel *todayUser;
/** 昨日用户 */
@property (strong, nonatomic) TwoWordsLabel *yesterdayUser;
/** 今日用户增长率 */
@property (strong, nonatomic) TwoWordsLabel *todayUserGrowthRate;

/** 今日营业额 */
@property (strong, nonatomic) TwoWordsLabel *todayTurnover;
/** 昨日营业额 */
@property (strong, nonatomic) TwoWordsLabel *yesterdayTurnover;
/** 今日营业额增长率 */
@property (strong, nonatomic) TwoWordsLabel *todayTurnoverGrowthRate;


@end
