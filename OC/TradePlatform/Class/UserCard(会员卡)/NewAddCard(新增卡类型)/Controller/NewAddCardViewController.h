//
//  NewAddCardViewController.h
//  TradePlatform
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"

@interface NewAddCardViewController : RootViewController

// 新增卡成功回掉
@property (copy, nonatomic) void(^addCardSuccess)();

@end
