//
//  UserMemberCardCellView.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserMemberCardCellView.h"

@interface UserMemberCardCellView ()

/** 分割view */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation UserMemberCardCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self userMemberCardCellLayoutView];
    }
    return self;
}


- (void)userMemberCardCellLayoutView {
    /** 卡号 */
    self.cardNumLabel = [[UILabel alloc] init];
    self.cardNumLabel.text = @"卡号";
    self.cardNumLabel.font = SixteenTypefaceBold;
    self.cardNumLabel.textColor = ThemeColor;
    [self addSubview:self.cardNumLabel];
    /** 卡名称 */
    self.cardNameLabel = [[UILabel alloc] init];
    self.cardNameLabel.text = @"卡名称";
    self.cardNameLabel.font = FourteenTypeface;
    self.cardNameLabel.textColor = Black;
    [self addSubview:self.cardNameLabel];
    
    /** 有效期 */
    self.expiryDate = [[leftRigText alloc] init];
    self.expiryDate.leftText.text = @"有效期：";
    self.expiryDate.leftText.font = TwelveTypeface;
    self.expiryDate.leftText.textColor = GrayH2;
    self.expiryDate.rightText.font = TwelveTypeface;
    self.expiryDate.rightText.textColor = GrayH2;
    [self addSubview:self.expiryDate];
    /** 余次/余额 */
    self.noreThan = [[leftRigText alloc] init];
    self.noreThan.leftText.text = @"余次：";
    self.noreThan.leftText.font = ThirteenTypeface;
    self.noreThan.leftText.textColor = GrayH1;
    self.noreThan.rightText.font = ThirteenTypeface;
    self.noreThan.rightText.textColor = GrayH1;
    [self addSubview:self.noreThan];
    /** 客户手机 */
    self.userPhone = [[leftRigText alloc] init];
    self.userPhone.leftText.text = @"手机号：";
    self.userPhone.leftText.font = ThirteenTypeface;
    self.userPhone.leftText.textColor = GrayH1;
    self.userPhone.rightText.font = ThirteenTypeface;
    self.userPhone.rightText.textColor = GrayH1;
    [self addSubview:self.userPhone];
    /** 分割view */
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = DividingLine;
    [self addSubview:self.lineView];
    /** 编辑 */
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = ThirteenTypeface;
    [self.editBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.cornerRadius = 2;
    self.editBtn.layer.borderWidth = 0.5;
    self.editBtn.layer.borderColor = RGB(204, 204, 204).CGColor;
    [self addSubview:self.editBtn];
    /** 充值 */
    self.rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    self.rechargeBtn.titleLabel.font = ThirteenTypeface;
    [self.rechargeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.rechargeBtn.layer.masksToBounds = YES;
    self.rechargeBtn.layer.cornerRadius = 2;
    self.rechargeBtn.layer.borderWidth = 0.5;
    self.rechargeBtn.layer.borderColor = ThemeColor.CGColor;
    [self addSubview:self.rechargeBtn];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡名称 */
    [self.cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(16);
        make.left.equalTo(self.cardNumLabel.mas_right).offset(10);
    }];
    /** 卡号View */
    [self.cardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cardNameLabel.mas_centerY);
        make.left.equalTo(self.mas_left).offset(16);
    }];
    /** 有效期 */
    [self.expiryDate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.cardNameLabel.mas_centerY);
        make.right.equalTo(self.expiryDate.rightText.mas_right);
        make.bottom.equalTo(self.expiryDate.rightText.mas_bottom);
    }];

    
    /** 客户手机 */
    [self.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardNameLabel.mas_bottom).offset(16);
        make.left.equalTo(self.cardNumLabel.mas_left);
        make.right.equalTo(self.userPhone.rightText.mas_right);
        make.bottom.equalTo(self.userPhone.rightText.mas_bottom);
    }];
    /** 余次/余额 */
    [self.noreThan mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.userPhone.mas_centerY);
        make.left.equalTo(self.noreThan.leftText.mas_left);
        make.bottom.equalTo(self.noreThan.rightText.mas_bottom);
    }];
    /** 分割view */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userPhone.mas_bottom).offset(16);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    /** 充值 */
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.lineView.mas_bottom).offset(11.5);
        make.right.equalTo(self.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(58, 25));
    }];
    /** 编辑 */
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.rechargeBtn.mas_centerY);
        make.right.equalTo(self.rechargeBtn.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(58, 25));
    }];
}

@end
