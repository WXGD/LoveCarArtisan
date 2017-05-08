//
//  ReviseRangeFootView.m
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ReviseRangeFootView.h"

@interface ReviseRangeFootView ()

/** 背景view */
@property (strong, nonatomic) UIView *backView;
/** 新增标题标记 */
@property (strong, nonatomic) UIView *addRangeSign;

@end

@implementation ReviseRangeFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self reviseRangeFootLayoutView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self reviseRangeFootLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)reviseRangeFootLayoutView {
    /** 背景view */
    self.backView = [[UIView alloc] init];
    [self addSubview:self.backView];
    /** 新增标题 */
    self.addRangeLabel = [[UILabel alloc] init];
    self.addRangeLabel.font = FifteenTypeface;
    self.addRangeLabel.textColor = ThemeColor;
    [self.backView addSubview:self.addRangeLabel];
    /** 新增标题标记 */
    self.addRangeSign = [[UIView alloc] init];
    self.addRangeSign.backgroundColor = ThemeColor;
    [self.backView addSubview:self.addRangeSign];
    /** 新增view */
    self.addRangeView = [[RangeView alloc] init];
    [self.backView addSubview:self.addRangeView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    self.backView.frame = CGRectMake(0, 0, self.width, self.height);
    /** 新增标题 */
    [self.addRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView.mas_top).offset(6);
        make.left.equalTo(self.backView.mas_left).offset(16);
    }];
    /** 新增标题标记 */
    [self.addRangeSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addRangeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.addRangeLabel.mas_left);
        make.right.equalTo(self.addRangeLabel.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    /** 新增view */
    [self.addRangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addRangeSign.mas_bottom).offset(15);
        make.width.equalTo(self.backView.mas_width);
    }];
}

@end
