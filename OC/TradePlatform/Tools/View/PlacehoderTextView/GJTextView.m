//
//  GJTextView.m
//  TextVC
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJTextView.h"

@implementation GJTextView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addObserver];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self addObserver];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.text = placeholder;
    self.textColor = self.placeholderColor;
}

-(void)addObserver {
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminate:) name:UIApplicationWillTerminateNotification object:[UIApplication sharedApplication]];
    // textView属性
    self.font = [UIFont systemFontOfSize:12];
}

- (void)terminate:(NSNotification *)notification {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 输入框响应调用
- (void)didBeginEditing:(NSNotification *)notification {
    if ([self.text isEqualToString:self.placeholder]) {
        self.text = @"";
        self.textColor = self.tvColor;
    }
    if (self.GJDelegate && [self.GJDelegate respondsToSelector:@selector(GJTextViewBeginEdit:indexPath:)]) {
        [self.GJDelegate GJTextViewBeginEdit:self indexPath:self.indexPath];
    }
}
// 结束编辑调用
- (void)didEndEditing:(NSNotification *)notification {
    if (self.text.length<1) {
        self.text = self.placeholder;
        self.textColor = self.placeholderColor;
    }
    if (self.GJDelegate && [self.GJDelegate respondsToSelector:@selector(GJTextViewEndEdit:indexPath:)]) {
        [self.GJDelegate GJTextViewEndEdit:self indexPath:self.indexPath];
    }
}
// 输入过程调用
- (void)textChange:(NSNotification *)notification {
    if (self.GJDelegate && [self.GJDelegate respondsToSelector:@selector(GJTextViewChange:indexPath:)]) {
        [self.GJDelegate GJTextViewChange:self indexPath:self.indexPath];
    }
}



@end
