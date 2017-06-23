//
//  CouponInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CouponInfoView : UIView

/** 优惠金额标记 */
@property (strong, nonatomic) UILabel *couponSumSign;
/** 优惠金额 */
@property (strong, nonatomic) UILabel *couponSumLabel;
/** 使用条件 */
@property (strong, nonatomic) UILabel *useConditionLabel;
/** 优惠券名称 */
@property (strong, nonatomic) UILabel *couponNameLabel;
/** 优惠券使用周期 */
@property (strong, nonatomic) UILabel *couponTimeLabel;
/** 按钮 */
@property (strong, nonatomic) UIButton *button;
/** 按钮宽高 */
@property (assign, nonatomic) CGSize btnSize;

@end
