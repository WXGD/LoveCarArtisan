//
//  BenefitPaySuccessView.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitPaySuccessView.h"

@interface BenefitPaySuccessView ()

/** 成功标记view */
@property (strong, nonatomic) UIView *sucLogoView;
/** 成功logo */
@property (strong, nonatomic) UIImageView *sucLogoImage;
/** 成功提示 */
@property (strong, nonatomic) UILabel *sucPromptLabel;
/** 成功副提示 */
@property (strong, nonatomic) UILabel *sucVicePromptLabel;
/** 成功后操作view */
@property (strong, nonatomic) UIView *successOperationView;



@end

@implementation BenefitPaySuccessView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self benefitPaySuccessLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)benefitPaySuccessLayoutView {
    
    /** 成功标记view */
    self.sucLogoView = [[UIView alloc] init];
    self.sucLogoView.backgroundColor = WhiteColor;
    [self addSubview:self.sucLogoView];
    /** 成功logo */
    self.sucLogoImage = [[UIImageView alloc] init];
    self.sucLogoImage.image = [UIImage imageNamed:@"open_card_success"];
    [self.sucLogoView addSubview:self.sucLogoImage];
    /** 成功提示 */
    self.sucPromptLabel = [[UILabel alloc] init];
    self.sucPromptLabel.text = @"支付成功";
    self.sucPromptLabel.textColor = GrayH1;
    self.sucPromptLabel.font = SixteenTypeface;
    [self.sucLogoView addSubview:self.sucPromptLabel];
    /** 成功副提示 */
    self.sucVicePromptLabel = [[UILabel alloc] init];
    self.sucVicePromptLabel.text = @"已成功购买车险，保险公司将立即为受保人邮寄保单。请耐心等待...";
    self.sucVicePromptLabel.textColor = GrayH1;
    self.sucVicePromptLabel.font = TwelveTypeface;
    self.sucVicePromptLabel.numberOfLines = 0;
    self.sucVicePromptLabel.textAlignment = NSTextAlignmentCenter;
    [self.sucLogoView addSubview:self.sucVicePromptLabel];
    /** 成功后操作view */
    self.successOperationView = [[UIView alloc] init];
    self.successOperationView.backgroundColor = WhiteColor;
    [self addSubview:self.successOperationView];
    /** 继续询价 */
    self.continueQuiryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.continueQuiryBtn setTitle:@"继续询价" forState:UIControlStateNormal];
    [self.continueQuiryBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.continueQuiryBtn.titleLabel.font = SixteenTypeface;
    self.continueQuiryBtn.backgroundColor = WhiteColor;
    self.continueQuiryBtn.layer.masksToBounds = YES;
    self.continueQuiryBtn.layer.cornerRadius = 3;
    self.continueQuiryBtn.layer.borderWidth = 0.5;
    self.continueQuiryBtn.layer.borderColor = ThemeColor.CGColor;
    [self.successOperationView addSubview:self.continueQuiryBtn];
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
    [self.successOperationView addSubview:self.returnHomeBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 成功标记view */
    [self.sucLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.sucVicePromptLabel.mas_bottom).offset(16);
    }];
    /** 成功logo */
    [self.sucLogoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.sucLogoView.mas_top).offset(44);
        make.centerX.equalTo(self.sucLogoView.mas_centerX);
    }];
    /** 成功提示 */
    [self.sucPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.sucLogoImage.mas_bottom).offset(22);
        make.centerX.equalTo(self.sucLogoView.mas_centerX);
    }];
    /** 成功副提示 */
    [self.sucVicePromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.sucPromptLabel.mas_bottom).offset(10);
        make.left.equalTo(self.sucLogoView.mas_left).offset(32);
        make.right.equalTo(self.sucLogoView.mas_right).offset(-32);
    }];
    /** 成功后操作view */
    [self.successOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.sucLogoView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.continueQuiryBtn.mas_bottom).offset(40);
    }];
    /** 继续询价 */
    [self.continueQuiryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
}

@end
