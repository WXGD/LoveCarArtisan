//
//  CreditCardCellView.h
//  CarRepairFactory
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditCardCellView : UIView

/** 卡类型 */
@property (strong, nonatomic) UILabel *cardType;
@property (strong, nonatomic) UIImageView *cardTypeImage;
/** 卡号 */
@property (strong, nonatomic) UILabel *cardNumberLabel;
/** 余额标题 */
@property (strong, nonatomic) UILabel *balanceTitle;
/** 余额 */
@property (strong, nonatomic) UILabel *balance;
/** 有效期 */
@property (strong, nonatomic) UILabel *expiryDate;
/** 有效期标题 */
@property (strong, nonatomic) UILabel *expiryDateTitle;

@end
