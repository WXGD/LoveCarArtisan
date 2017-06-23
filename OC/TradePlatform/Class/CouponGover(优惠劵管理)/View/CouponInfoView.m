//
//  CouponInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponInfoView.h"

@interface CouponInfoView ()

/** 优惠金额背景 */
@property (strong, nonatomic) UIView *moneyBackView;
/** 优惠劵信息背景 */
@property (strong, nonatomic) UIView *infoBackView;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation CouponInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self couponInfoLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)couponInfoLayoutView {
    /** 优惠金额背景 */
    self.moneyBackView = [[UIView alloc] init];
    [self addSubview:self.moneyBackView];
    /** 优惠金额 */
    self.couponSumLabel = [[UILabel alloc] init];
    self.couponSumLabel.textColor = RedColor;
    self.couponSumLabel.font = TwentyFourTypeface;
    [self.moneyBackView addSubview:self.couponSumLabel];
    /** 使用条件 */
    self.useConditionLabel = [[UILabel alloc] init];
    self.useConditionLabel.textColor = GrayH1;
    self.useConditionLabel.font = TwelveTypeface;
    [self.moneyBackView addSubview:self.useConditionLabel];
    /** 优惠金额标记 */
    self.couponSumSign = [[UILabel alloc] init];
    self.couponSumSign.textColor = RedColor;
    self.couponSumSign.font = FifteenTypeface;
    self.couponSumSign.text = @"¥";
    [self.moneyBackView addSubview:self.couponSumSign];
    /** 优惠劵信息背景 */
    self.infoBackView = [[UIView alloc] init];
    [self addSubview:self.infoBackView];
    /** 优惠券名称 */
    self.couponNameLabel = [[UILabel alloc] init];
    self.couponNameLabel.textColor = Black;
    self.couponNameLabel.font = FourteenTypeface;
    [self.infoBackView addSubview:self.couponNameLabel];
    /** 优惠券使用周期 */
    self.couponTimeLabel = [[UILabel alloc] init];
    self.couponTimeLabel.textColor = GrayH2;
    self.couponTimeLabel.font = ElevenTypeface;
    self.couponTimeLabel.numberOfLines = 0;
    [self.infoBackView addSubview:self.couponTimeLabel];
    /** 按钮 */
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
    [self.button setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.button setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.infoBackView addSubview:self.button];
    /** 分割线 */
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = DividingLine;
    [self addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 优惠金额背景 */
    [self.moneyBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(@130);
    }];
    /** 优惠金额 */
    [self.couponSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.moneyBackView.mas_centerY);
        make.centerX.equalTo(self.moneyBackView.mas_centerX);
    }];
    /** 使用条件 */
    [self.useConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.moneyBackView.mas_centerX);
        make.top.equalTo(self.couponSumLabel.mas_bottom).offset(3);
    }];
    /** 优惠金额标记 */
    [self.couponSumSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.couponSumLabel.mas_bottom).offset(-3);
        make.right.equalTo(self.couponSumLabel.mas_left).offset(-4);
    }];    
    /** 优惠金额背景 */
    [self.infoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.moneyBackView.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 优惠券名称 */
    [self.couponNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.infoBackView.mas_centerY).offset(-7.5);
        make.left.equalTo(self.infoBackView.mas_left);
        make.right.equalTo(self.button.mas_left).offset(-10);
    }];
    /** 优惠券使用周期 */
    [self.couponTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponNameLabel.mas_bottom).offset(15);
        make.left.equalTo(self.couponNameLabel.mas_left);
        make.right.equalTo(self.button.mas_left).offset(-10);
    }];
    /** 按钮 */
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.infoBackView.mas_centerY);
        make.right.equalTo(self.infoBackView.mas_right).offset(-16);
        if (!CGSizeEqualToSize(self.btnSize, CGSizeZero)) {
            make.size.mas_equalTo(self.btnSize);
        }
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
}

@end
