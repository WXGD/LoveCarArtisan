//
//  CardTypeChoiceViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
@class CardTypeModel;

@interface CardTypeChoiceViewController : RootViewController

/** 会员卡信息模型 */
@property (nonatomic, strong) CardTypeModel *cardInfoModel;
/** 会员卡选择回掉 */
@property (nonatomic, copy) void(^CardTypeChoiceBlock)(CardTypeModel *choiceCardModel);

@end
