//
//  SearchUserViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// 模型
#import "UserDataSource.h"

@interface SearchUserViewController : RootViewController

/** 选择用户回调 */
@property (copy, nonatomic) void(^ChoiceUserBlock)(UserModel *userModel);

@end
