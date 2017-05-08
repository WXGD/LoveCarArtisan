//
//  GroupHeaderView.m
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GroupHeaderView.h"



@implementation GroupHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self groupHeaderLayoutView];
    }
    return self;
}

#pragma mark - view布局
- (void)groupHeaderLayoutView {
    /** 标题 */
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"订单日期";
    self.titleLabel.textColor = GrayH2;
    self.titleLabel.font = TwelveTypeface;
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 标题 */
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(28);
        make.left.equalTo(self.mas_left);
    }];
}

@end
