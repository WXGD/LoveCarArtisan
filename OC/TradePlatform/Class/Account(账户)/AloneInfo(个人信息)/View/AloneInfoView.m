//
//  AloneInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AloneInfoView.h"

@implementation AloneInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self aloneInfoLayoutView];
    }
    return self;
}

- (void)aloneInfoLayoutView {
    /** 名字 */
    self.accountName = [[UsedCellView alloc] init];
    self.accountName.cellLabel.text = @"名字";
    self.accountName.cellLabel.font = FifteenTypeface;
    self.accountName.describeLabel.font = FifteenTypeface;
    self.accountName.describeLabel.textColor = Black;
    self.accountName.isSplistLine = YES;
    self.accountName.isCellImage = YES;
    self.accountName.isArrow = YES;
    self.accountName.usedCellBtn.tag = AccountNameBtnAction;
    [self addSubview:self.accountName];
    /** 手机号 */
    self.telPhone = [[UsedCellView alloc] init];
    self.telPhone.cellLabel.text = @"手机号";
    self.telPhone.cellLabel.font = FifteenTypeface;
    self.telPhone.describeLabel.font = FifteenTypeface;
    self.telPhone.describeLabel.textColor = Black;
    self.telPhone.isSplistLine = YES;
    self.telPhone.isCellImage = YES;
    self.telPhone.isArrow = YES;
    self.telPhone.usedCellBtn.tag = TelPhoneBtnAction;
    [self addSubview:self.telPhone];
    /** 修改密码 */
    self.delPassword = [[UsedCellView alloc] init];
    self.delPassword.cellLabel.text = @"修改密码";
    self.delPassword.cellLabel.font = FifteenTypeface;
    self.delPassword.describeLabel.font = FifteenTypeface;
    self.delPassword.describeLabel.textColor = Black;
    self.delPassword.isSplistLine = YES;
    self.delPassword.isCellImage = YES;
    self.delPassword.usedCellBtn.tag = DelPasswordBtnAction;
    [self addSubview:self.delPassword];
//    /** 退出当前账户 */
//    self.signOutView = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.signOutView setTitle:@"退出当前账户" forState:UIControlStateNormal];
//    [self.signOutView setTitleColor:WhiteColor forState:UIControlStateNormal];
//    self.signOutView.titleLabel.font = EighteenTypeface;
//    [self.signOutView setBackgroundImage:[UIImage imageNamed:@"login_btn_back"] forState:UIControlStateNormal];
//    [self.signOutView setBackgroundImage:[UIImage imageNamed:@"login_no_btn_back"] forState:UIControlStateSelected];
//    self.signOutView.adjustsImageWhenHighlighted = NO;
//    self.signOutView.tag = SignOutBtnAction;
//    [self addSubview:self.signOutView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 名字 */
    [self.accountName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 手机号 */
    [self.telPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.accountName.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 修改密码 */
    [self.delPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.telPhone.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
//    /** 退出当前账户 */
//    [self.signOutView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left).offset(16);
//        make.right.equalTo(self.mas_right).offset(-16);
//        make.top.equalTo(self.delPassword.mas_bottom).offset(30);
//        make.height.mas_equalTo(@50);
//    }];
}

@end
