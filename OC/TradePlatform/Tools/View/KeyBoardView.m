//
//  KeyBoardView.m
//  TradePlatform
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KeyBoardView.h"
#import "ZYKeyboardUtil.h"

@interface KeyBoardView ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation KeyBoardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 操作键盘弹出
        self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
        @weakify(self)
        [self.keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
            @strongify(self)
            [keyboardUtil adaptiveViewHandleWithAdaptiveView:self, nil];
        }];
    }
    return self;
}



@end
