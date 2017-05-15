//
//  MyAccountHeaderView.h
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountHeaderView : UIView

/** 余额数量 */
@property (strong, nonatomic) UILabel *balanceLabel;
/** 提现按钮 */
@property (strong, nonatomic) UIButton *postalBtn;
/** 历史提现金额 */
@property (strong, nonatomic) UILabel *historyPostalLabel;
/** 本次最多提现金额 */
@property (strong, nonatomic) UILabel *mostPostalLabel;

@end


