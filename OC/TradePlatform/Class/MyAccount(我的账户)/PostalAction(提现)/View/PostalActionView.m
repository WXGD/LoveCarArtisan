//
//  PostalActionView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PostalActionView.h"

@implementation PostalActionView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self postalActionLayoutView];
    }
    return self;
}
- (void)postalActionLayoutView{
    self.backgroundColor = CLEARCOLOR;
    /** 银行背景view */
    self.postalBackView = [[UsedCellView alloc] init];
    self.postalBackView.isCellImage = NO;
    self.postalBackView.isCellBtn = NO;
    self.postalBackView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.postalBackView];
    /** 银行标题 */
    self.postalMoneyTitle = [[UILabel alloc] init];
    self.postalMoneyTitle.text = @"";
    self.postalMoneyTitle.textColor = Black;
    self.postalMoneyTitle.font = FourteenTypeface;
    [self.postalBackView addSubview:self.postalMoneyTitle];
    /** 提现金额Label */
    self.postalMoneyLabel = [[UILabel alloc] init];
    self.postalMoneyLabel.text = @"";
    self.postalMoneyLabel.textColor = GrayH1;
    self.postalMoneyLabel.font = TwelveTypeface;
    [self.postalBackView addSubview:self.postalMoneyLabel];
//    /** 提现金额btn */
//    self.postalMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.recordBackView addSubview:self.postalMoneyLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 银行背景view */
    [self.postalBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 银行标题 */
    [self.postalMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.postalBackView.mas_left).offset(16);
        make.top.equalTo(self.postalBackView.mas_top).offset(18);
        make.height.mas_equalTo(14);
    }];
    /** 提现金额Label */
    [self.postalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.postalMoneyTitle.mas_left);
        make.top.equalTo(self.postalMoneyTitle.mas_bottom).offset(15);
    }];
//    /** 提现金额btn */
//    [self.postalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left);
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
//        make.right.equalTo(self.mas_right);
//    }];
}
@end
