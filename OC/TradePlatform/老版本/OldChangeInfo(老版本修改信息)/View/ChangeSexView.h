//
//  ChangeSexView.h
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

// 性别选择展示方式
typedef NS_ENUM(NSInteger, ChangeSexShowStyle) {
    /** 控件横向布局 */
    ViewHorizontalLayout,
    /** 控件纵向向布局 */
    ViewVerticallyLayout,
};


#import <UIKit/UIKit.h>

@interface ChangeSexView : UIView

/** view样式展示方式 */
@property (assign, nonatomic) ChangeSexShowStyle changeSexShowStyle;
/** 默认选中性别 */
@property (copy, nonatomic) NSString *defaultSex;
/** 选中性别代号 */
@property (copy, nonatomic) NSString *selectedSex;


@end
