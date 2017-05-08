//
//  FiterConditionCell.m
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FiterConditionCell.h"

@implementation FiterConditionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self fiterConditionCellLayoutView];
    }
    return self;
}


- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.layer.borderColor = ThemeColor.CGColor;
        self.layer.borderWidth = 1;
        /** 标题 */
        self.titleLabel.textColor = ThemeColor;
    }else {
        self.layer.borderColor = WhiteColor.CGColor;
        /** 标题 */
        self.titleLabel.textColor = Black;
    }
}

- (void)fiterConditionCellLayoutView {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
    self.backgroundColor = WhiteColor;
    self.layer.borderWidth = 1;
    self.layer.borderColor = WhiteColor.CGColor;
    /** 标题 */
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = Black;
    self.titleLabel.font = ThirteenTypeface;
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 标题 */
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}


@end
