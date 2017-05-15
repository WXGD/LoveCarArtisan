//
//  SmallPrintView.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BenefitModel.h"

@protocol SmallPrintDelegate <NSObject>

@optional
// cell点击代理
- (void)smallPrintDidSelectIsCover:(NSInteger)isCover coverage:(double)coverage;
/** 取消 */
- (void)cancelBtnDelegate:(UIButton *)button;
/** 确定 */
- (void)confirmBtnDelegate:(UIButton *)button;

@end

@interface SmallPrintView : UIView

/** 保险模型 */
@property (strong, nonatomic) BenefitModel *benefitModel;
/** 代理 */
@property (assign, nonatomic) id<SmallPrintDelegate>delegate;


/** 显示 */
- (void)show;
/** 销毁 */
- (void)dismiss;

@end
