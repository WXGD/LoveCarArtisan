//
//  UsedCarKindsViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// 车品牌，车系模型
#import "UsedCarKindsModel.h"

@interface UsedCarKindsViewController : RootViewController

/** 车系模型 */
@property (strong, nonatomic) UsedCarBrandModel *usedCarSerierModel;
/** 车品牌模型 */
@property (strong, nonatomic) UsedCarBrandModel *usedCarBrandModel;
/** 选择车型回调 */
@property (copy, nonatomic) void(^UsedCarKindsChoiceBlock)(UsedCarBrandModel *usedCarBrandModel, UsedCarBrandModel *usedCarSerierModel, UsedCarBrandModel *usedCarKindsModel);

@end
