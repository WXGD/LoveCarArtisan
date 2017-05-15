//
//  CashierPremiumView.m
//  TradePlatform
//
//  Created by 弓杰 on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierPremiumView.h"


@interface CashierPremiumView()

/** 显示内容 */
@property (nonatomic, strong) UILabel *containerLabel;
/** 取消 */
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation CashierPremiumView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cashierPremiumViewLayoutView];
    }
    return self;
}

/** 取消 */
- (void)cancelBtnAction:(UIButton *)button {
    [self removeFromSuperview];
}
/** 使用赠品 */
- (void)employBtnAction:(UIButton *)button {
    [self removeFromSuperview];
    if (_delegate && [_delegate respondsToSelector:@selector(employBtnDelegate:)]) {
        [_delegate employBtnDelegate:button];
    }
}
#pragma mark - view布局
- (void)cashierPremiumViewLayoutView {
    /** 显示内容的容器 */
    self.containerImage = [[UIImageView alloc] init];
    self.containerImage.image = [UIImage imageNamed:@"cashier_premium"];
    self.containerImage.userInteractionEnabled = YES;
    [self addSubview:self.containerImage];
    /** 显示内容 */
    self.containerLabel = [[UILabel alloc] init];
    self.containerLabel.text = @"该用户有赠品可以使用，是否使用？";
    self.containerLabel.textColor = WhiteColor;
    self.containerLabel.font = TwelveTypeface;
    [self.containerImage addSubview:self.containerLabel];
    /** 使用 */
    self.employBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.employBtn setTitle:@"使用" forState:UIControlStateNormal];
    [self.employBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    self.employBtn.backgroundColor = WhiteColor;
    self.employBtn.titleLabel.font = ThirteenTypeface;
    self.employBtn.layer.masksToBounds = YES;
    self.employBtn.layer.cornerRadius = 2;
    self.employBtn.layer.borderWidth = 0.5;
    self.employBtn.layer.borderColor = WhiteColor.CGColor;
    [self.employBtn addTarget:self action:@selector(employBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerImage addSubview:self.employBtn];
    /** 取消 */
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = ThirteenTypeface;
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 2;
    self.cancelBtn.layer.borderWidth = 0.5;
    self.cancelBtn.layer.borderColor = WhiteColor.CGColor;
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerImage addSubview:self.cancelBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 显示内容的容器 */
    [self.containerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.employBtn.mas_bottom).offset(8);
    }];
    /** 显示内容 */
    [self.containerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.containerImage.mas_left).offset(16);
        make.top.equalTo(self.containerImage.mas_top).offset(12);
    }];
    /** 使用 */
    [self.employBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.containerLabel.mas_bottom).offset(10);
        make.right.equalTo(self.containerImage.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    /** 取消 */
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.employBtn.mas_centerY);
        make.right.equalTo(self.employBtn.mas_left).offset(-16);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
}


@end
