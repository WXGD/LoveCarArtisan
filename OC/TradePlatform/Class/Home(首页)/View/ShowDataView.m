//
//  ShowDataView.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShowDataView.h"

@interface ShowDataView ()

/** 实时订单背景view */
@property (strong, nonatomic) UIView *showDataBackView;
@property (strong, nonatomic) UIImageView *showDataBackImage;
/** 营业额 */
@property (strong, nonatomic) UILabel *turnoverTitleLabel;
@property (strong, nonatomic) UILabel *chiefLabel;
/** 消费人数 */
@property (strong, nonatomic) UILabel *csmPleNumTitleLabel;
@property (strong, nonatomic) UIView *csmPleNumView;
/** 订单数 */
@property (strong, nonatomic) UILabel *orderNumTitleLabel;
@property (strong, nonatomic) UIView *orderNumView;
/** 分割线 */
@property (strong, nonatomic) UIView *dividingLineView;
/** 收银，扫一扫view */
@property (strong, nonatomic) UIImageView *cashierScanImage;
/** 分割线 */
@property (strong, nonatomic) UIView *cashierScanLineView;

@end

@implementation ShowDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self showDataLayoutView];
    }
    return self;
}

- (void)showDataLayoutView {
    /** 实时订单背景view */
    self.showDataBackView = [[UIView alloc] init];
    self.showDataBackView.backgroundColor = ThemeColor;
    [self addSubview:self.showDataBackView];

    self.showDataBackImage = [[UIImageView alloc] init];
    self.showDataBackImage.image = [UIImage imageNamed:@"home_show_back"];
    self.showDataBackImage.userInteractionEnabled = YES;
    [self.showDataBackView addSubview:self.showDataBackImage];
    /** 营业额 */
    self.turnoverTitleLabel = [[UILabel alloc] init];
    self.turnoverTitleLabel.text = @"今日营业总额";
    self.turnoverTitleLabel.font = FourteenTypeface;
    self.turnoverTitleLabel.textColor = RGBA(255, 255, 255, 0.8);
    [self.showDataBackView addSubview:self.turnoverTitleLabel];

    self.turnoverLabel = [[UILabel alloc] init];
    self.turnoverLabel.text = @"0.00";
    self.turnoverLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:45];
    self.turnoverLabel.textColor = WhiteColor;
    [self.showDataBackView addSubview:self.turnoverLabel];
    
    self.chiefLabel = [[UILabel alloc] init];
    self.chiefLabel.text = @"元";
    self.chiefLabel.font = FourteenTypeface;
    self.chiefLabel.textColor = WhiteColor;
    [self.showDataBackView addSubview:self.chiefLabel];
    /** 订单数 */
    self.orderNumView = [[UIView alloc] init];
    [self.showDataBackView addSubview:self.orderNumView];
    
    self.orderNumTitleLabel = [[UILabel alloc] init];
    self.orderNumTitleLabel.text = @"今日订单数";
    self.orderNumTitleLabel.font = TwelveTypeface;
    self.orderNumTitleLabel.textColor = RGBA(255, 255, 255, 0.6);
    [self.orderNumView addSubview:self.orderNumTitleLabel];
    
    self.orderNumLabel = [[UILabel alloc] init];
    self.orderNumLabel.text = @"0";
    self.orderNumLabel.font = TwentyThreeTypeface;
    self.orderNumLabel.textColor = WhiteColor;
    [self.orderNumView addSubview:self.orderNumLabel];
    /** 分割线 */
    self.dividingLineView = [[UIView alloc] init];
    self.dividingLineView.backgroundColor = RGBA(255, 255, 255, 0.4);
    [self.showDataBackView addSubview:self.dividingLineView];
    
    /** 消费人数 */
    self.csmPleNumView = [[UIView alloc] init];
    [self addSubview:self.csmPleNumView];

    self.csmPleNumTitleLabel = [[UILabel alloc] init];
    self.csmPleNumTitleLabel.text = @"今日服务人数";
    self.csmPleNumTitleLabel.font = TwelveTypeface;
    self.csmPleNumTitleLabel.textColor = RGBA(255, 255, 255, 0.6);
    [self.csmPleNumView addSubview:self.csmPleNumTitleLabel];

    self.csmPleNumLabel = [[UILabel alloc] init];
    self.csmPleNumLabel.text = @"0";
    self.csmPleNumLabel.font = TwentyThreeTypeface;
    self.csmPleNumLabel.textColor = WhiteColor;
    [self.csmPleNumView addSubview:self.csmPleNumLabel];
   
    /** 收银，扫一扫view */
    self.cashierScanImage = [[UIImageView alloc] init];
    self.cashierScanImage.image = [UIImage imageNamed:@"home_cashier_scan"];
    self.cashierScanImage.userInteractionEnabled = YES;
    [self addSubview:self.cashierScanImage];
    
    self.cashierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cashierBtn setTitle:@"收银" forState:UIControlStateNormal];
    [self.cashierBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.cashierBtn.titleLabel.font = FifteenTypeface;
    self.cashierBtn.tag = ReceiptBtnAction;
    [self.cashierScanImage addSubview:self.cashierBtn];
    /** 分割线 */
    self.cashierScanLineView = [[UIView alloc] init];
    self.cashierScanLineView.backgroundColor = DividingLine;
    [self.cashierScanImage addSubview:self.cashierScanLineView];
    
    self.scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scanBtn setImage:[UIImage imageNamed:@"home_page_scan"] forState:UIControlStateNormal];
    [self.scanBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.scanBtn.titleLabel.font = FifteenTypeface;
    self.scanBtn.tag = ScanBtnAction;
    [self.cashierScanImage addSubview:self.scanBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 实时订单背景view */
    [self.showDataBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    [self.showDataBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.showDataBackView.mas_bottom);
        make.left.equalTo(self.showDataBackView.mas_left);
        make.right.equalTo(self.showDataBackView.mas_right);
    }];
    /** 营业额 */
    [self.turnoverTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(32);
    }];
    [self.turnoverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.turnoverTitleLabel.mas_bottom).offset(18);
    }];
    [self.chiefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.turnoverLabel.mas_bottom).offset(-10);
        make.left.equalTo(self.turnoverLabel.mas_right).offset(9);
    }];
    /** 订单数 */
    [self.orderNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.turnoverLabel.mas_bottom).offset(36);
    }];
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNumView.mas_top);
        make.centerX.equalTo(self.orderNumView.mas_centerX);
    }];
    [self.orderNumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.orderNumView.mas_centerX);
        make.top.equalTo(self.orderNumLabel.mas_bottom).offset(12);
    }];
    [self.orderNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.orderNumTitleLabel.mas_bottom);
    }];
    /** 分割线 */
    [self.dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNumView.mas_right);
        make.width.mas_equalTo(@0.5);
    }];
    /** 消费人数 */
    [self.csmPleNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dividingLineView.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.turnoverLabel.mas_bottom).offset(36);
    }];
    [self.csmPleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.csmPleNumView.mas_top);
        make.centerX.equalTo(self.csmPleNumView.mas_centerX);
    }];
    [self.csmPleNumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.csmPleNumView.mas_centerX);
        make.top.equalTo(self.csmPleNumLabel.mas_bottom).offset(12);
    }];
    /** 订单数, 消费人数 */
    [@[self.orderNumView, self.csmPleNumView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.orderNumView.mas_width);
    }];
    /** 订单数, 分割线, 消费人数 */
    [@[self.orderNumView, self.dividingLineView, self.csmPleNumView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.turnoverLabel.mas_bottom).offset(36);
        make.height.equalTo(self.orderNumView.mas_height);
    }];
    /** 实时订单背景view高度 */
    [self.showDataBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.orderNumView.mas_bottom).offset(48);
    }];

    /** 收银，扫一扫view */
    [self.cashierScanImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.csmPleNumView.mas_bottom).offset(18);
        make.width.mas_equalTo(@161);
        make.height.mas_equalTo(@60);
    }];
    
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierScanImage.mas_left).offset(10);
    }];
    /** 分割线 */
    [self.cashierScanLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.cashierScanImage.mas_centerX);
        make.centerY.equalTo(self.cashierScanImage.mas_centerY);
        make.width.mas_equalTo(@0.5);
        make.height.mas_equalTo(@20);
    }];
    [self.cashierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierScanLineView.mas_right);
        make.right.equalTo(self.cashierScanImage.mas_right).offset(-10);
    }];
    /** 收银，扫一扫按钮 */
    [@[self.scanBtn, self.cashierBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.scanBtn.mas_width);
        make.top.equalTo(self.cashierScanImage.mas_top);
        make.bottom.equalTo(self.cashierScanImage.mas_bottom);
    }];
    /** 实时订单部分总高度 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.cashierScanImage.mas_bottom);
    }];
}


@end
