//
//  EditCarInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// 模型
#import "UserModel.h"
#import "UserCarModel.h"

@interface EditCarInfoViewController : RootViewController

/** 用户信息(修改用户信息时需要) */
@property (strong, nonatomic) UserModel *userInfo;
/** 用户车辆信息 */
@property (strong, nonatomic) UserCarModel *userCar;

@end
