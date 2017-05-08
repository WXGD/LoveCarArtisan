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
/** 订单商品View */
@property (strong, nonatomic) UIView *OrderGoodsView;
/** 支付信息view */
@property (strong, nonatomic) UIView *payView;

@end

@implementation OrderCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self orderCellLayoutView];
        // 添加订单商品
//        [self addOrderGoods];
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
    self.serviceTypeImage.image = [UIImage imageNamed:@"order_service"];
    [self.serviceProviderView addSubview:self.serviceTypeImage];
    /** 服务类型名称 */
    self.serviceTypeLabel = [[UILabel alloc] init];
    self.serviceTypeLabel.font = FourteenTypeface;
    self.serviceTypeLabel.textColor = Black;
    [self.serviceProviderView addSubview:self.serviceTypeLabel];
    /** 订单状态 */
    self.orderStateLabel = [[UILabel alloc] init];
    self.orderStateLabel.font = ThirteenTypeface;
    self.orderStateLabel.textColor = ThemeColor;
    [self.serviceProviderView addSubview:self.orderStateLabel];
    /** 订单信息view */
    self.orderView = [[UIView alloc] init];
    self.orderView.backgroundColor = VCBackgroundThree;
    [self addSubview:self.orderView];
    /** 订单商品View */
    self.OrderGoodsView = [[UIView alloc] init];
    [self addSubview:self.OrderGoodsView];
    /** 订单时间 */
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.font = TwelveTypeface;
    self.orderTimeLabel.textColor = GrayH2;
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
    self.orderTotalLabel.font = TwelveTypeface;
    self.orderTotalLabel.textColor = Black;
    [self.payView addSubview:self.orderTotalLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 服务商 */
    [self.serviceProviderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 服务类型 */
    [self.serviceTypeImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.serviceProviderView.mas_centerY);
        make.left.equalTo(self.serviceProviderView.mas_left).offset(16);
    }];
    /** 服务商 */
    [self.serviceTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.serviceProviderView.mas_centerY);
        make.left.equalTo(self.serviceTypeImage.mas_right).offset(10);
    }];
    /** 订单状态 */
    [self.orderStateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.serviceProviderView.mas_centerY);
        make.right.equalTo(self.serviceProviderView.mas_right).offset(-16);
    }];
    /** 订单 */
    [self.orderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serviceProviderView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.plnLabel.mas_bottom).offset(16);
    }];
    /** 订单商品View */
    [self.OrderGoodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderView.mas_top).offset(6);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@(24.5 * self.orderGoodsNum));
    }];
    /** 用户车牌号 */
    [self.plnLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.OrderGoodsView.mas_bottom).offset(16);
        make.left.equalTo(self.orderView.mas_left).offset(16);
    }];
    /** 用户手机号 */
    [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.left.equalTo(self.plnLabel.mas_right).offset(10);
    }];
    /** 订单时间 */
    [self.orderTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.right.equalTo(self.orderView.mas_right).offset(-16);
    }];
    
    /** 支付信息view */
    [self.payView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@35);
    }];
    /** 合计 */
    [self.orderTotalLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.payView.mas_centerY);
        make.right.equalTo(self.orderTimeLabel.mas_right);
    }];
    /** 支付方式 */
    [self.payType mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.orderTotalLabel.mas_centerY);
        make.right.equalTo(self.orderTotalLabel.mas_left).offset(-16);
    }];
}

#pragma mark - 封装方法
/** 订单商品个数 */
- (void)setOrderGoodsNum:(NSInteger)orderGoodsNum {
    _orderGoodsNum = orderGoodsNum;
    // 移除订单商品View所有子视图
    [self.OrderGoodsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < orderGoodsNum; i++) {
        OrderGoodsView *orderGoods = [[OrderGoodsView alloc] init];
        orderGoods.tag = 1570 + i;
        [self.OrderGoodsView addSubview:orderGoods];
        @weakify(self)
        [orderGoods mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.OrderGoodsView.mas_top).offset(24.5 * i);
            make.left.equalTo(self.OrderGoodsView.mas_left);
            make.right.equalTo(self.OrderGoodsView.mas_right);
        }];
    }
    [self layoutSubviews];
}

@end
