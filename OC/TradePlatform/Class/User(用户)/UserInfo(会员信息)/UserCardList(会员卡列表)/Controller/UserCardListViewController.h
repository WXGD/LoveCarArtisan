//
//  UserCardListViewController.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UserModel.h"

@interface UserCardListViewController : RootViewController

/** 用户信息模型 */
@property (strong, nonatomic) UserModel *userModel;

@end
