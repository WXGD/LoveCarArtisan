//
//  OrderCellView.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderCellView.h"

@interface OrderCellView ()

/** 服务商信息view */
@property (strong, nonatomic) UIView *serviceProviderView;
/** 订单信息view */
@property (strong, nonatomic) UIView *orderView;

@end

@implementation OrderCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self orderCellLayoutView];
    }
    return self;
}


- (void)orderCellLayoutView {
    /** 服务商信息view */
    self.serviceProviderView = [[UIView alloc] init];
    self.serviceProviderView.backgroundColor = WhiteColor;
    [self addSubview:self.serviceProviderView];
    /** 服务类型 */
    self.serviceTypeImage = [[UIImageView alloc] init];
    [self.serviceProviderView addSubview:self.serviceTypeImage];
    /** 服务类型名称 */
    self.serviceTypeLabel = [[UILabel alloc] init];
    self.serviceTypeLabel.font = FourteenTypeface;
    self.serviceTypeLabel.textColor = Black;
    [self.serviceProviderView addSubview:self.serviceTypeLabel];
    /** 订单状态 */
    self.orderStateLabel = [[UILabel alloc] init];
    self.orderStateLabel.font = ThirteenTypeface;
    self.orderStateLabel.textColor = BlueColor;
    [self.serviceProviderView addSubview:self.orderStateLabel];
    /** 订单信息view */
    self.orderView = [[UIView alloc] init];
    self.orderView.backgroundColor = VCBackgroundThree;
    [self addSubview:self.orderView];
    /** 订单名称 */
    self.orderNameLabel = [[UILabel alloc] init];
    self.orderNameLabel.font = ThirteenTypeface;
    self.orderNameLabel.textColor = Black;
    [self.orderView addSubview:self.orderNameLabel];
    /** 订单时间 */
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.font = TwelveTypeface;
    self.orderTimeLabel.textColor = GrayH1;
    [self.orderView addSubview:self.orderTimeLabel];
    /** 用户车牌号 */
    self.plnLabel = [[UILabel alloc] init];
    self.plnLabel.font = TwelveTypeface;
    self.plnLabel.textColor = GrayH2;
    [self.orderView addSubview:self.plnLabel];
    /** 用户手机号 */
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.font = TwelveTypeface;
    self.phoneLabel.textColor = GrayH2;
    [self.orderView addSubview:self.phoneLabel];
    /** 订单次数 */
    self.orderNumLabel = [[UILabel alloc] init];
    self.orderNumLabel.font = TwelveTypeface;
    self.orderNumLabel.textColor = GrayH1;
    [self.orderView addSubview:self.orderNumLabel];
    /** 订单价格 */
    self.orderPriceLabel = [[UILabel alloc] init];
    self.orderPriceLabel.font = TwelveTypeface;
    self.orderPriceLabel.textColor = GrayH1;
    [self.orderView addSubview:self.orderPriceLabel];
    
    /** 支付信息view */
    self.payView = [[UIView alloc] init];
    self.payView.backgroundColor = WhiteColor;
    [self addSubview:self.payView];
    /** 支付方式 */
    self.payType = [[UILabel alloc] init];
    self.payType.font = TwelveTypeface;
    self.payType.textColor = GrayH1;
    [self.payView addSubview:self.payType];
    /** 合计 */
    self.orderTotalLabel = [[UILabel alloc] init];
    self.orderTotalLabel.text = @"合计：";
    self.orderTotalLabel.font = TwelveTypeface;
    self.orderTotalLabel.textColor = Black;
    [self.payView addSubview:self.orderTotalLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 服务商 */
    [self.serviceProviderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 服务类型 */
    [self.serviceTypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.serviceProviderView.mas_centerY);
        make.left.equalTo(self.serviceProviderView.mas_left).offset(16);
    }];
    /** 服务商 */
    [self.serviceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.serviceProviderView.mas_centerY);
        make.left.equalTo(self.serviceTypeImage.mas_right).offset(10);
    }];
    /** 订单状态 */
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.serviceProviderView.mas_centerY);
        make.right.equalTo(self.serviceProviderView.mas_right).offset(-16);
    }];
    /** 订单 */
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serviceProviderView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.orderPriceLabel.mas_bottom).offset(16);
    }];
    /** 订单名称 */
    [self.orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderView.mas_top).offset(16);
        make.left.equalTo(self.orderView.mas_left).offset(16);
    }];
    /** 订单时间 */
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.orderNameLabel.mas_centerY);
        make.right.equalTo(self.orderView.mas_right).offset(-16);
    }];
    /** 用户车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderNameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.orderNameLabel.mas_left);
    }];
    /** 用户手机号 */
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.left.equalTo(self.plnLabel.mas_right).offset(10);
    }];
    /** 订单次数 */
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.right.equalTo(self.orderTimeLabel.mas_right);
    }];
    /** 订单价格 */
    [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderNumLabel.mas_bottom).offset(10);
        make.right.equalTo(self.orderTimeLabel.mas_right);
    }];
    /** 支付信息view */
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@35);
    }];
    /** 合计 */
    [self.orderTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.payView.mas_centerY);
        make.right.equalTo(self.orderTimeLabel.mas_right);
    }];
    /** 支付方式 */
    [self.payType mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.orderTotalLabel.mas_centerY);
        make.right.equalTo(self.orderTotalLabel.mas_left).offset(-10);
    }];
}

@end
