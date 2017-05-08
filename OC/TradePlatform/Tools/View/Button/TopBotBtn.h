//
//  TopBotBtn.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBotBtn : UIView

/** 距离边框上下高度 */
@property (assign, nonatomic) NSInteger  distanceFrame;
/** 图片文字间距 */
@property (assign, nonatomic) NSInteger  faxSpacing;
/** 上面图片 */
@property (strong, nonatomic) UIImageView *topImage;
/** 下面文字 */
@property (strong, nonatomic) UILabel *bomText;
/** 点击按钮 */
@property (strong, nonatomic) UIButton *topBotBtn;

@end
