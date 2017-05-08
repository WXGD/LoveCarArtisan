//
//  PaySuccessViewController.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UserModel.h"

@interface PaySuccessViewController : RootViewController

/** 用户信息(修改用户信息时需要) */
@property (strong, nonatomic) UserModel *userInfo;

@end
