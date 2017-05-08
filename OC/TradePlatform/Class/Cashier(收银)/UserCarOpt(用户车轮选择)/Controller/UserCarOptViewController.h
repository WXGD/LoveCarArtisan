//
//  UserCarOptViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UserModel.h"

@interface UserCarOptViewController : RootViewController

@property (strong, nonatomic) UserModel *userModel;
/** 选择车辆回调 */
@property (copy, nonatomic) void(^ChoiceCarBlock)(UserCarModel *userCarModel);

@end
