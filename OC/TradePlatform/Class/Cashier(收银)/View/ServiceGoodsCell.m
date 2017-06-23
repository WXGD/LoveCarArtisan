//
//  ServiceGoodsCell.m
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServiceGoodsCell.h"

@interface ServiceGoodsCell ()

/** 背景view */
@property (strong, nonatomic) UIView  *serviceBackView;
/** 分割线 */
@property (strong, nonatomic) UIView  *dividingLineView;

@end

@implementation ServiceGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 背景view */
        self.serviceBackView = [[UIView alloc] init];
        self.serviceBackView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.serviceBackView];
        /** 服务，商品，师傅名称 */
        self.serviceNameLabel = [[UILabel alloc] init];
        self.serviceNameLabel.textColor = Black;
        self.serviceNameLabel.font = FourteenTypeface;
        [self.serviceBackView addSubview:self.serviceNameLabel];
        /** 分割线 */
        self.dividingLineView = [[UIView alloc] init];
        self.dividingLineView.backgroundColor = HEXSTR_RGB(@"e5e5e5");
        [self.serviceBackView addSubview:self.dividingLineView];
    }
    return self;
}
/** 商品数据模型 */
- (void)setCommodityModel:(CommodityShowStyleModel *)commodityModel {
    _commodityModel = commodityModel;
    /** 服务，商品，师傅名称 */
    self.serviceNameLabel.text = commodityModel.name;
    // 判断是否选中
    if (commodityModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
}

/** 服务数据模型 */
- (void)setServiceModel:(ServiceProviderModel *)serviceModel {
    _serviceModel = serviceModel;
    /** 服务，商品，师傅名称 */
    self.serviceNameLabel.text = serviceModel.name;
    // 判断是否选中
    if (serviceModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
}
/** 服务师傅模型 */
- (void)setServiceMasterModel:(MerchantInfoModel *)serviceMasterModel {
    _serviceMasterModel = serviceMasterModel;
    /** 服务，商品，师傅名称 */
    self.serviceNameLabel.text = serviceMasterModel.user_name;
    // 判断是否选中
    if (serviceMasterModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
}
/** 会员卡类型模型 */
- (void)setCardTypeModel:(CardTypeModel *)cardTypeModel {
    /** 服务，商品，师傅名称 */
    self.serviceNameLabel.text = [NSString stringWithFormat:@"%@(%ld)", cardTypeModel.name, cardTypeModel.count];
    // 判断是否选中
    if (cardTypeModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
}



/** 车况 */
- (void)setCarConditionModel:(CarConditionModel *)carConditionModel {
    _carConditionModel = carConditionModel;
    /** 服务，商品，师傅名称 */
    self.serviceNameLabel.text = carConditionModel.car_condition_name;
    // 判断是否选中
    if (carConditionModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
}
/** 车辆用途 */
- (void)setCarUseModel:(CarUseModel *)carUseModel {
    _carUseModel = carUseModel;
    /** 服务，商品，师傅名称 */
    self.serviceNameLabel.text = carUseModel.purpose_name;
    // 判断是否选中
    if (carUseModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
}
/** 订单支付状态 */
- (void)setOrderPayStateModel:(OrderPayStateModel *)orderPayStateModel {
    _orderPayStateModel = orderPayStateModel;
    /** 服务，商品，师傅名称 */
    self.serviceNameLabel.text = orderPayStateModel.chioceCategoriesName;
    // 判断是否选中
    if (orderPayStateModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
}
/** 用户筛选区间 */
- (void)setExpireModel:(ExpireModel *)expireModel {
    _expireModel = expireModel;
    // 判断是否选中
    if (expireModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
    /** 用户筛选区间 */
    // 判断是不是自定义
    if ([expireModel.max_value isEqualToString:@"自定义"]) {
        self.serviceNameLabel.text = @"自定义";
        self.serviceNameLabel.textColor = Black;
    }else {
        if ([expireModel.max_value doubleValue] == 0) {
            self.serviceNameLabel.text = [NSString stringWithFormat:@"%@%@~最大值", expireModel.min_value, expireModel.unit];
        }else {
            self.serviceNameLabel.text = [NSString stringWithFormat:@"%@%@~%@%@", expireModel.min_value, expireModel.unit, expireModel.max_value, expireModel.unit];
        }
    }
};
/** 优惠劵类型模型 */
- (void)setCouponTypeModel:(CouponGoverModel *)couponTypeModel {
    _couponTypeModel = couponTypeModel;
    /** 优惠劵 */
    self.serviceNameLabel.text = [NSString stringWithFormat:@"%@", couponTypeModel.name];
    // 判断是否选中
    if (couponTypeModel.checkMark) {
        self.serviceNameLabel.textColor = ThemeColor;
    }else {
        self.serviceNameLabel.textColor = Black;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [self.serviceBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    /** 服务，商品，师傅名称 */
    [self.serviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.serviceBackView.mas_centerX);
        make.centerY.equalTo(self.serviceBackView.mas_centerY);
    }];
    /** 分割线 */
    [self.dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.height.mas_equalTo(@0.5);
        make.right.equalTo(self.serviceBackView.mas_right);
        make.left.equalTo(self.serviceBackView.mas_left);
        make.bottom.equalTo(self.serviceBackView.mas_bottom);
    }];
}


@end
