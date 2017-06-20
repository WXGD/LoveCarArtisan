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
    self.accountName = [[CustomCell alloc] init];
    self.accountName.lineStyle = NotLine;
    self.accountName.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.accountName.mainLabel.text = @"姓名";
    self.accountName.mainLabel.font = FifteenTypeface;
    self.accountName.mainLabel.textColor = Black;
    self.accountName.rightViceLabel.font = ThirteenTypeface;
    self.accountName.rightViceLabel.textColor = GrayH1;
    self.accountName.mainBtn.tag = AccountNameBtnAction;
    [self addSubview:self.accountName];
    /** 手机号 */
    self.telPhone = [[CustomCell alloc] init];
    self.telPhone.lineStyle = NotLine;
    self.telPhone.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.telPhone.mainLabel.text = @"手机号";
    self.telPhone.mainLabel.font = FifteenTypeface;
    self.telPhone.mainLabel.textColor = Black;
    self.telPhone.rightViceLabel.font = ThirteenTypeface;
    self.telPhone.rightViceLabel.textColor = GrayH1;
    self.telPhone.mainBtn.tag = TelPhoneBtnAction;
    [self addSubview:self.telPhone];
    /** 修改密码 */
    self.delPassword = [[CustomCell alloc] init];
    self.delPassword.lineStyle = NotLine;
    self.delPassword.cellStyle = HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.delPassword.mainLabel.text = @"修改密码";
    self.delPassword.mainLabel.font = FifteenTypeface;
    self.delPassword.mainLabel.textColor = Black;
    self.delPassword.leftViceLabel.font = ThirteenTypeface;
    self.delPassword.leftViceLabel.textColor = GrayH1;
    self.delPassword.mainBtn.tag = DelPasswordBtnAction;
    [self addSubview:self.delPassword];
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
}

@end
