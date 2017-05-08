//
//  inputAccessoryView.h
//  InputAccessoryView-WindowLayer
//
//  Created by shake on 14/11/14.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UUInputAccessoryBlock)(NSString *contentStr);

@interface UUInputAccessoryView : NSObject


+ (void)showBlock:(UUInputAccessoryBlock)block;


+ (void)showKeyboardType:(UIKeyboardType)type
                   Block:(UUInputAccessoryBlock)block;


+ (void)showKeyboardType:(UIKeyboardType)type
                 content:(NSString *)content
                   Block:(UUInputAccessoryBlock)block;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com