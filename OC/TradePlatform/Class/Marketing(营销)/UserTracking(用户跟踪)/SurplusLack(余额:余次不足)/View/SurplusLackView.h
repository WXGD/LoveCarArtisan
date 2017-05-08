//
//  SurplusLackView.h
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//


// 页面按钮点击
typedef NS_ENUM(NSInteger, SurplusLackBtnAction) {
    /** 余额不足 */
    BalanceNotEnoughBtnAction,
    /** 余次不足 */
    NumNotEnoughBtnAction,
};


#import <UIKit/UIKit.h>
// view
#import "ExpireTableView.h"

@protocol SurplusLackDelegate <NSObject>

@optional
- (void)cardSurplusTabChoiceDelegate:(NSInteger)bntTag;

@end

@interface SurplusLackView : UIView

@property (assign, nonatomic) id<SurplusLackDelegate>delegate;
/** 余额View */
@property (strong, nonatomic) ExpireTableView *balanceView;
/** 余次View */
@property (strong, nonatomic) ExpireTableView *leaveSecondView;

@end
