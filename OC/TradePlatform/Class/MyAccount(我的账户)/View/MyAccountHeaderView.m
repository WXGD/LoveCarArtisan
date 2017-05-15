//
//  MyAccountHeaderView.m
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyAccountHeaderView.h"

@interface MyAccountHeaderView ()

/** 头部view */
@property (strong, nonatomic) UIView *headerView;
/** 余额标题 */
@property (strong, nonatomic) UILabel *balanceTitle;
/** 余额单位 */
@property (strong, nonatomic) UILabel *balanceUnit;
/** 历史体现view */
@property (strong, nonatomic) UIView *historyPostalView;
/** 历史提现标题 */
@property (strong, nonatomic) UILabel *historyPostalTitle;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;
/** 本次最多体现view */
@property (strong, nonatomic) UIView *mostPostalView;
/** 本次最多提现标题 */
@property (strong, nonatomic) UILabel *mostPostalTitle;
/** 本次最多提现提示按钮 */
@property (strong, nonatomic) UIButton *mostPostalBtn;
/** 提现记录标题 */
@property (strong, nonatomic) UILabel *postalRecordTitle;

@end

@implementation MyAccountHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self myAccountHeaderLayoutView];
    }
    return self;
}

// 可提现余额提示点击
- (void)mostPostalBtnAction:(UIButton *)button {
    [AlertAction determineStay:[self viewController] title:@"提现金额说明" admitStr:@"知道了" message:@"当天的入账资金需到后一天才能结算，可提现余额实际是上一天的尚未提现的资金总额" determineBlock:^{
        
    }];
}

