//
//  UserCardListCellView.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCardListCellView : UIView

/** 卡背景图片 */
@property (strong, nonatomic) UIImageView *cardBackImage;
/** 卡类型 */
@property (strong, nonatomic) UILabel *cardType;
@property (strong, nonatomic) UIImageView *cardTypeImage;
/** 卡号 */
@property (strong, nonatomic) UILabel *cardNumberLabel;
/** 可用服务标题 */
@property (strong, nonatomic) UILabel *availableServiceTitle;
/** 可用服务内容 */
@property (strong, nonatomic) UILabel *availableServiceContent;
/** 可用服务尖头 */
@property (strong, nonatomic) UIImageView *availableServiceArraw;
/** 余额标题 */
@property (strong, nonatomic) UILabel *balanceTitle;
/** 余额 */
@property (strong, nonatomic) UILabel *balance;
/** 有效期 */
@property (strong, nonatomic) UILabel *expiryDate;
/** 有效期标题 */
@property (strong, nonatomic) UILabel *expiryDateTitle;
/** 编辑 */
@property (strong, nonatomic) UIButton *editBtn;
/** 充值 */
@property (strong, nonatomic) UIButton *rechargeBtn;

@end
