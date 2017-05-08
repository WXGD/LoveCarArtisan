//
//  leftRigBtn.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "leftRigBtn.h"

@interface leftRigBtn ()

/** 填充view */
@property (strong, nonatomic) UIView *fillView;

@end

@implementation leftRigBtn

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
    /** 左边文字 */
    self.leftText = [[UILabel alloc] init];
    self.leftText.font = FifteenTypeface;
    self.leftText.textColor = WhiteColor;
    [self.fillView addSubview:self.leftText];
    /** 右边按钮 */
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitle:@"搜" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:Black forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = FifteenTypeface;
    [self.rightBtn setImage:[UIImage imageNamed:@"user_sele_arrow"] forState:UIControlStateNormal];
    self.rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
    self.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 65, 0, 8);
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.cornerRadius = 5;
    self.rightBtn.backgroundColor = WhiteColor;
    [self addSubview:self.rightBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 左边文字 */
    [self.leftText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.left.equalTo(self.fillView.mas_left);
        make.centerY.equalTo(self.fillView.mas_centerY);
    }];
    /** 右边按钮 */
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.leftText.mas_right);
        make.centerY.equalTo(self.fillView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.leftText.mas_bottom);
        make.right.equalTo(self.rightBtn.mas_right);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
