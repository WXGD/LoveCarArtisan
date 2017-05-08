//
//  OpenCardViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "CardTypeModel.h"

@interface OpenCardViewController : RootViewController

/** 会员卡类型 */
@property (nonatomic, strong) CardTypeModel *cardTypeModel;

@end
