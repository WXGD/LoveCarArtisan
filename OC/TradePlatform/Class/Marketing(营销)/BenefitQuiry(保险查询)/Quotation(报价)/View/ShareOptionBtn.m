//
//  ShareOptionBtn.m
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShareOptionBtn.h"

@implementation ShareOptionBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self shareOptionBtnLayout];
    }
    return self;
}

- (void)shareOptionBtnLayout {
    /** 上面图片 */
    self.topImage = [[UIImageView alloc] init];
    [self addSubview:self.topImage];
    /** 下面文字 */
    self.bomText = [[UILabel alloc] init];
    self.bomText.font = FourteenTypeface;
    self.bomText.textColor = Black;
    [self addSubview:self.bomText];
    /** 点击按钮 */
    self.topBotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.topBotBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 上面图片 */
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(18);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(53, 53));
    }];
    /** 下面文字 */
    [self.bomText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.topImage.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.bomText.mas_bottom).offset(18);
    }];
    /** 点击按钮 */
    [self.topBotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
}
@end
