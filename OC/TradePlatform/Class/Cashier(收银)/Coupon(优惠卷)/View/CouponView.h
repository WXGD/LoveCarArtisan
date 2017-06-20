//
//  CouponView.h
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CouponTabChoiceDelegate <NSObject>

@optional
- (void)couponTabChoiceAction:(UIButton *)button;

@end

@interface CouponView : UIView

/** 可用优惠券 */
@property (strong, nonatomic) UIButton *usableCouponBtn;
/** 不可用优惠券 */
@property (strong, nonatomic) UIButton *noUsableCouponBtn;
/** 可用优惠券Table */
@property (strong, nonatomic) UITableView *usableCouponTable;
/** 不可用优惠券Table */
@property (strong, nonatomic) UITableView *noUsableCouponTable;
/** 可用优惠券Table */
@property (strong, nonatomic) NSMutableArray *usableCouponArray;
/** 不可用优惠券Table */
@property (strong, nonatomic) NSMutableArray *noUsableCouponArray;
/** 优惠券选项卡选择代理 */
@property (assign, nonatomic) id<CouponTabChoiceDelegate>delegate;
/** 确认选择按钮 */
@property (strong, nonatomic) UIButton *confirmChoiceBtn;

@end
