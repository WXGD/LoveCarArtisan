//
//  CompulsoryHeaderView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CompulsoryHeaderView.h"

@implementation CompulsoryHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self headerViewLayoutView];
        self.backgroundColor = WhiteColor;
    }
    return self;
}
- (void)headerViewLayoutView{
    self.leftLab = [[UILabel alloc] init];
    self.leftLab.textAlignment = NSTextAlignmentLeft;
    self.leftLab.font = TwelveTypeface;
    self.leftLab.textColor = GrayH1;
    [self addSubview:self.leftLab];
    
    self.centerLab = [[UILabel alloc] init];
    self.centerLab.textAlignment = NSTextAlignmentCenter;
    self.centerLab.font = TwelveTypeface;
    self.centerLab.textColor = GrayH1;
    [self addSubview:self.centerLab];
    
    self.rightLab = [[UILabel alloc] init];
    self.rightLab.textAlignment = NSTextAlignmentRight;
    self.rightLab.font = TwelveTypeface;
    self.rightLab.textColor = GrayH1;
    [self addSubview:self.rightLab];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
@end
