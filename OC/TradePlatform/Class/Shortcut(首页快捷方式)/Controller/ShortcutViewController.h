//
//  ShortcutViewController.h
//  TradePlatform
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"

@interface ShortcutViewController : RootViewController

@property (strong, nonatomic) UINavigationController *shortcutNav;
@property (strong, nonatomic) void(^ShortcutBtnActionBlock)();
@property (strong, nonatomic) UIButton *shortcutBtn;

@end
