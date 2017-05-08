//
//  ModuleView.h
//  TradePlatform
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleView : UIView

/** 图片 */
@property (strong, nonatomic) UIImageView *moduleImage;
/** 文字 */
@property (strong, nonatomic) UILabel *moduleLabel;
/** 按钮 */
@property (strong, nonatomic) UIButton *moduleBtn;

@end
