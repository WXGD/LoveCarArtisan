//
//  PaySuccessView.m
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PaySuccessView.h"

@interface PaySuccessView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *orderInfoScrollView;

/** 成功标记view */
@property (strong, nonatomic) UIView *successLogoView;
/** 成功logo */
@property (strong, nonatomic) UIImageView *sucLogoImage;
/** 成功提示 */
@property (strong, nonatomic) UILabel *sucPromptLabel;


/** 分割线1 */
@property (strong, nonatomic) UIView *dividingLineOne;
/** 完善信息提示 */
@property (strong, nonatomic) UILabel *perfectInfoPromptLabel;
/** 分割线2 */
@property (strong, nonatomic) UIView *dividingLineTwo;


/** 成功后操作view */
@property (strong, nonatomic) UIView *successOperationView;

@end

@implementation PaySuccessView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self paySuccessViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)paySuccessViewLayoutView {
    /** 背景scrollview */
    self.orderInfoScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.orderInfoScrollView];
    /** 填充scrollview的view */
    self.orderInfoBackView = [[UIStackView alloc] init];
    self.orderInfoBackView.axis = UILayoutConstraintAxisVertical;
    [self.orderInfoScrollView addSubview:self.orderInfoBackView];
    /** 成功标记view */
    self.successLogoView = [[UIView alloc] init];
    self.successLogoView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.successLogoView];
    /** 成功logo */
    self.sucLogoImage = [[UIImageView alloc] init];
    self.sucLogoImage.image = [UIImage imageNamed:@"pay_success_logo"];
    [self.successLogoView addSubview:self.sucLogoImage];
    /** 成功提示 */
    self.sucPromptLabel = [[UILabel alloc] init];
    self.sucPromptLabel.text = @"收款成功";
    self.sucPromptLabel.textColor = GrayH1;
    self.sucPromptLabel.font = SixteenTypeface;
    [self.successLogoView addSubview:self.sucPromptLabel];

    /** 完善信息view */
    self.perfectInfoView = [[UIView alloc] init];
    self.perfectInfoView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.perfectInfoView];
    /** 分割线1 */
    self.dividingLineOne = [[UIView alloc] init];
    self.dividingLineOne.backgroundColor = DividingLine;
    [self.perfectInfoView addSubview:self.dividingLineOne];
    /** 完善信息提示 */
    self.perfectInfoPromptLabel = [[UILabel alloc] init];
    self.perfectInfoPromptLabel.text = @"该用户信息不完整，可能对以后服务造成不便，建议完善用户信息";
    self.perfectInfoPromptLabel.numberOfLines = 0;
    self.perfectInfoPromptLabel.textColor = HEXSTR_RGB(@"ff6d00");
    self.perfectInfoPromptLabel.font = FourteenTypeface;
    [self.perfectInfoView addSubview:self.perfectInfoPromptLabel];
    /** 完善信息按钮 */
    self.perfectInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.perfectInfoBtn setTitle:@"完善信息" forState:UIControlStateNormal];
    [self.perfectInfoBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.perfectInfoBtn.titleLabel.font = SixteenTypeface;
    self.perfectInfoBtn.backgroundColor = HEXSTR_RGB(@"ff6d00");
    self.perfectInfoBtn.layer.masksToBounds = YES;
    self.perfectInfoBtn.layer.cornerRadius = 3;
    self.perfectInfoBtn.tag = PerfectInfoBtnAction;
    [self.perfectInfoView addSubview:self.perfectInfoBtn];
    /** 分割线2 */
    self.dividingLineTwo = [[UIView alloc] init];
    self.dividingLineTwo.backgroundColor = DividingLine;
    [self.perfectInfoView addSubview:self.dividingLineTwo];
    
    /** 成功后操作view */
    self.successOperationView = [[UIView alloc] init];
    self.successOperationView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.successOperationView];
    /** 继续收款 */
    self.continueCashierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.continueCashierBtn setTitle:@"继续收款" forState:UIControlStateNormal];
    [self.continueCashierBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.continueCashierBtn.titleLabel.font = SixteenTypeface;
    self.continueCashierBtn.backgroundColor = WhiteColor;
    self.continueCashierBtn.layer.masksToBounds = YES;
    self.continueCashierBtn.layer.cornerRadius = 3;
    self.continueCashierBtn.layer.borderWidth = 0.5;
    self.continueCashierBtn.layer.borderColor = ThemeColor.CGColor;
    self.continueCashierBtn.tag = ContinueCashierBtnAction;
    [self.successOperationView addSubview:self.continueCashierBtn];
    /** 返回首页 */
    self.returnHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.returnHomeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [self.returnHomeBtn setTitleColor:GrayH2 forState:UIControlStateNormal];
    self.returnHomeBtn.titleLabel.font = SixteenTypeface;
    self.returnHomeBtn.backgroundColor = WhiteColor;
    self.returnHomeBtn.layer.masksToBounds = YES;
    self.returnHomeBtn.layer.cornerRadius = 3;
    self.returnHomeBtn.layer.borderWidth = 0.5;
    self.returnHomeBtn.layer.borderColor = GrayH2.CGColor;
    self.returnHomeBtn.tag = ReturnHomeBtnAction;
    [self.successOperationView addSubview:self.returnHomeBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.orderInfoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.orderInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderInfoScrollView.mas_top);
        make.left.equalTo(self.orderInfoScrollView.mas_left);
        make.bottom.equalTo(self.orderInfoScrollView.mas_bottom);
        make.right.equalTo(self.orderInfoScrollView.mas_right);
        make.width.equalTo(self.orderInfoScrollView.mas_width);
    }];
    
    /** 成功logo */
    [self.sucLogoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.successLogoView.mas_top).offset(44);
        make.centerX.equalTo(self.successLogoView.mas_centerX);
    }];
    /** 成功提示 */
    [self.sucPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.sucLogoImage.mas_bottom).offset(22);
        make.centerX.equalTo(self.successLogoView.mas_centerX);
    }];
    /** 成功标记view */
    [self.successLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.sucPromptLabel.mas_bottom).offset(16);
    }];
    
    
    /** 分割线1 */
    [self.dividingLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.perfectInfoView.mas_top);
        make.left.equalTo(self.perfectInfoView.mas_left).offset(16);
        make.right.equalTo(self.perfectInfoView.mas_right).offset(-16);
        make.height.mas_equalTo(@0.5);
    }];
    /** 完善信息提示 */
    [self.perfectInfoPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineOne.mas_bottom).offset(32);
        make.left.equalTo(self.perfectInfoView.mas_left).offset(16);
        make.right.equalTo(self.perfectInfoView.mas_right).offset(-16);
    }];
    /** 完善信息按钮 */
    [self.perfectInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.perfectInfoPromptLabel.mas_bottom).offset(32);
        make.centerX.equalTo(self.perfectInfoView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(130, 35));
    }];
    /** 分割线2 */
    [self.dividingLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.perfectInfoBtn.mas_bottom).offset(32);
        make.left.equalTo(self.perfectInfoView.mas_left).offset(16);
        make.right.equalTo(self.perfectInfoView.mas_right).offset(-16);
        make.height.mas_equalTo(@0.5);
    }];
    /** 完善信息view */
    [self.perfectInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.dividingLineTwo.mas_bottom);
    }];
    
    
    /** 继续收款 */
    [self.continueCashierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.successOperationView.mas_top).offset(40);
        make.left.equalTo(self.successOperationView.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake(130, 35));
    }];
    /** 返回首页 */
    [self.returnHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.successOperationView.mas_top).offset(40);
        make.right.equalTo(self.successOperationView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake(130, 35));
    }];
    /** 成功后操作view */
    [self.successOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.continueCashierBtn.mas_bottom).offset(40);
    }];
    /** 填充scrollview的view的高度 */
    [self.orderInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.successOperationView.mas_bottom);
    }];
}

@end
