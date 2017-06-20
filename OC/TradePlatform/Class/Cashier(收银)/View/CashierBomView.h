//
//  CashierBomView.h
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashierBomView : UIView

/** 确认收款 */
@property (strong, nonatomic) UIButton *confirCashierBtn;
/** 暂不收银 */
@property (strong, nonatomic) UIButton *temporCashierBtn;
/** 优惠券金额 */
@property (strong, nonatomic) UILabel *couponSumLabel;
/** 实收款 */
@property (strong, nonatomic) UILabel *proceedsLabel;
/** 服务金额 */
@property (strong, nonatomic) UILabel *serviceSumLabel;

@end
