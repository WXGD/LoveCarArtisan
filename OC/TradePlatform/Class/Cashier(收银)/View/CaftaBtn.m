//
//  CaftaBtn.m
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CaftaBtn.h"

@implementation CaftaBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self caftaBtnLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)caftaBtnLayoutView {
    /** 标题文字 */
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = ThemeColor;
    self.titleLabel.font = FourteenTypeface;
    [self addSubview:self.titleLabel];
    /** 标记图片 */
    self.signImage = [[UIImageView alloc] init];
    self.signImage.image = [UIImage imageNamed:@"order_down_arrow"];
    [self addSubview:self.signImage];
    /** 按钮 */
    self.caftaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.caftaBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 标题文字 */
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(@14.5);
    }];
    /** 标记图片 */
    [self.signImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.width.equalTo(self.signImage.mas_height);
    }];
    /** 按钮 */
    [self.caftaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.signImage.mas_right);
    }];
}

@end
