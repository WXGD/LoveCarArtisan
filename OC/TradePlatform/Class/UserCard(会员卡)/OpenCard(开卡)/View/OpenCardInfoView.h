//
//  OpenCardInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leftRigText.h"

@interface OpenCardInfoView : UIView

/** 卡号 */
@property (nonatomic, strong) UILabel *cardNumLabel;
/** 卡名称 */
@property (nonatomic, strong) UILabel *cardNameLabel;
/** 卡类型 */
@property (nonatomic, strong) UILabel *cardTypeLabel;
/** 可用服务 */
@property (nonatomic, strong) UILabel *availableServiceLabel;
/** 详情按钮 */
@property (nonatomic, strong) UIButton *detailsBtn;
/** 可用次数／可用金额 */
@property (nonatomic, strong) leftRigText *canNumMoneyLabel;
/** 原价 */
@property (nonatomic, strong) leftRigText *costPriceLabel;

@end
