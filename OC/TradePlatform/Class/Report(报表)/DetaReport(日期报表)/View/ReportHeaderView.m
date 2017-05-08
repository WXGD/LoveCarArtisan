//
//  ReportHeaderView.m
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ReportHeaderView.h"

@interface ReportHeaderView ()


@end

@implementation ReportHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = ThemeColor;
        [self reportHeaderLayoutView];
    }
    return self;
}

- (void)reportHeaderLayoutView {
    /** 页面标题 */
    self.pageTitleLabel = [[UILabel alloc] init];
    self.pageTitleLabel.font = FourteenTypeface;
    self.pageTitleLabel.textColor = WhiteColor;
    [self addSubview:self.pageTitleLabel];
    /** 客户数量 */
    self.customerView = [[TwoWordsLabel alloc] init];
    self.customerView.twoWordsShowStyle = ImageVerticallyAndHorizontalLayoutAndSuperCenter;
    self.customerView.mainImage.image = [UIImage imageNamed:@"customer"];
    self.customerView.mainLabel.text = @"";
    self.customerView.mainLabel.textColor = WhiteColor;
    self.customerView.mainLabel.font = FifteenTypeface;
    self.customerView.viceLabel.textColor = WhiteColor;
    self.customerView.viceLabel.font = FifteenTypeface;
    [self addSubview:self.customerView];
    /** 交易额 */
    self.turnoverByView = [[TwoWordsLabel alloc] init];
    self.turnoverByView.twoWordsShowStyle = ImageVerticallyAndHorizontalLayoutAndSuperCenter;
    self.turnoverByView.mainImage.image = [UIImage imageNamed:@"turnover_by"];
    self.turnoverByView.mainLabel.text = @"";
    self.turnoverByView.mainLabel.textColor = WhiteColor;
    self.turnoverByView.mainLabel.font = FifteenTypeface;
    self.turnoverByView.viceLabel.textColor = WhiteColor;
    self.turnoverByView.viceLabel.font = FifteenTypeface;
    [self addSubview:self.turnoverByView];
    /** 客户数环比 */
    self.customerMomView = [[TwoWordsLabel alloc] init];
    self.customerMomView.twoWordsShowStyle = TextHorizontalLayoutAndSuperCenter;
    self.customerMomView.mainLabel.text = @"";
    self.customerMomView.mainLabel.textColor = WhiteColor;
    self.customerMomView.mainLabel.font = FifteenTypeface;
    self.customerMomView.viceLabel.textColor = WhiteColor;
    self.customerMomView.viceLabel.font = FifteenTypeface;
    [self addSubview:self.customerMomView];
    /** 交易额环比 */
    self.turnoverByMomView = [[TwoWordsLabel alloc] init];
    self.turnoverByMomView.twoWordsShowStyle = TextHorizontalLayoutAndSuperCenter;
    self.turnoverByMomView.mainLabel.text = @"";
    self.turnoverByMomView.mainLabel.textColor = WhiteColor;
    self.turnoverByMomView.mainLabel.font = FifteenTypeface;
    self.turnoverByMomView.viceLabel.textColor = WhiteColor;
    self.turnoverByMomView.viceLabel.font = FifteenTypeface;
    [self addSubview:self.turnoverByMomView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 页面标题 */
    [self.pageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(9);
    }];
    /** 客户数量 */
    [self.customerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.pageTitleLabel.mas_bottom).offset(25);
        make.bottom.equalTo(self.customerView.viceLabel.mas_bottom);
    }];
    /** 交易额 */
    [self.turnoverByView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.customerView.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.pageTitleLabel.mas_bottom).offset(25);
        make.bottom.equalTo(self.turnoverByView.viceLabel.mas_bottom);
    }];
    /** 客户数环比 */
    [self.customerMomView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.customerView.mas_bottom).offset(15);
        make.bottom.equalTo(self.customerMomView.viceLabel.mas_bottom);
    }];
    /** 交易额环比 */
    [self.turnoverByMomView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.customerView.mas_bottom).offset(15);
        make.left.equalTo(self.customerMomView.mas_right);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.turnoverByMomView.viceLabel.mas_bottom);
    }];
    /** 客户数量,交易额,客户数环比,交易额环比 */
    [@[self.customerView, self.turnoverByView, self.customerMomView, self.turnoverByMomView] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.customerView.mas_width);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.customerMomView.mas_bottom).offset(30);
    }];

}

@end
