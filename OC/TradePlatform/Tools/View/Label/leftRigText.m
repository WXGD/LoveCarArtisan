//
//  leftRigText.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "leftRigText.h"

@interface leftRigText ()

/** 填充view */
@property (strong, nonatomic) UIView *fillView;

@end

@implementation leftRigText


- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认两个label横向布局，并且相对父视图剧中
        self.leftRigTextTypeChoice = VerticallyLayoutAndCenter;
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
    self.leftText.font = FourteenTypeface;
    self.leftText.textColor = GrayH2;
    self.leftText.text = @" ";
    [self.fillView addSubview:self.leftText];
    /** 右边文字 */
    self.rightText = [[UILabel alloc] init];
    self.rightText.font = FifteenTypeface;
    self.rightText.textColor = Black;
    self.rightText.text = @" ";
    self.rightText.numberOfLines = 0;
    [self.fillView addSubview:self.rightText];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.leftRigTextTypeChoice) {
        /** 两个label横向布局，并且相对父视图剧左 */
        case VerticallyLayoutAndLeftAlign: {
            [self verticallyLayoutAndLeftAlign];
            break;
        }
        /** 两个label横向布局，并且相对父视图剧中 */
        case VerticallyLayoutAndCenter: {
            [self verticallyLayoutAndCenter];
            break;
        }
        /** 两个label横向布局，并且相对父视图剧左，右边label可换行 */
        case VerticallyLayoutAndLeftAlignAndRightWrap: {
            [self verticallyLayoutAndLeftAlignAndRightWrap];
            break;
        }
        default:
            break;
    }
}

/** 两个label横向布局，并且相对父视图剧左 */
- (void)verticallyLayoutAndLeftAlign {
    @weakify(self)
    /** 左边文字 */
    [self.leftText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.left.equalTo(self.fillView.mas_left);
        make.centerY.equalTo(self.fillView.mas_centerY);
    }];
    /** 右边文字 */
    [self.rightText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.leftText.mas_right);
        make.centerY.equalTo(self.fillView.mas_centerY);
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.rightText.mas_bottom);
        make.right.equalTo(self.rightText.mas_right);
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
/** 两个label横向布局，并且相对父视图剧中 */
- (void)verticallyLayoutAndCenter {
    @weakify(self)
    /** 左边文字 */
    [self.leftText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.left.equalTo(self.fillView.mas_left);
        make.centerY.equalTo(self.fillView.mas_centerY);
    }];
    /** 右边文字 */
    [self.rightText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.leftText.mas_right);
        make.centerY.equalTo(self.fillView.mas_centerY);
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.rightText.mas_bottom);
        make.right.equalTo(self.rightText.mas_right);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

/** 两个label横向布局，并且相对父视图剧左，右边label可换行 */
- (void)verticallyLayoutAndLeftAlignAndRightWrap {
    @weakify(self)
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 左边文字 */
    [self.leftText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.left.equalTo(self.fillView.mas_left);
    }];
    /** 右边文字 */
    [self.rightText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.left.equalTo(self.leftText.mas_right);
        make.right.equalTo(self.fillView.mas_right);
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.rightText.mas_bottom);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.fillView.mas_bottom);
    }];
}


@end
