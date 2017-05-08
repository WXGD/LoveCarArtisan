//
//  TopBotBtn.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TopBotBtn.h"

@interface TopBotBtn ()


@end

@implementation TopBotBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认边框距离
        self.distanceFrame = 20;
        // 默认图文间距
        self.faxSpacing = 10;
        [self topBotBtnLayout];
    }
    return self;
}

- (void)topBotBtnLayout {
    /** 上面图片 */
    self.topImage = [[UIImageView alloc] init];
    [self addSubview:self.topImage];
    /** 下面文字 */
    self.bomText = [[UILabel alloc] init];
    self.bomText.font = FifteenTypeface;
    self.bomText.textColor = Black;
    [self addSubview:self.bomText];
    /** 点击按钮 */
    self.topBotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.topBotBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 下面文字 */
    [self.bomText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_bottom).offset(-self.distanceFrame);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(@18);
    }];
    /** 上面图片 */
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(self.distanceFrame);
        make.bottom.equalTo(self.bomText.mas_top).offset(-self.faxSpacing);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.topImage.mas_height);
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
