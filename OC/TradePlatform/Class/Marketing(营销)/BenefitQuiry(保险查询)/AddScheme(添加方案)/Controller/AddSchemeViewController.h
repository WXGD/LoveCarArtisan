//
//  AddSchemeViewController.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// model
#import "UserCarModel.h"

@interface AddSchemeViewController : RootViewController

/** 车辆信息模型 */
@property (strong, nonatomic) UserCarModel *carModel;

@end
