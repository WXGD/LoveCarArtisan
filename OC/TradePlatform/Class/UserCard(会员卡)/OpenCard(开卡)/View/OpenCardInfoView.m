//
//  OpenCardInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OpenCardInfoView.h"
#import "UsableServiceAlert.h"

@interface OpenCardInfoView ()

/** 卡号 */
@property (nonatomic, strong) UIView *cardNumView;
/** 可用服务标题 */
@property (nonatomic, strong) UILabel *availableServiceTitleLabel;

@end

@implementation OpenCardInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self openCardInfoLayoutView];
    }
    return self;
}


/** 详情按钮 */
- (void)detailsBtnAction:(UIButton *)button {
    UsableServiceAlert *usableServiceDetails = [[UsableServiceAlert alloc] init];
    usableServiceDetails.usableServiceContentLabel.text = self.availableServiceLabel.text;
    [usableServiceDetails show];
}


- (void)openCardInfoLayoutView {
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
    self.cardTypeLabel.textColor = GrayH1;
    [self addSubview:self.cardTypeLabel];
    /** 详情按钮 */
    self.detailsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.detailsBtn setTitle:@"详情" forState:UIControlStateNormal];
    [self.detailsBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    self.detailsBtn.titleLabel.font = TwelveTypeface;
    [self.detailsBtn addTarget:self action:@selector(detailsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.detailsBtn];
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
    /** 可用次数／可用金额 */
    self.canNumMoneyLabel = [[leftRigText alloc] init];
    self.canNumMoneyLabel.leftText.textColor = GrayH1;
    self.canNumMoneyLabel.leftText.font = ThirteenTypeface;
    self.canNumMoneyLabel.rightText.font = ThirteenTypeface;
    self.canNumMoneyLabel.rightText.textColor = GrayH1;
    [self addSubview:self.canNumMoneyLabel];
    /** 原价 */
    self.costPriceLabel = [[leftRigText alloc] init];
    self.costPriceLabel.leftText.text = @"原价:";
    self.costPriceLabel.leftText.textColor = GrayH1;
    self.costPriceLabel.leftText.font = ThirteenTypeface;
    self.costPriceLabel.rightText.font = ThirteenTypeface;
    self.costPriceLabel.rightText.textColor = GrayH1;
    [self addSubview:self.costPriceLabel];
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
    /** 详情按钮 */
    [self.detailsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.availableServiceTitleLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-16);
        make.width.mas_equalTo(@25);
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
        make.right.equalTo(self.detailsBtn.mas_left).offset(-32);
    }];
    /** 可用次数／可用金额 */
    [self.canNumMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.availableServiceTitleLabel.mas_bottom).offset(16);
        make.left.equalTo(self.availableServiceTitleLabel.mas_left);
        make.right.equalTo(self.canNumMoneyLabel.rightText.mas_right);
        make.bottom.equalTo(self.canNumMoneyLabel.rightText.mas_bottom);
    }];
    /** 原价 */
    [self.costPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.canNumMoneyLabel.mas_centerY);
        make.right.equalTo(self.detailsBtn.mas_right);
        make.right.equalTo(self.costPriceLabel.rightText.mas_right);
        make.bottom.equalTo(self.costPriceLabel.rightText.mas_bottom);
    }];
}

@end
