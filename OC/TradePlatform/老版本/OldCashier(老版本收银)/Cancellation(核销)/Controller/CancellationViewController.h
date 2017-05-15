//
//  CancellationViewController.h
//  TradePlatform
//
//  Created by 弓杰 on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UserModel.h"

@interface CancellationViewController : RootViewController

/** 核销Table数据 */
@property (strong, nonatomic) NSMutableArray *cancellationArray;
/** 用户信息(修改用户信息时需要) */
@property (strong, nonatomic) UserModel *userInfo;

@end
