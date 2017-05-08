//
//  ModuleView.m
//  TradePlatform
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ModuleView.h"

@implementation ModuleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self moduleViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)moduleViewLayoutView {
    /** 图片 */
    self.moduleImage = [[UIImageView alloc] init];
    [self addSubview:self.moduleImage];
    /** 文字 */
    self.moduleLabel = [[UILabel alloc] init];
    self.moduleLabel.font = FourteenTypeface;
    self.moduleLabel.textColor = Black;
    [self addSubview:self.moduleLabel];
    /** 按钮 */
    self.moduleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.moduleBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 图片 */
    [self.moduleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(21);
    }];
    /** 文字 */
    [self.moduleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.moduleImage.mas_bottom).offset(12);
    }];
    /** 按钮 */
    [self.moduleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** self高度 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.moduleLabel.mas_bottom).offset(21);
    }];
}

@end
