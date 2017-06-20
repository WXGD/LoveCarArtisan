//
//  SeeDrivingLicenseView.h
//  TradePlatform
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeeDrivingLicenseView : UIView

/** 展示图片 */
@property (nonatomic, strong) UIImageView *drivingLicenseImage;


/** 显示 */
- (void)show;
/** 销毁 */
- (void)dismiss;


@end
