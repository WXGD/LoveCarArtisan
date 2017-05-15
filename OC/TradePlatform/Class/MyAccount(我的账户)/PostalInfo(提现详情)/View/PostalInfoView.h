//
//  PostalInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostalInfoView : UIView

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *postalInfoScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIStackView *postalInfoBackView;
/** 申请时间 */
@property (strong, nonatomic) UsedCellView *applyTimeView;
/** 提现金额 */
@property (strong, nonatomic) UsedCellView *postalMoneyView;
/** 提现状态 */
@property (strong, nonatomic) UsedCellView *postalStateView;
/** 处理时间 */
@property (strong, nonatomic) UsedCellView *handleTimeView;
/** 处理人 */
@property (strong, nonatomic) UsedCellView *handleManView;
/** 提现时间段 */
@property (strong, nonatomic) UILabel *applyStartLabel;
@property (strong, nonatomic) UILabel *toLabel;
@property (strong, nonatomic) UILabel *applyEndLabel;
/** 回执单部分背景view */
@property (strong, nonatomic) UIView *receiptBackView;
/** 回执单 */
@property (strong, nonatomic) UIImageView *receiptImg;
/** 结算状态 1-已结算 2 -未结算 */
@property (assign, nonatomic) NSInteger withdraw_status;

@end
