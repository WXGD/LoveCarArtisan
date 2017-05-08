//
//  MarketingView.m
//  TradePlatform
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MarketingView.h"

@interface MarketingView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *marketingScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *marketingBackView;
/** 用户跟踪操作 */
@property (strong, nonatomic) UIView *userTrackingOperationView;

@end

@implementation MarketingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self marketingLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)marketingLayoutView {
    /** 背景scrollview */
    self.marketingScrollView = [[UIScrollView alloc] init];
    self.marketingScrollView.backgroundColor = VCBackground;
    [self addSubview:self.marketingScrollView];
    /** 填充scrollview的view */
    self.marketingBackView = [[UIView alloc] init];
    self.marketingBackView.backgroundColor = VCBackground;
    [self.marketingScrollView addSubview:self.marketingBackView];
    /** 保险 */
    self.benefitView = [[MarketingCell alloc] init];
    self.benefitView.backgroundColor = WhiteColor;
    self.benefitView.marketingProjectLogo.image = [UIImage imageNamed:@"marketing_safest_logo"];
    self.benefitView.marketingProjectName.text = @"保险查询";
    self.benefitView.marketingProjectViceTitle.text = @"快速查询用户保险到期时间";
    self.benefitView.marketingProjectViceTitle.textColor = HEXSTR_RGB(@"#2c80ff");
    self.benefitView.marketingBtn.tag = BenefitBtnAction;
    [self.marketingBackView addSubview:self.benefitView];
    /** 二手车 */
    self.usedCarView = [[MarketingCell alloc] init];
    self.usedCarView.backgroundColor = WhiteColor;
    self.usedCarView.marketingProjectLogo.image = [UIImage imageNamed:@"marketing_used_car_logo"];
    self.usedCarView.marketingProjectName.text = @"二手车估值";
    self.usedCarView.marketingProjectViceTitle.text = @"快速精准评估二手车价格";
    self.usedCarView.marketingProjectViceTitle.textColor = HEXSTR_RGB(@"#45c018");
    self.usedCarView.marketingBtn.tag = UsedCarBtnAction;
    [self.marketingBackView addSubview:self.usedCarView];
    /** 用户跟踪 */
    self.userTrackingView = [[MarketingCell alloc] init];
    self.userTrackingView.backgroundColor = WhiteColor;
    self.userTrackingView.marketingProjectLogo.image = [UIImage imageNamed:@"marketing_used_tracking"];
    self.userTrackingView.marketingProjectName.text = @"用户跟踪";
    self.userTrackingView.marketingProjectViceTitle.text = @"进行精准用户管理";
    self.userTrackingView.marketingProjectViceTitle.textColor = HEXSTR_RGB(@"#9575cd");
    [self.userTrackingView.marketingProjectArrowImage setHidden:YES];
    [self.marketingBackView addSubview:self.userTrackingView];
    /** 用户跟踪操作 */
    self.userTrackingOperationView = [[UIView alloc] init];
    self.userTrackingOperationView.backgroundColor = WhiteColor;
    [self.marketingBackView addSubview:self.userTrackingOperationView];
    /** 会员卡到期 */
    self.cardExpireBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cardExpireBtn setImage:[UIImage imageNamed:@"marketing_card_expire"] forState:UIControlStateNormal];
    [self.cardExpireBtn setTitle:@"会员卡到期" forState:UIControlStateNormal];
    [self.cardExpireBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.cardExpireBtn.titleLabel.font = TwelveTypeface;
    self.cardExpireBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
    self.cardExpireBtn.tag = CardExpireBtnAction;
    [self.userTrackingOperationView addSubview:self.cardExpireBtn];
    /** 会员卡余额不足 */
    self.balanceNotEnoughBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.balanceNotEnoughBtn setImage:[UIImage imageNamed:@"marketing_balance_not_enough"] forState:UIControlStateNormal];
    [self.balanceNotEnoughBtn setTitle:@"会员卡余额不足" forState:UIControlStateNormal];
    [self.balanceNotEnoughBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.balanceNotEnoughBtn.titleLabel.font = TwelveTypeface;
    self.balanceNotEnoughBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
    self.balanceNotEnoughBtn.tag = BalanceNotEnoughBtnAction;
    [self.userTrackingOperationView addSubview:self.balanceNotEnoughBtn];
    /** 长期未到店 */
    self.longNotShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.longNotShopBtn setImage:[UIImage imageNamed:@"marketing_long_not_shop"] forState:UIControlStateNormal];
    [self.longNotShopBtn setTitle:@"长期未到店" forState:UIControlStateNormal];
    [self.longNotShopBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.longNotShopBtn.titleLabel.font = TwelveTypeface;
    self.longNotShopBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
    self.longNotShopBtn.tag = LongNotShopBtnAction;
    [self.userTrackingOperationView addSubview:self.longNotShopBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.marketingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.marketingBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.marketingScrollView.mas_top);
        make.left.equalTo(self.marketingScrollView.mas_left);
        make.bottom.equalTo(self.marketingScrollView.mas_bottom);
        make.right.equalTo(self.marketingScrollView.mas_right);
        make.width.equalTo(self.marketingScrollView.mas_width);
    }];
    /** 保险 */
    [self.benefitView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.marketingBackView.mas_top).offset(16);
        make.left.equalTo(self.marketingBackView.mas_left).offset(16);
        make.right.equalTo(self.marketingBackView.mas_right).offset(-16);
    }];
    /** 二手车 */
    [self.usedCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benefitView.mas_bottom).offset(16);
        make.left.equalTo(self.marketingBackView.mas_left).offset(16);
        make.right.equalTo(self.marketingBackView.mas_right).offset(-16);
    }];
    /** 用户跟踪 */
    [self.userTrackingView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usedCarView.mas_bottom).offset(16);
        make.left.equalTo(self.marketingBackView.mas_left).offset(16);
        make.right.equalTo(self.marketingBackView.mas_right).offset(-16);
    }];
    /** 用户跟踪操作 */
    [self.userTrackingOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userTrackingView.mas_bottom);
        make.left.equalTo(self.marketingBackView.mas_left).offset(16);
        make.right.equalTo(self.marketingBackView.mas_right).offset(-16);
        make.height.mas_equalTo(@24);
    }];
    /** 会员卡到期 */
    [self.cardExpireBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userTrackingOperationView.mas_top);
        make.left.equalTo(self.userTrackingOperationView.mas_left);
        make.width.equalTo(self.cardExpireBtn.mas_width);
    }];
    /** 会员卡余额不足 */
    [self.balanceNotEnoughBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userTrackingOperationView.mas_top);
        make.left.equalTo(self.cardExpireBtn.mas_right);
        make.width.equalTo(self.cardExpireBtn.mas_width);
    }];
    /** 长期未到店 */
    [self.longNotShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userTrackingOperationView.mas_top);
        make.left.equalTo(self.balanceNotEnoughBtn.mas_right);
        make.right.equalTo(self.userTrackingOperationView.mas_right);
        make.width.equalTo(self.cardExpireBtn.mas_width);
    }];

    /** 填充view的高 */
    [self.marketingBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.userTrackingOperationView.mas_bottom);
    }];
}

@end
