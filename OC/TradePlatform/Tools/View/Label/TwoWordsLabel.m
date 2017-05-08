//
//  TwoWordsLabel.m
//  TradePlatform
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TwoWordsLabel.h"

@interface TwoWordsLabel ()

/** 填充view */
@property (strong, nonatomic) UIView *fillView;

@end

@implementation TwoWordsLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self twoWordsLayoutView];
    }
    return self;
}

- (void)twoWordsLayoutView {
    /** 填充view */
    self.fillView = [[UIView alloc] init];
    [self addSubview:self.fillView];
    /** 主图片 */
    self.mainImage = [[UIImageView alloc] init];
    [self.fillView addSubview:self.mainImage];
    /** 主文字 */
    self.mainLabel = [[UILabel alloc] init];
    self.mainLabel.font = FourteenTypeface;
    self.mainLabel.textColor = GrayH2;
    self.mainLabel.text = @" ";
    [self.fillView addSubview:self.mainLabel];
    /** 副文字 */
    self.viceLabel = [[UILabel alloc] init];
    self.viceLabel.font = FifteenTypeface;
    self.viceLabel.textColor = Black;
    self.viceLabel.text = @" ";
    self.viceLabel.numberOfLines = 0;
    [self.fillView addSubview:self.viceLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.twoWordsShowStyle) {
            /** 两个文字横向布局，并相对父视图居中 */
        case TextVerticallyLayoutAndSuperCenter: {
            [self textVerticallyLayoutAndSuperCenter];
            break;
        }
            /** 两个文字横向布局，并相对父视图居中 */
        case TextHorizontalLayoutAndSuperCenter: {
            [self textHorizontalLayoutAndSuperCenter];
            break;
        }
            /** 两个文字和主图片纵向布局，并相对父视图居中 */
        case TextAndImageVerticallyLayoutAndSuperCenter: {
            [self textAndImageVerticallyLayoutAndSuperCenter];
            break;
        }
            /** 主图片和两个文字纵向布局，两个文字横向布局，并相对父视图居中 */
        case ImageVerticallyAndHorizontalLayoutAndSuperCenter: {
            [self imageVerticallyAndHorizontalLayoutAndSuperCenter];
            break;
        }
        default:
            break;
    }
}


/** 两个文字横向布局，并相对父视图居中 */
- (void)textVerticallyLayoutAndSuperCenter {
    @weakify(self)
    /** 主文字 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.centerX.equalTo(self.fillView.mas_centerX);
    }];
    /** 副文字 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainLabel.mas_bottom).offset(7);
        make.centerX.equalTo(self.fillView.mas_centerX);
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.viceLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
/** 两个文字横向布局，并相对父视图居中 */
- (void)textHorizontalLayoutAndSuperCenter {
    @weakify(self)
    /** 主文字 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.fillView.mas_left);
        make.centerY.equalTo(self.fillView.mas_centerY);
    }];
    /** 副文字 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mainLabel.mas_right).offset(5);
        make.centerY.equalTo(self.fillView.mas_centerY);
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.bottom.equalTo(self.viceLabel.mas_bottom);
        make.right.equalTo(self.viceLabel.mas_right);
    }];
}
/** 两个文字和主图片纵向布局，并相对父视图居中 */
- (void)textAndImageVerticallyLayoutAndSuperCenter {
    @weakify(self)
    /** 主图片 */
    [self.mainImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.centerX.equalTo(self.fillView.mas_centerX);
    }];
    /** 主文字 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainImage.mas_bottom).offset(15);
        make.centerX.equalTo(self.fillView.mas_centerX);
    }];
    /** 副文字 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.fillView.mas_centerX);
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.viceLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
}


/** 主图片和两个文字纵向布局，两个文字横向布局，并相对父视图居中 */
- (void)imageVerticallyAndHorizontalLayoutAndSuperCenter {
    @weakify(self)
    /** 主图片 */
    [self.mainImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.fillView.mas_top);
        make.centerX.equalTo(self.fillView.mas_centerX);
    }];
    /** 主文字 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainImage.mas_bottom).offset(15);
        make.left.equalTo(self.fillView.mas_left);
    }];
    /** 副文字 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mainLabel.mas_right).offset(5);
        make.centerY.equalTo(self.mainLabel.mas_centerY);
    }];
    /** 填充view */
    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.bottom.equalTo(self.viceLabel.mas_bottom);
        make.right.equalTo(self.viceLabel.mas_right);
    }];
}


@end
