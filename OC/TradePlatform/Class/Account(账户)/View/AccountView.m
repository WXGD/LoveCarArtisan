//
//  AccountView.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AccountView.h"

@interface AccountView ()


@end

@implementation AccountView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self accountLayoutView];
    }
    return self;
}

- (void)accountLayoutView {
    /** 当前用户 */
    self.currentUserView = [[UsedCellView alloc] init];
    self.currentUserView.cellImage.image = [UIImage imageNamed:@"account_current_user"];
    [self.currentUserView.arrowImage setImage:[UIImage imageNamed:@"right_arrow_white"] forState:UIControlStateNormal];
    self.currentUserView.backgroundColor = ThemeColor;
    self.currentUserView.cellLabel.text = @"当前用户";
    self.currentUserView.cellLabel.textColor = WhiteColor;
    self.currentUserView.cellLabel.font = EighteenTypefaceBold;
    self.currentUserView.describeLabel.text = @"修改密码";
    self.currentUserView.describeLabel.font = ThirteenTypeface;
    self.currentUserView.describeLabel.textColor = WhiteColor;
    self.currentUserView.isSplistLine = YES;
    self.currentUserView.usedCellBtn.tag = CurrentUserBtnAction;
    [self addSubview:self.currentUserView];
    /** 商户信息 */
    self.tenantsInfoView = [[UsedCellView alloc] init];
    self.tenantsInfoView.cellImage.image = [UIImage imageNamed:@"account_tenants_Info"];
    self.tenantsInfoView.cellLabel.text = @"店铺名称";
    self.tenantsInfoView.cellLabel.font = FifteenTypeface;
    self.tenantsInfoView.describeLabel.text = @"便捷管理";
    self.tenantsInfoView.isSplistLine = YES;
    self.tenantsInfoView.usedCellBtn.tag = TenantsInfoBtnAction;
    [self addSubview:self.tenantsInfoView];
    /** 二维码 */
    self.QRCodeView = [[UsedCellView alloc] init];
    self.QRCodeView.cellImage.image = [UIImage imageNamed:@"account_qr"];
    self.QRCodeView.cellLabel.text = @"二维码";
    self.QRCodeView.describeLabel.text = @"扫一扫，关注我们";
    self.QRCodeView.cellLabel.font = FifteenTypeface;
    self.QRCodeView.usedCellBtn.tag = QRCodeBtnAction;
    [self addSubview:self.QRCodeView];
    /** 我的账户 */
    self.myAccountView = [[UsedCellView alloc] init];
    self.myAccountView.cellImage.image = [UIImage imageNamed:@"account_my_account"];
    self.myAccountView.cellLabel.text = @"我的账户";
    self.myAccountView.describeLabel.text = @"查看余额";
    self.myAccountView.cellLabel.font = FifteenTypeface;
    self.myAccountView.isSplistLine = YES;
    self.myAccountView.usedCellBtn.tag = MyAccountBtnAction;
    [self addSubview:self.myAccountView];
    /** 关于我们 */
    self.aboutUsView = [[UsedCellView alloc] init];
    self.aboutUsView.cellImage.image = [UIImage imageNamed:@"account_about_us"];
    self.aboutUsView.cellLabel.text = @"关于我们";
    self.aboutUsView.cellLabel.font = FifteenTypeface;
    self.aboutUsView.isSplistLine = YES;
    self.aboutUsView.usedCellBtn.tag = aboutUsBtnAction;
    [self addSubview:self.aboutUsView];
    /** 设置 */
    self.setUpView = [[UsedCellView alloc] init];
    self.setUpView.cellImage.image = [UIImage imageNamed:@"account_set_up"];
    self.setUpView.cellLabel.text = @"设置";
    self.setUpView.cellLabel.font = FifteenTypeface;
    self.setUpView.isSplistLine = YES;
    self.setUpView.usedCellBtn.tag = SetUpBtnAction;
    [self addSubview:self.setUpView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 当前用户 */
    [self.currentUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@65);
    }];
    /** 店面信息 */
    [self.tenantsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.currentUserView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 二维码 */
    [self.QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.tenantsInfoView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 我的账户 */
    [self.myAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.QRCodeView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 关于我们 */
    [self.aboutUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.myAccountView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 设置 */
    [self.setUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.aboutUsView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
}

@end
