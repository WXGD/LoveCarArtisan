//
//  CashierBomView.m
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierBomView.h"

@interface CashierBomView ()

/** 收款view */
@property (strong, nonatomic) UIView *collectionView;
/** 实收款标题 */
@property (strong, nonatomic) UILabel *proceedsTitle;
/** 实收款标记 */
@property (strong, nonatomic) UILabel *proceedsSign;
/** 服务费用view */
@property (strong, nonatomic) UIView *serviceCostView;
/** 服务金额标记 */
@property (strong, nonatomic) UILabel *serviceSumSign;
/** 服务金额标题 */
@property (strong, nonatomic) UILabel *serviceSumTitle;
/** 优惠券金额标题 */ 
@property (strong, nonatomic) UILabel *couponSumTitle;
/** 优惠券金额标题 */
@property (strong, nonatomic) UILabel *couponSumSign;

@end

@implementation CashierBomView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self cashierBomLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)cashierBomLayoutView {
    /** 收款view */
    self.collectionView = [[UIView alloc] init];
    self.collectionView.backgroundColor = WhiteColor;
    [self addSubview:self.collectionView];
    /** 实收款标题 */
    self.proceedsTitle = [[UILabel alloc] init];
    self.proceedsTitle.text = @"实收款";
    self.proceedsTitle.font = TwelveTypeface;
    self.proceedsTitle.textColor = Black;
    [self.collectionView addSubview:self.proceedsTitle];
    /** 实收款标记 */
    self.proceedsSign = [[UILabel alloc] init];
    self.proceedsSign.text = @"¥";
    self.proceedsSign.font = TwelveTypeface;
    self.proceedsSign.textColor = RedColor;
    [self.collectionView addSubview:self.proceedsSign];
    /** 实收款 */
    self.proceedsLabel = [[UILabel alloc] init];
    self.proceedsLabel.font = TwelveTypeface;
    self.proceedsLabel.textColor = RedColor;
    [self.collectionView addSubview:self.proceedsLabel];
    /** 服务费用view */
    self.serviceCostView = [[UIView alloc] init];
    self.serviceCostView.backgroundColor = VCBackgroundThree;
    [self addSubview:self.serviceCostView];
    /** 服务金额标题 */
    self.serviceSumTitle = [[UILabel alloc] init];
    self.serviceSumTitle.text = @"服务金额";
    self.serviceSumTitle.font = TwelveTypeface;
    self.serviceSumTitle.textColor = GrayH1;
    [self.serviceCostView addSubview:self.serviceSumTitle];
    /** 服务金额标记 */
    self.serviceSumSign = [[UILabel alloc] init];
    self.serviceSumSign.text = @"¥";
    self.serviceSumSign.font = TwelveTypeface;
    self.serviceSumSign.textColor = Black;
    [self.serviceCostView addSubview:self.serviceSumSign];
    /** 服务金额 */
    self.serviceSumLabel = [[UILabel alloc] init];
    self.serviceSumLabel.font = TwelveTypeface;
    self.serviceSumLabel.textColor = Black;
    [self.serviceCostView addSubview:self.serviceSumLabel];
    /** 优惠券金额标题 */
    self.couponSumTitle = [[UILabel alloc] init];
    self.couponSumTitle.text = @"优惠券";
    self.couponSumTitle.font = TwelveTypeface;
    self.couponSumTitle.textColor = GrayH1;
    [self.serviceCostView addSubview:self.couponSumTitle];
    /** 优惠券金额标记 */
    self.couponSumSign = [[UILabel alloc] init];
    self.couponSumSign.font = TwelveTypeface;
    self.couponSumSign.textColor = Black;
    self.couponSumSign.text = @"-¥";
    [self.serviceCostView addSubview:self.couponSumSign];
    /** 优惠券金额 */
    self.couponSumLabel = [[UILabel alloc] init];
    self.couponSumLabel.font = TwelveTypeface;
    self.couponSumLabel.textColor = Black;
    self.couponSumLabel.text = @"0.00";
    [self.serviceCostView addSubview:self.couponSumLabel];
    /** 确认收款btn */
    self.confirCashierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirCashierBtn setTitle:@"确认收银" forState:UIControlStateNormal];
    self.confirCashierBtn.titleLabel.font = SixteenTypeface;
    self.confirCashierBtn.titleLabel.textColor = WhiteColor;
    self.confirCashierBtn.backgroundColor = ThemeColor;
    self.confirCashierBtn.layer.masksToBounds = YES;
    self.confirCashierBtn.layer.cornerRadius = 2;
    [self.collectionView addSubview:self.confirCashierBtn];
    /** 暂不收银 */
    self.temporCashierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.temporCashierBtn setTitle:@"暂不收银" forState:UIControlStateNormal];
    [self.temporCashierBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.temporCashierBtn.titleLabel.font = SixteenTypeface;
    self.temporCashierBtn.backgroundColor = WhiteColor;
    self.temporCashierBtn.layer.masksToBounds = YES;
    self.temporCashierBtn.layer.cornerRadius = 2;
    self.temporCashierBtn.layer.borderColor = ThemeColor.CGColor;
    self.temporCashierBtn.layer.borderWidth = 0.5;
    [self.collectionView addSubview:self.temporCashierBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 服务费用view */
    [self.serviceCostView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@30);
    }];
    /** 服务金额标题 */
    [self.serviceSumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.serviceCostView.mas_left).offset(16);
        make.centerY.equalTo(self.serviceCostView.mas_centerY);
    }];
    /** 服务金额标记 */
    [self.serviceSumSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.serviceSumTitle.mas_right).offset(5);
        make.centerY.equalTo(self.serviceCostView.mas_centerY);
    }];
    /** 服务金额 */
    [self.serviceSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.serviceSumSign.mas_right);
        make.centerY.equalTo(self.serviceCostView.mas_centerY);
    }];
    /** 优惠券金额标题 */
    [self.couponSumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.serviceSumLabel.mas_right).offset(24);
        make.centerY.equalTo(self.serviceCostView.mas_centerY);
    }];
    /** 优惠券金额标记 */
    [self.couponSumSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.couponSumTitle.mas_right).offset(5);
        make.centerY.equalTo(self.serviceCostView.mas_centerY);
    }];
    /** 优惠券金额 */
    [self.couponSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.couponSumSign.mas_right);
        make.centerY.equalTo(self.serviceCostView.mas_centerY);
    }];
    /** 收款view */
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.serviceCostView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 实收款标题 */
    [self.proceedsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.collectionView.mas_left).offset(16);
        make.centerY.equalTo(self.collectionView.mas_centerY);
    }];
    /** 实收款标记 */
    [self.proceedsSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.proceedsTitle.mas_right).offset(3);
        make.centerY.equalTo(self.collectionView.mas_centerY);
    }];
    /** 实收款 */
    [self.proceedsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.proceedsSign.mas_right);
        make.centerY.equalTo(self.collectionView.mas_centerY);
    }];
    /** 暂不收银 */
    [self.temporCashierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.collectionView.mas_top).offset(5);
        make.bottom.equalTo(self.collectionView.mas_bottom).offset(-5);
        make.left.equalTo(self.proceedsLabel.mas_right).offset(35);
        make.width.equalTo(self.confirCashierBtn.mas_width);
    }];
    /** 确认收款btn */
    [self.confirCashierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.collectionView.mas_top).offset(5);
        make.bottom.equalTo(self.collectionView.mas_bottom).offset(-5);
        make.left.equalTo(self.temporCashierBtn.mas_right).offset(15);
        make.right.equalTo(self.collectionView.mas_right).offset(-16);
        make.width.equalTo(self.confirCashierBtn.mas_width);
    }];
    
    /** self. */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.collectionView.mas_bottom);
    }];
}

@end