#pragma mark - view布局
- (void)myAccountHeaderLayoutView {
    /** 头部view */
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = ThemeColor;
    [self addSubview:self.headerView];
    /** 余额标题 */
    self.balanceTitle = [[UILabel alloc] init];
    self.balanceTitle.text = @"余额";
    self.balanceTitle.font = FifteenTypeface;
    self.balanceTitle.textColor = RGBA(255, 255, 255, 0.9);
    [self.headerView addSubview:self.balanceTitle];
    /** 余额数量 */
    self.balanceLabel = [[UILabel alloc] init];
    self.balanceLabel.text = @"余额数量";
    self.balanceLabel.font = ThirtyTypeface;
    self.balanceLabel.textColor = WhiteColor;
    [self.headerView addSubview:self.balanceLabel];
    /** 余额单位 */
    self.balanceUnit = [[UILabel alloc] init];
    self.balanceUnit.text = @"元";
    self.balanceUnit.font = FourteenTypeface;
    self.balanceUnit.textColor = WhiteColor;
    [self.headerView addSubview:self.balanceUnit];
    /** 提现按钮 */
    self.postalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.postalBtn setTitle:@"提现" forState:UIControlStateNormal];
    [self.postalBtn setTitleColor:RGBA(255, 255, 255, 0.9) forState:UIControlStateNormal];
    self.postalBtn.titleLabel.font = FourteenTypeface;
    self.postalBtn.layer.masksToBounds = YES;
    self.postalBtn.layer.cornerRadius = 12;
    self.postalBtn.layer.borderWidth = 1;
    self.postalBtn.layer.borderColor = HEXSTR_RGB(@"daf2d1").CGColor;
    [self.headerView addSubview:self.postalBtn];
    /** 历史体现view */
    self.historyPostalView = [[UIView alloc] init];
    self.historyPostalView.backgroundColor = HEXSTR_RGB(@"6acd46");
    [self addSubview:self.historyPostalView];
    /** 历史提现标题 */
    self.historyPostalTitle = [[UILabel alloc] init];
    self.historyPostalTitle.text = @"历史提现总额";
    self.historyPostalTitle.font = TwelveTypeface;
    self.historyPostalTitle.textColor = RGBA(255, 255, 255, 0.8);
    [self.historyPostalView addSubview:self.historyPostalTitle];
    /** 历史提现金额 */
    self.historyPostalLabel = [[UILabel alloc] init];
    self.historyPostalLabel.text = @"金额";
    self.historyPostalLabel.font = FourteenTypeface;
    self.historyPostalLabel.textColor = WhiteColor;
    [self.historyPostalView addSubview:self.historyPostalLabel];
    /** 分割线 */
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = HEXSTR_RGBA(@"3ba215", 0.4);
    [self.historyPostalView addSubview:self.lineView];
    /** 本次最多体现view */
    self.mostPostalView = [[UIView alloc] init];
    self.mostPostalView.backgroundColor = HEXSTR_RGB(@"6acd46");
    [self addSubview:self.mostPostalView];
    /** 本次最多提现标题 */
    self.mostPostalTitle = [[UILabel alloc] init];
    self.mostPostalTitle.text = @"本次最多可提现余额";
    self.mostPostalTitle.font = TwelveTypeface;
    self.mostPostalTitle.textColor = RGBA(255, 255, 255, 0.8);
    [self.mostPostalView addSubview:self.mostPostalTitle];
    /** 本次最多提现金额 */
    self.mostPostalLabel = [[UILabel alloc] init];
    self.mostPostalLabel.text = @"金额";
    self.mostPostalLabel.font = FourteenTypeface;
    self.mostPostalLabel.textColor = WhiteColor;
    [self.mostPostalView addSubview:self.mostPostalLabel];
    /** 本次最多提现提示按钮 */
    self.mostPostalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mostPostalBtn setImage:[UIImage imageNamed:@"my_account_postal_sign"] forState:UIControlStateNormal];
    [self.mostPostalBtn addTarget:self action:@selector(mostPostalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mostPostalView addSubview:self.mostPostalBtn];
    /** 提现记录标题 */
    self.postalRecordTitle = [[UILabel alloc] init];
    self.postalRecordTitle.text = @"提现记录";
    self.postalRecordTitle.font = FifteenTypeface;
    self.postalRecordTitle.textColor = HEXSTR_RGB(@"4d4d4d");
    [self addSubview:self.postalRecordTitle];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 头部view */
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.postalBtn.mas_bottom).offset(38);
    }];
    /** 余额标题 */
    [self.balanceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerView.mas_top).offset(25);
        make.centerX.equalTo(self.headerView.mas_centerX);
    }];
    /** 余额数量 */
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.balanceTitle.mas_bottom).offset(16);
        make.centerX.equalTo(self.headerView.mas_centerX);
    }];
    /** 余额单位 */
    [self.balanceUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.balanceLabel.mas_bottom).offset(-10);
        make.left.equalTo(self.balanceLabel.mas_right).offset(6);
    }];
    /** 提现按钮 */
    [self.postalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.balanceLabel.mas_bottom).offset(30);
        make.centerX.equalTo(self.headerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(86, 26));
    }];
    /** 历史体现view */
    [self.historyPostalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.historyPostalTitle.mas_bottom).offset(18);
    }];
    /** 历史提现金额 */
    [self.historyPostalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.historyPostalView.mas_top).offset(18);
        make.centerX.equalTo(self.historyPostalView.mas_centerX);
    }];
    /** 历史提现标题 */
    [self.historyPostalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.historyPostalLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.historyPostalView.mas_centerX);
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.historyPostalView.mas_top).offset(5);
        make.right.equalTo(self.historyPostalView.mas_right);
        make.bottom.equalTo(self.historyPostalView.mas_bottom).offset(-5);
        make.width.mas_equalTo(@0.5);

    }];
    [self.mostPostalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mostPostalTitle.mas_bottom).offset(18);
    }];
    /** 本次最多体现view */
    [self.mostPostalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mostPostalTitle.mas_bottom).offset(18);
    }];
    /** 本次最多提现金额 */
    [self.mostPostalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mostPostalView.mas_top).offset(18);
        make.centerX.equalTo(self.mostPostalView.mas_centerX);
    }];
    /** 本次最多提现标题 */
    [self.mostPostalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mostPostalLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.mostPostalView.mas_centerX);
    }];
    /** 本次最多提现提示按钮 */
    [self.mostPostalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mostPostalTitle.mas_right).offset(7);
        make.centerY.equalTo(self.mostPostalTitle.mas_centerY);
    }];
    /** 提现记录标题 */
    [self.postalRecordTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mostPostalView.mas_bottom).offset(13);
        make.left.equalTo(self.mas_left).offset(16);
    }];
    
    /** self高度 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.postalRecordTitle.mas_bottom).offset(13);
    }];
}

@end
