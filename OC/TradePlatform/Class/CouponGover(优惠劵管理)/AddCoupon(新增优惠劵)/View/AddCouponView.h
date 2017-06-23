//
//  AddCouponView.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "GJTextView.h"

@interface AddCouponView : UIView

/** 优惠卷名称 */
@property (strong, nonatomic) CustomCell *couponNameView;
/** 优惠卷面值 */
@property (strong, nonatomic) CustomCell *couponPoundView;
/** 优惠卷使用条件 */
@property (strong, nonatomic) CustomCell *couponUseCondView;
/** 优惠卷是否只能领一张开关 */
@property (strong, nonatomic) UISwitch *isOnlySwitch;
/** 优惠卷开放时间 */
@property (strong, nonatomic) CustomCell *couponOpenTimeView;
/** 优惠卷结束时间 */
@property (strong, nonatomic) CustomCell *couponEndTimeView;
/** 优惠卷发放数量 */
@property (strong, nonatomic) CustomCell *couponTotalView;
/** 优惠卷有效天数 */
@property (strong, nonatomic) CustomCell *couponExpiryDateView;
/** 优惠卷适用服务 */
@property (strong, nonatomic) CustomCell *couponApplyView;
/** 优惠卷适用服务Label */
@property (strong, nonatomic) UILabel *couponApplyLabel;
/** 优惠卷描述内容 */
@property (strong, nonatomic) GJTextView *descContentTV;

@end
