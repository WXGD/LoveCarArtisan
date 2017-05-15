//
//  CashierPremiumView.h
//  TradePlatform
//
//  Created by 弓杰 on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CashierPremiumDelegate <NSObject>

@optional
- (void)employBtnDelegate:(UIButton *)button;

@end

@interface CashierPremiumView : UIView

/** 显示内容的容器 */
@property (nonatomic, strong) UIImageView *containerImage;
/** 使用 */
@property (nonatomic, strong) UIButton *employBtn;
/** 代理 */
@property (nonatomic, assign) id<CashierPremiumDelegate>delegate;

@end
