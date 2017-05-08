//
//  UsedCarBrandViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UsedCarBrandHandle.h"

@interface UsedCarBrandViewController : RootViewController

/** 选择二手车品牌回调 */
@property (copy, nonatomic) void(^usedCarBrandChoiceBlock)(UsedCarBrandModel *usedCarBrandModel, UsedCarBrandModel *usedCarSerierModel, UsedCarBrandModel *usedCarKindsModel);

@end
