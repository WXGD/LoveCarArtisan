//
//  CardInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardInfoView.h"

@interface CardInfoView ()

/** 可用服务view */
@property (strong, nonatomic) UIView *canServiceView;
@property (strong, nonatomic) UILabel *canServiceTitleLabel;
@property (strong, nonatomic) UIImageView *arrowImage;

@end

@implementation CardInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cardInfoLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)cardInfoLayoutView {
    /** 卡名称view */
    self.cardNameView = [[UsedCellView alloc] init];
    self.cardNameView.cellLabel.text = @"名称";
    self.cardNameView.cellLabel.font = FifteenTypeface;
    self.cardNameView.cellLabel.textColor = Black;
    self.cardNameView.describeLabel.text = @"名称";
    self.cardNameView.describeLabel.font = ThirteenTypeface;
    self.cardNameView.describeLabel.textColor = GrayH1;
    self.cardNameView.usedCellBtn.tag = CardNameBtnAction;
    self.cardNameView.isCellImage = YES;
    self.cardNameView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.cardNameView];
    /** 卡类型view */
    self.cardTypeView = [[UsedCellView alloc] init];
    self.cardTypeView.cellLabel.text = @"类型";
    self.cardTypeView.cellLabel.font = FifteenTypeface;
    self.cardTypeView.cellLabel.textColor = Black;
    self.cardTypeView.describeLabel.text = @"类型";
    self.cardTypeView.describeLabel.font = ThirteenTypeface;
    self.cardTypeView.describeLabel.textColor = GrayH1;
    self.cardTypeView.usedCellBtn.tag = CardTypeBtnAction;
    self.cardTypeView.isCellImage = YES;
    self.cardTypeView.isArrow = YES;
    self.cardTypeView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.cardTypeView];
    /** 可用次数／可用金额view */
    self.canNumMoneyView = [[UsedCellView alloc] init];
    self.canNumMoneyView.cellLabel.text = @"可用次数";
    self.canNumMoneyView.cellLabel.font = FifteenTypeface;
    self.canNumMoneyView.cellLabel.textColor = Black;
    self.canNumMoneyView.describeLabel.text = @"可用次数";
    self.canNumMoneyView.describeLabel.font = ThirteenTypeface;
    self.canNumMoneyView.describeLabel.textColor = GrayH1;
    self.canNumMoneyView.usedCellBtn.tag = CanNumMoneyBtnAction;
    self.canNumMoneyView.isCellImage = YES;
    self.canNumMoneyView.isSplistLine = YES;
    [self addSubview:self.canNumMoneyView];
    /** 售价view */
    self.priceView = [[UsedCellView alloc] init];
    self.priceView.cellLabel.text = @"售价";
    self.priceView.cellLabel.font = FifteenTypeface;
    self.priceView.cellLabel.textColor = Black;
    self.priceView.describeLabel.text = @"售价";
    self.priceView.describeLabel.font = ThirteenTypeface;
    self.priceView.describeLabel.textColor = GrayH1;
    self.priceView.usedCellBtn.tag = PriceBtnAction;
    self.priceView.isCellImage = YES;
    self.priceView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.priceView];
    /** 原价view */
    self.costPriceView = [[UsedCellView alloc] init];
    self.costPriceView.cellLabel.text = @"原价";
    self.costPriceView.cellLabel.font = FifteenTypeface;
    self.costPriceView.cellLabel.textColor = Black;
    self.costPriceView.describeLabel.text = @"原价";
    self.costPriceView.describeLabel.font = ThirteenTypeface;
    self.costPriceView.describeLabel.textColor = GrayH1;
    self.costPriceView.usedCellBtn.tag = CostPriceBtnAction;
    self.costPriceView.isCellImage = YES;
    self.costPriceView.isSplistLine = YES;
    [self addSubview:self.costPriceView];
    /** 可用服务view */
    self.canServiceView = [[UIView alloc] init];
    self.canServiceView.backgroundColor = WhiteColor;
    [self addSubview:self.canServiceView];

    self.canServiceTitleLabel = [[UILabel alloc] init];
    self.canServiceTitleLabel.text = @"可用服务";
    self.canServiceTitleLabel.textColor = Black;
    self.canServiceTitleLabel.font = FifteenTypeface;
    [self.canServiceView addSubview:self.canServiceTitleLabel];

    self.canServiceContentLabel = [[UILabel alloc] init];
    self.canServiceContentLabel.textColor = GrayH1;
    self.canServiceContentLabel.font = ThirteenTypeface;
    self.canServiceContentLabel.numberOfLines = 0;
    [self.canServiceView addSubview:self.canServiceContentLabel];
    
    self.arrowImage = [[UIImageView alloc] init];
    self.arrowImage.image = [UIImage imageNamed:@"right_arrow"];
    [self.canServiceView addSubview:self.arrowImage];
    
    self.canServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canServiceBtn.tag = CanServiceBtnAction;
    [self.canServiceView addSubview:self.canServiceBtn];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡名称view */
    [self.cardNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 卡类型view */
    [self.cardTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardNameView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 可用次数／可用金额view */
    [self.canNumMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardTypeView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 售价view */
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.canNumMoneyView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 原价view */
    [self.costPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.priceView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 可用服务view */
    [self.canServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.costPriceView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.canServiceContentLabel.mas_bottom).offset(18);
    }];
    [self.canServiceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.canServiceView.mas_top).offset(16);
        make.left.equalTo(self.canServiceView.mas_left).offset(16);
        make.width.mas_equalTo(@61.5);
    }];

    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.canServiceTitleLabel.mas_centerY);
        make.right.equalTo(self.canServiceView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self.canServiceContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.canServiceTitleLabel.mas_top).offset(2);
        make.left.equalTo(self.canServiceTitleLabel.mas_right).offset(28);
        make.right.equalTo(self.arrowImage.mas_left).offset(-16);
    }];
    
    [self.canServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.canServiceView.mas_top);
        make.left.equalTo(self.canServiceView.mas_left);
        make.right.equalTo(self.canServiceView.mas_right);
        make.bottom.equalTo(self.canServiceView.mas_bottom);
    }];
}

@end
