//
//  CardTypeCellView.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardTypeCellView.h"
@interface CardTypeCellView ()

/** 分割view */
@property (nonatomic, strong) UIView *dividingLineView;
/** 卡号 */
@property (nonatomic, strong) UIView *cardNumView;
/** 尖头 */
@property (nonatomic, strong) UIImageView *cardArrow;
/** 可用服务标题 */
@property (nonatomic, strong) UILabel *availableServiceTitleLabel;

@end

@implementation CardTypeCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self cardTypeCellLayoutView];
    }
    return self;
}


- (void)cardTypeCellLayoutView {
    /** 卡号 */
    self.cardNumView = [[UIView alloc] init];
    self.cardNumView.backgroundColor = ThemeColor;
    self.cardNumView.layer.masksToBounds = YES;
    self.cardNumView.layer.cornerRadius = 2;
    [self addSubview:self.cardNumView];
    /** 卡号 */
    self.cardNumLabel = [[UILabel alloc] init];
    self.cardNumLabel.font = ElevenTypeface;
    self.cardNumLabel.textColor = WhiteColor;
    [self.cardNumView addSubview:self.cardNumLabel];
    /** 卡名称 */
    self.cardNameLabel = [[UILabel alloc] init];
    self.cardNameLabel.font = SixteenTypefaceBold;
    self.cardNameLabel.textColor = Black;
    [self addSubview:self.cardNameLabel];
    /** 卡类型 */
    self.cardTypeLabel = [[UILabel alloc] init];
    self.cardTypeLabel.font = ThirteenTypeface;
    self.cardTypeLabel.textColor = BlueColor;
    [self addSubview:self.cardTypeLabel];
    /** 尖头 */
    self.cardArrow = [[UIImageView alloc] init];
    self.cardArrow.image = [UIImage imageNamed:@"right_arrow"];
    [self addSubview:self.cardArrow];
    /** 可用服务标题 */
    self.availableServiceTitleLabel = [[UILabel alloc] init];
    self.availableServiceTitleLabel.text = @"可用服务包含:";
    self.availableServiceTitleLabel.font = TwelveTypeface;
    self.availableServiceTitleLabel.textColor = GrayH2;
    [self addSubview:self.availableServiceTitleLabel];
    /** 可用服务 */
    self.availableServiceLabel = [[UILabel alloc] init];
    self.availableServiceLabel.font = TwelveTypeface;
    self.availableServiceLabel.textColor = GrayH2;
    [self addSubview:self.availableServiceLabel];
    /** 分割view */
    self.dividingLineView = [[UIView alloc] init];
    self.dividingLineView.backgroundColor = DividingLine;
    [self addSubview:self.dividingLineView];
    /** 用户会员卡 */
    self.userCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userCardBtn setTitle:@"用户会员卡" forState:UIControlStateNormal];
    self.userCardBtn.titleLabel.font = ThirteenTypeface;
    [self.userCardBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.userCardBtn.layer.masksToBounds = YES;
    self.userCardBtn.layer.cornerRadius = 2;
    self.userCardBtn.layer.borderWidth = 0.5;
    self.userCardBtn.layer.borderColor = RGB(204, 204, 204).CGColor;
    [self addSubview:self.userCardBtn];
    /** 开卡 */
    self.openCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.openCardBtn setTitle:@"开卡" forState:UIControlStateNormal];
    self.openCardBtn.titleLabel.font = ThirteenTypeface;
    [self.openCardBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.openCardBtn.layer.masksToBounds = YES;
    self.openCardBtn.layer.cornerRadius = 2;
    self.openCardBtn.layer.borderWidth = 0.5;
    self.openCardBtn.layer.borderColor = ThemeColor.CGColor;
    [self addSubview:self.openCardBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡名称 */
    [self.cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(16);
        make.left.equalTo(self.cardNumView.mas_right).offset(5);
    }];
    /** 卡号View */
    [self.cardNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cardNameLabel.mas_centerY);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.cardNumLabel.mas_right).offset(5);
        make.left.equalTo(self.cardNumLabel.mas_left).offset(-5);
        make.height.mas_equalTo(@13);
    }];
    /** 卡号Label */
    [self.cardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cardNumView.mas_centerY);
        make.centerX.equalTo(self.cardNumView.mas_centerX);
    }];
    /** 卡类型 */
    [self.cardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cardNameLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    /** 尖头 */
    [self.cardArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.availableServiceTitleLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    /** 可用服务标题 */
    [self.availableServiceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardNameLabel.mas_bottom).offset(16);
        make.left.equalTo(self.cardNumView.mas_left);
        make.width.mas_equalTo(@77.5);
    }];
    /** 可用服务 */
    [self.availableServiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.availableServiceTitleLabel.mas_centerY);
        make.left.equalTo(self.availableServiceTitleLabel.mas_right);
        make.right.equalTo(self.cardArrow.mas_left).offset(-32);
    }];
    /** 分割view */
    [self.dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.availableServiceLabel.mas_bottom).offset(16);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    /** 开卡 */
    [self.openCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineView.mas_bottom).offset(11.5);
        make.right.equalTo(self.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(58, 25));
    }];
    /** 用户会员卡 */
    [self.userCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.openCardBtn.mas_centerY);
        make.right.equalTo(self.openCardBtn.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
}

@end
