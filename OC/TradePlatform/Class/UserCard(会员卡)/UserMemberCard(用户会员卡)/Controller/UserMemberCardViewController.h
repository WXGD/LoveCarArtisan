//
//  UserMemberCardViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "CardTypeModel.h"

@interface UserMemberCardViewController : RootViewController

/** 会员卡类型 */
@property (nonatomic, strong) CardTypeModel *cardTypeModel;
/** 会员卡类型数据 */
@property (nonatomic, strong) NSMutableArray *cardTypeArray;

@end
