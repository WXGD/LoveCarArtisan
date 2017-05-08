//
//  TopBotText.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TopBotText.h"

@interface TopBotText ()


@end

@implementation TopBotText

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self topBotTextLayoutView];
    }
    return self;
}

- (void)topBotTextLayoutView {
    /** 上面文字 */
    self.topText = [[UILabel alloc] init];
    self.topText.font = FifteenTypeface;
    self.topText.textColor = Black;
    [self addSubview:self.topText];
    /** 下面文字 */
    self.bomText = [[UILabel alloc] init];
    self.bomText.font = TwelveTypeface;
    self.bomText.textColor = Black;
    [self addSubview:self.bomText];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 上面文字 */
    [self.topText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** 下面文字 */
    [self.bomText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.topText.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.bomText.mas_bottom);
    }];
}

@end
