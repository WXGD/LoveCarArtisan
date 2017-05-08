//
//  ShortcutView.h
//  TradePlatform
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

// 快捷方式页面按钮点击类型
typedef NS_ENUM(NSInteger, HomePageBottonAction) {
    /** 新增服务 */
    SpeedAddScrviewBtnAction,
    /** 新增客户 */
    SpeedAddUserBtnAction,
    /** 开卡 */
    SpeedOpenCardBtnAction,
};


#import <UIKit/UIKit.h>

@interface ShortcutView : UIView

/** 新增服务 */
@property (strong, nonatomic) UsedCellView *speedAddScrview;
/** 新增客户 */
@property (strong, nonatomic) UsedCellView *speedAddUser;
/** 开卡 */
@property (strong, nonatomic) UsedCellView *speedOpenCard;

@end
