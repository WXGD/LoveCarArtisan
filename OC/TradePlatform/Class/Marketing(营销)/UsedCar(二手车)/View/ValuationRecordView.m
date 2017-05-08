//
//  ValuationRecordView.m
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ValuationRecordView.h"

@interface ValuationRecordView ()


@end

@implementation ValuationRecordView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self valuationRecordLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)valuationRecordLayoutView {
    self.backgroundColor = WhiteColor;
    /** 车牌型号 */
    self.carBrandLabel = [[UILabel alloc] init];
    self.carBrandLabel.textColor = Black;
    self.carBrandLabel.font = ThirteenTypeface;
    self.carBrandLabel.numberOfLines = 0;
    [self addSubview:self.carBrandLabel];
    /** 车牌号 */
    self.plnLabel = [[UILabel alloc] init];
    self.plnLabel.textColor = GrayH2;
    self.plnLabel.font = TwelveTypeface;
    [self addSubview:self.plnLabel];
    /** 车辆所在地区 */
    self.cityLabel = [[UILabel alloc] init];
    self.cityLabel.textColor = GrayH2;
    self.cityLabel.font = TwelveTypeface;
    [self addSubview:self.cityLabel];
    /** 上牌时间 */
    self.failingTimeLabel = [[UILabel alloc] init];
    self.failingTimeLabel.textColor = GrayH2;
    self.failingTimeLabel.font = TwelveTypeface;
    [self addSubview:self.failingTimeLabel];
    /** 估计View */
    self.valuationView = [[UIView alloc] init];
    self.valuationView.backgroundColor = VCBackgroundThree;
    [self addSubview:self.valuationView];
    /** 回收价格 */
    self.tecoveryPriceLabel = [[leftRigText alloc] init];
    self.tecoveryPriceLabel.leftText.text = @"收:";
    self.tecoveryPriceLabel.leftText.textColor = GrayH2;
    self.tecoveryPriceLabel.leftText.font = TwelveTypeface;
    self.tecoveryPriceLabel.rightText.font = EighteenTypeface;
    self.tecoveryPriceLabel.rightText.textColor = ThemeColor;
    [self.valuationView addSubview:self.tecoveryPriceLabel];
    /** 销售价格 */
    self.sellingPriceLabel = [[leftRigText alloc] init];
    self.sellingPriceLabel.leftText.text = @"销:";
    self.sellingPriceLabel.leftText.textColor = GrayH2;
    self.sellingPriceLabel.leftText.font = TwelveTypeface;
    self.sellingPriceLabel.rightText.font = EighteenTypeface;
    self.sellingPriceLabel.rightText.textColor = BlueColor;
    [self.valuationView addSubview:self.sellingPriceLabel];
    /** 估价失败 */
    self.valuationErrorView = [[UILabel alloc] init];
    self.valuationErrorView.backgroundColor = VCBackgroundThree;
    self.valuationErrorView.textAlignment = NSTextAlignmentCenter;
    self.valuationErrorView.text = @"估值失败，请重新提交！";
    self.valuationErrorView.textColor = HEXSTR_RGB(@"ef5350");
    self.valuationErrorView.font = TwelveTypeface;
    [self.valuationView addSubview:self.valuationErrorView];
    [self.valuationErrorView setHidden:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 车牌型号 */
    [self.carBrandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.left.equalTo(self.mas_left).offset(16);
    }];
    /** 车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBrandLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_equalTo(@18);
    }];
    /** 车辆所在地区 */
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@14.5);
    }];
    /** 上牌时间 */
    [self.failingTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cityLabel.mas_bottom).offset(10);
        make.right.equalTo(self.carBrandLabel.mas_right);
        make.height.mas_equalTo(@14.5);
    }];
    /** 估计View */
    [self.valuationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.failingTimeLabel.mas_bottom).offset(16);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@(48));
    }];
    /** 回收价格 */
    [self.tecoveryPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.valuationView.mas_top);
        make.left.equalTo(self.valuationView.mas_left);
        make.bottom.equalTo(self.valuationView.mas_bottom);
        make.right.equalTo(self.valuationView.mas_centerX);
    }];
    /** 销售价格 */
    [self.sellingPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.valuationView.mas_top);
        make.left.equalTo(self.valuationView.mas_centerX);
        make.bottom.equalTo(self.valuationView.mas_bottom);
        make.right.equalTo(self.valuationView.mas_right);
    }];
    /** 估价失败 */
    [self.valuationErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.valuationView.mas_top);
        make.left.equalTo(self.valuationView.mas_left);
        make.bottom.equalTo(self.valuationView.mas_bottom);
        make.right.equalTo(self.valuationView.mas_right);
    }];
}


@end
