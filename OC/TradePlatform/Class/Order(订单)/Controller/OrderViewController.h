//
//  OrderViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UserModel.h"

@interface OrderViewController : RootViewController

/** 用户信息模型 */
@property (strong, nonatomic) UserModel *userInfoMode;
/** nav标题 */
@property (strong, nonatomic) NSString *orderNavTitle;

@end
