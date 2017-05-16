//
//  HomeNavView.h
//  TradePlatform
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchView.h"

@interface HomeNavView : UIView

/** 搜索框view */
@property (strong, nonatomic) SearchView *search;
/** 快捷方式 */
@property (strong, nonatomic) UIButton *shortcutBtn;

@end
