//
//  PlacehoderTextView.h
//  WeiBo
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 cc. All rights reserved.
//  带有占位文字

#import <UIKit/UIKit.h>

@interface PlacehoderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 字数限制 */
@property (nonatomic, copy) NSString *wordLimit;

@end
