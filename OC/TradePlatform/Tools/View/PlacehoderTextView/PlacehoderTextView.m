//
//  PlacehoderTextView.m
//  WeiBo
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 cc. All rights reserved.
//

#import "PlacehoderTextView.h"

@interface PlacehoderTextView ()

/** 字数限制 */
@property (strong, nonatomic) UILabel *wordLimitLabel;

@end

@implementation PlacehoderTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // 通知
        // 当UITextView的文字发生改变的时候，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        if (self.wordLimit.length !=0) {
            self.wordLimitLabel = [[UILabel alloc] init];
            _wordLimitLabel.text = self.wordLimit;
            _wordLimitLabel.textAlignment = NSTextAlignmentLeft;
            _wordLimitLabel.font = [UIFont systemFontOfSize:12];
            [self.superview addSubview:_wordLimitLabel];
           // NSLog(@"%@", self.superview);
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // 通知
        // 当UITextView的文字发生改变的时候，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        if (self.wordLimit.length !=0) {
            self.wordLimitLabel = [[UILabel alloc] init];
            _wordLimitLabel.text = self.wordLimit;
            _wordLimitLabel.textAlignment = NSTextAlignmentLeft;
            _wordLimitLabel.font = [UIFont systemFontOfSize:12];
            [self addSubview:_wordLimitLabel];
        }
    }
    return self;
}

- (void)textDidChange {
    
    // 判断字数限制
    if (self.text.length > [_wordLimit integerValue]) {
        self.text = [self.text substringToIndex:[_wordLimit integerValue]];
    }else {
//        NSInteger wordlimitlength = [_wordLimit integerValue] - self.text.length;
        _wordLimitLabel.text = [NSString stringWithFormat:@"%lu%@%@", (unsigned long)self.text.length, @"/", _wordLimit];
    }
    // 重绘（drawAtPoint）
    [self setNeedsDisplay];
}

// 在控件上画出你想要的东西
- (void)drawRect:(CGRect)rect {

//    [self.placeholderColor set];
    if (self.hasText) return;
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    // 画文字
//    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text {
    
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font {
    
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)setWordLimit:(NSString *)wordLimit {
    
    _wordLimit = wordLimit;
    _wordLimitLabel.text = [NSString stringWithFormat:@"%@%@%@", @0, @"/", wordLimit];
}
// 注销通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _wordLimitLabel.width = 100;
    _wordLimitLabel.height = 12;
//    _wordLimitLabel.x = self.width - _wordLimitLabel.width - 10;
    _wordLimitLabel.x = 15;
    _wordLimitLabel.y = self.height - _wordLimitLabel.height - 5;
}
@end
