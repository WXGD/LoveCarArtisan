//
//  CityListViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "CityModel.h"

@interface CityListViewController : RootViewController

/** 选择城市回调 */
@property (copy, nonatomic) void(^cityChoiceBlock)(CityModel *cityModel);

@end
