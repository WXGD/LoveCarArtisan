//
//  AdminChoseHeaderView.m
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AdminChoseHeaderView.h"

@implementation AdminChoseHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self adminChoseHeaderLayoutView];
    }
    return self;
}

#pragma mark - view布局
- (void)adminChoseHeaderLayoutView {
    /** 标题 */
    self.titleLabel = [[UILabel alloc] init];
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
        make.top.equalTo(self.mas_top).offset(self.titleTop);
        make.left.equalTo(self.mas_left).offset(7);
    }];
}

@end

