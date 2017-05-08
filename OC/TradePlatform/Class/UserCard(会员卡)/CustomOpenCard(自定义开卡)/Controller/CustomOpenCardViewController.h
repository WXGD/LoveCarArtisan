//
//  CustomOpenCardViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
@class UserModel;

@interface CustomOpenCardViewController : RootViewController

/** 用户详情页跳转过来 */
@property (strong, nonatomic) UserModel *userModel;

@end
