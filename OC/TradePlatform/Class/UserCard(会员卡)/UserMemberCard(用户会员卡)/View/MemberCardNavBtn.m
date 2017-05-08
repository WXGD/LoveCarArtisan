//
//  MemberCardNavBtn.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MemberCardNavBtn.h"

@interface MemberCardNavBtn ()


@end

@implementation MemberCardNavBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self memberCardNavBtnLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)memberCardNavBtnLayoutView {
    
    self.cardNameLabel = [[UILabel alloc] init];
    self.cardNameLabel.textColor = WhiteColor;
    self.cardNameLabel.font = FifteenTypeface;
    [self addSubview:self.cardNameLabel];
    
    self.arrowImage = [[UIImageView alloc] init];
    self.arrowImage.image = [UIImage imageNamed:@"user_card_nav_triangle"];
    [self addSubview:self.arrowImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cardNameLabel.mas_right).offset(8);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.arrowImage.mas_right);
        make.bottom.equalTo(self.cardNameLabel.mas_bottom);
    }];
}

@end
