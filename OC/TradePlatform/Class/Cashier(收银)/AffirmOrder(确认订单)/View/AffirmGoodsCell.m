//
//  AffirmGoodsCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AffirmGoodsCell.h"

@interface AffirmGoodsCell ()

/** 商品名称 */
@property (strong, nonatomic) UILabel *goodsNameLabel;
/** 商品单价 */
@property (strong, nonatomic) UILabel *goodsUnitPriceLabel;
/** 商品数量 */
@property (strong, nonatomic) UILabel *goodsNumLabel;
/** 商品总价 */
@property (strong, nonatomic) UILabel *goodsTotalLabel;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation AffirmGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self affirmGoodsCellLayoutView];
    }
    return self;
}

- (void)affirmGoodsCellLayoutView {
    /** 商品名称 */
    self.goodsNameLabel = [[UILabel alloc] init];
    self.goodsNameLabel.font = FourteenTypeface;
    self.goodsNameLabel.textColor = Black;
    [self.contentView addSubview:self.goodsNameLabel];
    /** 商品单价 */
    self.goodsUnitPriceLabel = [[UILabel alloc] init];
    self.goodsUnitPriceLabel.font = TwelveTypeface;
    self.goodsUnitPriceLabel.textColor = GrayH1;
    [self.contentView addSubview:self.goodsUnitPriceLabel];
    /** 商品数量 */
    self.goodsNumLabel = [[UILabel alloc] init];
    self.goodsNumLabel.font = TwelveTypeface;
    self.goodsNumLabel.textColor = GrayH1;
    [self.contentView addSubview:self.goodsNumLabel];
    /** 商品总价 */
    self.goodsTotalLabel = [[UILabel alloc] init];
    self.goodsTotalLabel.font = TwelveTypeface;
    self.goodsTotalLabel.textColor = GrayH1;
    [self.contentView addSubview:self.goodsTotalLabel];
    /** 分割线 */
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = DividingLine;
    [self.contentView addSubview:self.lineView];
}

/** 购物车商品模型 */
- (void)setShoppingCartModel:(ShoppingCartModel *)shoppingCartModel {
    _shoppingCartModel = shoppingCartModel;
    /** 商品名称 */
    self.goodsNameLabel.text = shoppingCartModel.goods.goods_name;
    /** 商品单价 */
    self.goodsUnitPriceLabel.text = [NSString stringWithFormat:@"%.2f元", shoppingCartModel.goods.actual_sale_price];
    /** 商品数量 */
    self.goodsNumLabel.text = [NSString stringWithFormat:@"x%ld", shoppingCartModel.buy_num];
    /** 商品总价 */
    self.goodsTotalLabel.text = [NSString stringWithFormat:@"%.2f元", shoppingCartModel.goods.actual_sale_price * shoppingCartModel.buy_num];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 商品名称 */
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.top.equalTo(self.contentView.mas_top).offset(16);
    }];
    /** 商品数量 */
    [self.goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.centerY.equalTo(self.goodsNameLabel.mas_centerY);
    }];
    /** 商品单价 */
    [self.goodsUnitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.goodsNumLabel.mas_left).offset(-16);
        make.centerY.equalTo(self.goodsNameLabel.mas_centerY);
    }];
    /** 商品总价 */
    [self.goodsTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.goodsNameLabel.mas_left);
        make.top.equalTo(self.goodsUnitPriceLabel.mas_bottom).offset(16);
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
}

@end
