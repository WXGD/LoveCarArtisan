//
//  CreditCardCellView.m
//  CarRepairFactory
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CreditCardCellView.h"

@interface CreditCardCellView ()


@end

@implementation CreditCardCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = ThemeColor;
        [self creditCardCellLayoutView];
    }
    return self;
}

- (void)creditCardCellLayoutView {
    /** 卡类型 */
    self.cardTypeImage = [[UIImageView alloc] init];
    self.cardTypeImage.image = [UIImage imageNamed:@"user_card_logo_available"];
    [self addSubview:self.cardTypeImage];
    
    self.cardType = [[UILabel alloc] init];
    self.cardType.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    self.cardType.textColor = Black;
    [self addSubview:self.cardType];
    /** 卡号 */
    self.cardNumberLabel = [[UILabel alloc] init];
    self.cardNumberLabel.font = FourteenTypeface;
    self.cardNumberLabel.textColor = Black;
    [self addSubview:self.cardNumberLabel];
    /** 余额标题 */
    self.balanceTitle = [[UILabel alloc] init];
    self.balanceTitle.font = FourteenTypeface;
    self.balanceTitle.textColor = HEXSTR_RGB(@"9a9a9a");
    self.balanceTitle.text = @"余额";
    [self addSubview:self.balanceTitle];
    /** 余额 */
    self.balance = [[UILabel alloc] init];
    self.balance.font = FourteenTypeface;
    self.balance.textColor = Black;
    [self addSubview:self.balance];
    /** 有效期标题 */
    self.expiryDateTitle = [[UILabel alloc] init];
    self.expiryDateTitle.font = FourteenTypeface;
    self.expiryDateTitle.textColor = HEXSTR_RGB(@"9a9a9a");
    self.expiryDateTitle.text = @"有效期";
    [self addSubview:self.expiryDateTitle];
    /** 有效期 */
    self.expiryDate = [[UILabel alloc] init];
    self.expiryDate.font = FourteenTypeface;
    self.expiryDate.textColor = Black;
    [self addSubview:self.expiryDate];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡类型 */
    [self.cardTypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(16);
        make.left.equalTo(self.mas_left).offset(16);
    }];
    [self.cardType mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(16);
        make.left.equalTo(self.cardTypeImage.mas_right).offset(7);
    }];
    /** 卡号 */
    [self.cardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    /** 余额标题 */
    [self.balanceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardTypeImage.mas_bottom).offset(24);
        make.left.equalTo(self.mas_left).offset(16);
    }];
    /** 余额 */
    [self.balance mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardTypeImage.mas_bottom).offset(24);
        make.left.equalTo(self.balanceTitle.mas_right).offset(10);
    }];
    /** 有效期 */
    [self.expiryDate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-16);
        make.top.equalTo(self.cardTypeImage.mas_bottom).offset(24);
    }];
    /** 有效期标题 */
    [self.expiryDateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.expiryDate.mas_left).offset(-10);
        make.top.equalTo(self.cardTypeImage.mas_bottom).offset(24);
    }];
   
}


@end
