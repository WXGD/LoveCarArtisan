//
//  UserMemberCardCellView.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leftRigText.h"

@interface UserMemberCardCellView : UIView

/** 卡号 */
@property (nonatomic, strong) UILabel *cardNumLabel;
/** 卡名称 */
@property (nonatomic, strong) UILabel *cardNameLabel;
/** 余次/余额 */
@property (nonatomic, strong) leftRigText *noreThan;
/** 客户手机 */
@property (nonatomic, strong) leftRigText *userPhone;
/** 有效期 */
@property (nonatomic, strong) leftRigText *expiryDate;
/** 编辑 */
@property (strong, nonatomic) UIButton *editBtn;
/** 充值 */
@property (strong, nonatomic) UIButton *rechargeBtn;


@end
