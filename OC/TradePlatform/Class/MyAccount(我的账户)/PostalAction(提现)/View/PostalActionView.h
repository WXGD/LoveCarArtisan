//
//  PostalActionView.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostalActionView : UIView
/** 提现记录背景view */
@property (strong, nonatomic) UsedCellView *postalBackView;
/** 提现金额标题 */
@property (strong, nonatomic) UILabel *postalMoneyTitle;
/** 提现金额Label */
@property (strong, nonatomic) UILabel *postalMoneyLabel;
///** 提现金额btn */
//@property (strong, nonatomic) UIButton *postalMoneyBtn;
@end
