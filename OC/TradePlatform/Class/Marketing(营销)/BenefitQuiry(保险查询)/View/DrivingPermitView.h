//
//  DrivingPermitView.h
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrivingPermitView : UIView

/** 展示图片 */
@property (nonatomic, strong) UIImageView *drivingPermitImage;


/** 显示 */
- (void)show;
/** 销毁 */
- (void)dismiss;

@end
