//
//  LeftRigFaxView.m
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LeftRigFaxView.h"


@interface LeftRigFaxView ()

/** 填充view */
@property (strong, nonatomic) UIView *fillView;

@end

@implementation LeftRigFaxView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self topBotTextLayoutView];
    }
    return self;
}

- (void)topBotTextLayoutView {
    /** 填充view */
    self.fillView = [[UIView alloc] init];
    [self addSubview:self.fillView];
    /** 左边图片 */
    self.leftImage = [[UIImageView alloc] init];
    [self.fillView addSubview:self.leftImage];
    /** 右边文字 */
    self.rightText = [[UILabel alloc] init];
    self.rightText.font = FourteenTypeface;
    self.rightText.textColor = Black;
    [self.fillView addSubview:self.rightText];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 左边图片 */
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.left.equalTo(self.fillView.mas_left);
        make.centerY.equalTo(self.fillView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    /** 右边文字 */
    [self.rightText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.leftImage.mas_right).offset(10);
        make.centerY.equalTo(self.fillView.mas_centerY);
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.leftImage.mas_bottom);
        make.right.equalTo(self.rightText.mas_right);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
