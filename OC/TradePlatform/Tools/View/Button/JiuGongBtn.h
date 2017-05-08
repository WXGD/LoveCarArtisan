//
//  JiuGongBtn.h
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBotBtn.h"

@protocol JiuGongBtnActionDelegate <NSObject>

@optional
- (void)jiuGongBtnAction:(UIButton *)button tag:(NSInteger)tag;

@end

@interface JiuGongBtn : UIView

@property (strong, nonatomic) TopBotBtn *btn1;
@property (strong, nonatomic) TopBotBtn *btn2;
@property (strong, nonatomic) TopBotBtn *btn3;
@property (strong, nonatomic) TopBotBtn *btn4;
@property (strong, nonatomic) TopBotBtn *btn5;
@property (strong, nonatomic) TopBotBtn *btn6;
@property (strong, nonatomic) TopBotBtn *btn7;
@property (strong, nonatomic) TopBotBtn *btn8;
@property (strong, nonatomic) TopBotBtn *btn9;
@property (strong, nonatomic) NSMutableArray *btnImageArray;
@property (strong, nonatomic) NSMutableArray *btnTextArray;

@property (assign, nonatomic) id<JiuGongBtnActionDelegate>delegate;

@end
