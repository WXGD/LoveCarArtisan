//
//  FilterConditionBtn.m
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FilterConditionBtn.h"

@interface FilterConditionBtn ()



@end

@implementation FilterConditionBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self filterConditionBtnLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)filterConditionBtnLayoutView {
    /** 标题文字 */
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = Black;
    self.titleLabel.font = FourteenTypeface;
    [self addSubview:self.titleLabel];
    /** 标记图片 */
    self.signImage = [[UIImageView alloc] init];
    self.signImage.image = [UIImage imageNamed:@"order_down_arrow"];
    [self addSubview:self.signImage];
    /** 按钮 */
    self.filterConditionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.filterConditionBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 标题文字 */
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** 标记图片 */
    [self.signImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
    }];
    /** 按钮 */
    [self.filterConditionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
