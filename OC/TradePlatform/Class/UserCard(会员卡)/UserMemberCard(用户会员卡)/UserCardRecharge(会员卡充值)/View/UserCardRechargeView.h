//
//  UserCardRechargeView.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KeyBoardView.h"

@interface UserCardRechargeView : KeyBoardView

/** 卡号 */
@property (strong, nonatomic) UsedCellView *recCardNum;
/** 余次/余额 */
@property (strong, nonatomic) UsedCellView *recNoreThan;
/** 手机号 */
@property (strong, nonatomic) UsedCellView *recUserPhone;
/** 余次/余额充值 */
@property (strong, nonatomic) UsedCellView *recNoreThanRecharge;
/** 实收金额 */
@property (strong, nonatomic) UsedCellView *netReceiptsMoney;
/** 服务师傅 */
@property (strong, nonatomic) UsedCellView *serviceMasterView;
/** 确认充值 */
@property (strong, nonatomic) UIButton *confirmRechargeBtn;





@end
