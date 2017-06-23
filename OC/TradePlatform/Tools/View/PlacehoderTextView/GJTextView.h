//
//  GJTextView.h
//  TextVC
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GJTextViewDelegate <NSObject>

@optional
// 输入框响应调用
- (void)GJTextViewBeginEdit:(UITextView *)textView indexPath:(NSIndexPath *)indexPath;
// 输入过程调用
- (void)GJTextViewChange:(UITextView *)textView indexPath:(NSIndexPath *)indexPath;
// 结束编辑调用
- (void)GJTextViewEndEdit:(UITextView *)textView indexPath:(NSIndexPath *)indexPath;

@end

@interface GJTextView : UITextView

/** 提示文字 */
@property (strong, nonatomic) NSString *placeholder;
/** 提示文字颜色 */
@property (strong, nonatomic) UIColor *placeholderColor;
/** 提示文字颜色 */
@property (strong, nonatomic) UIColor *tvColor;

/** 代理 */
@property (nonatomic, assign) id<GJTextViewDelegate>GJDelegate;
/** 选中cell */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
