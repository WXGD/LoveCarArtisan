//
//  OpenCardSuccessView.m
//  TradePlatform
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OpenCardSuccessView.h"

@interface OpenCardSuccessView ()


/** 成功标记view */
@property (strong, nonatomic) UIView *sucLogoView;
/** 成功logo */
@property (strong, nonatomic) UIImageView *sucLogoImage;

/** 成功后操作view */
@property (strong, nonatomic) UIView *successOperationView;

@end


@implementation OpenCardSuccessView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self openCardSuccessViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)openCardSuccessViewLayoutView {
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
    self.sucPromptLabel.text = @"开卡成功";
    self.sucPromptLabel.textColor = GrayH1;
    self.sucPromptLabel.font = SixteenTypeface;
    [self.sucLogoView addSubview:self.sucPromptLabel];
    /** 成功后操作view */
    self.successOperationView = [[UIView alloc] init];
    self.successOperationView.backgroundColor = WhiteColor;
    [self addSubview:self.successOperationView];
    /** 继续开卡 */
    self.continueOpenCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.continueOpenCardBtn setTitle:@"继续开卡" forState:UIControlStateNormal];
    [self.continueOpenCardBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.continueOpenCardBtn.titleLabel.font = SixteenTypeface;
    self.continueOpenCardBtn.backgroundColor = WhiteColor;
    self.continueOpenCardBtn.layer.masksToBounds = YES;
    self.continueOpenCardBtn.layer.cornerRadius = 3;
    self.continueOpenCardBtn.layer.borderWidth = 0.5;
    self.continueOpenCardBtn.layer.borderColor = ThemeColor.CGColor;
    self.continueOpenCardBtn.tag = ContinueOpenCardBtnAction;
    [self.successOperationView addSubview:self.continueOpenCardBtn];
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
    /** 成功标记view */
    [self.sucLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.sucPromptLabel.mas_bottom).offset(16);
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
    
    /** 成功后操作view */
    [self.successOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.sucLogoView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.continueOpenCardBtn.mas_bottom).offset(40);
    }];
    /** 继续收款 */
    [self.continueOpenCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
