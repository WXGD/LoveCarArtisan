//
//  AddSubNumView.h
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddSubBtnDelegate <NSObject>

@optional
// 按钮点击代理
- (void)addSubBtnDelegate:(UIButton *)button;

@end

@interface AddSubNumView : UIView

/** 数量 */
@property (strong, nonatomic) UITextField *numTF;
/** 代理 */
@property (assign, nonatomic) id<AddSubBtnDelegate>delegate;
/** 加号 */
@property (strong, nonatomic) UIButton *addBtn;
/** 减号 */
@property (strong, nonatomic) UIButton *subBtn;

@end
