//
//  BusinessHeaderView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BusinessHeaderView.h"

@implementation BusinessHeaderView

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
    self.leftOneLab = [[UILabel alloc] init];
    self.leftOneLab.textAlignment = NSTextAlignmentLeft;
    self.leftOneLab.font = TwelveTypeface;
    self.leftOneLab.textColor = GrayH1;
    [self addSubview:self.leftOneLab];
    
    self.leftTwoLab = [[UILabel alloc] init];
    self.leftTwoLab.textAlignment = NSTextAlignmentCenter;
    self.leftTwoLab.font = TwelveTypeface;
    self.leftTwoLab.textColor = GrayH1;
    [self addSubview:self.leftTwoLab];
    
    self.leftThreeLab = [[UILabel alloc] init];
    self.leftThreeLab.textAlignment = NSTextAlignmentCenter;
    self.leftThreeLab.font = TwelveTypeface;
    self.leftThreeLab.textColor = GrayH1;
    [self addSubview:self.leftThreeLab];
    
    self.leftFourLab = [[UILabel alloc] init];
    self.leftFourLab.textAlignment = NSTextAlignmentRight;
    self.leftFourLab.font = TwelveTypeface;
    self.leftFourLab.textColor = GrayH1;
    [self addSubview:self.leftFourLab];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.leftOneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.leftTwoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.leftOneLab.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.leftOneLab.mas_width);
    }];
    [self.leftThreeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.leftTwoLab.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.leftTwoLab.mas_width);
    }];
    [self.leftFourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.leftThreeLab.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.leftThreeLab.mas_width);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
}

@end
