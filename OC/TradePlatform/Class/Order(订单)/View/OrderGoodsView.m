//
//  OrderGoodsView.m
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderGoodsView.h"

@interface OrderGoodsView ()

/** 商品类别名称 */
@property (nonatomic, strong) UILabel *goodsClassNameLabel;

@end

@implementation OrderGoodsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self orderGoodsLayoutView];
    }
    return self;
}

- (void)setGoodsClassName:(NSString *)goodsClassName {
    _goodsClassName = goodsClassName;
    self.goodsClassNameLabel.text = goodsClassName;
    if (goodsClassName.length == 0) {
        [self layoutSubviews];
        
//        // 告诉self.view约束需要更新
//        [self setNeedsUpdateConstraints];
//        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
//        [self updateConstraintsIfNeeded];
//        [self layoutIfNeeded];
    }
}

#pragma mark - 更新布局
//-(void)updateConstraints {
//    /** 商品名称 */
//    @weakify(self)
//    [self.goodsNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.top.equalTo(self.mas_top).offset(10);
//        make.left.equalTo(self.goodsClassNameLabel.mas_right);
//    }];
//    [super updateConstraints];
//}



#pragma mark - view布局
- (void)orderGoodsLayoutView {
    /** 商品类别名称 */
    self.goodsClassNameLabel = [[UILabel alloc] init];
    self.goodsClassNameLabel.textColor = GrayH1;
    self.goodsClassNameLabel.font = TwelveTypeface;
    [self addSubview:self.goodsClassNameLabel];
    /** 商品名称 */
    self.goodsNameLabel = [[UILabel alloc] init];
    self.goodsNameLabel.textColor = Black;
    self.goodsNameLabel.font = TwelveTypeface;
    [self addSubview:self.goodsNameLabel];
    /** 商品数量 */
    self.goodsNumLabel = [[UILabel alloc] init];
    self.goodsNumLabel.textColor = GrayH2;
    self.goodsNumLabel.font = TwelveTypeface;
    [self addSubview:self.goodsNumLabel];
    /** 商品价格 */
    self.goodsPriceLabel = [[UILabel alloc] init];
    self.goodsPriceLabel.textColor = GrayH1;
    self.goodsPriceLabel.font = TwelveTypeface;
    [self addSubview:self.goodsPriceLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 商品类别名称 */
    [self.goodsClassNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.goodsNameLabel.mas_centerY);
        make.left.equalTo(self.mas_left);
    }];
    if (self.goodsClassName.length == 0) {
        /** 商品名称 */
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.goodsClassNameLabel.mas_right);
        }];
    }else {
        /** 商品名称 */
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.goodsClassNameLabel.mas_right).offset(10);
        }];
    }
    /** 商品数量 */
    [self.goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.goodsNameLabel.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** 商品价格 */
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.goodsNameLabel.mas_centerY);
        make.right.equalTo(self.mas_right);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.goodsNameLabel.mas_bottom);
    }];
}

@end
