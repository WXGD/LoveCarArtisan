//
//  CommodityShowStyleCell.m
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommodityShowStyleCell.h"
#import "TwoWordsLabel.h"

@interface CommodityShowStyleCell ()

/** 商品view */
@property (strong, nonatomic) UIView *commodityView;
/** 商品名称 */
@property (strong, nonatomic) UILabel *commodityNameLabel;
/** 商品原价 */
@property (strong, nonatomic) TwoWordsLabel *commodityOriginalPriceLable;
/** 商品现价 */
@property (strong, nonatomic) TwoWordsLabel *commodityPresentPriceLabel;

@end

@implementation CommodityShowStyleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** 商品view */
        self.commodityView = [[UIView alloc] init];
        self.commodityView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.commodityView];
        /** 商品名称 */
        self.commodityNameLabel = [[UILabel alloc] init];
        self.commodityNameLabel.font = FifteenTypeface;
        self.commodityNameLabel.textColor = Black;
        [self.commodityView addSubview:self.commodityNameLabel];
        /** 商品原价 */
        self.commodityOriginalPriceLable = [[TwoWordsLabel alloc] init];
        self.commodityOriginalPriceLable.twoWordsShowStyle = TextHorizontalLayoutAndSuperCenter;
        self.commodityOriginalPriceLable.mainLabel.text = @"原价:";
        self.commodityOriginalPriceLable.mainLabel.font = ThirteenTypeface;
        self.commodityOriginalPriceLable.mainLabel.textColor = GrayH1;
        self.commodityOriginalPriceLable.viceLabel.font = ThirteenTypeface;
        self.commodityOriginalPriceLable.viceLabel.textColor = GrayH1;
        [self.commodityView addSubview:self.commodityOriginalPriceLable];
        /** 商品现价 */
        self.commodityPresentPriceLabel = [[TwoWordsLabel alloc] init];
        self.commodityPresentPriceLabel.twoWordsShowStyle = TextHorizontalLayoutAndSuperCenter;
        self.commodityPresentPriceLabel.mainLabel.text = @"售价:";
        self.commodityPresentPriceLabel.mainLabel.font = ThirteenTypeface;
        self.commodityPresentPriceLabel.mainLabel.textColor = GrayH1;
        self.commodityPresentPriceLabel.viceLabel.font = ThirteenTypeface;
        self.commodityPresentPriceLabel.viceLabel.textColor = RedColor;
        [self.commodityView addSubview:self.commodityPresentPriceLabel];
        
        /** 上架 */
        self.shelvesBtn = [[CommodityOperationBtn alloc] init];
        [self.shelvesBtn setTitle:@"上架" forState:UIControlStateNormal];
        [self.shelvesBtn setTitleColor:BlueColor forState:UIControlStateNormal];
        [self.shelvesBtn setImage:[UIImage imageNamed:@"service_shelves"] forState:UIControlStateNormal];
//        self.shelvesBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 20, 0, 0);
//        self.shelvesBtn.titleEdgeInsets = UIEdgeInsetsMake(20, -12, 0, 0);
        self.shelvesBtn.titleLabel.font = TwelveTypeface;
        self.shelvesBtn.backgroundColor = VCBackgroundThree;
        [self.commodityView addSubview:self.shelvesBtn];
        [self.shelvesBtn setHidden:YES];

        /** 下架 */
        self.theShelfBtn = [[CommodityOperationBtn alloc] init];
        [self.theShelfBtn setTitle:@"下架" forState:UIControlStateNormal];
        [self.theShelfBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        [self.theShelfBtn setImage:[UIImage imageNamed:@"service_the_shelf"] forState:UIControlStateNormal];
//        self.theShelfBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 20, 0, 0);
//        self.theShelfBtn.titleEdgeInsets = UIEdgeInsetsMake(20, -12, 0, 0);
        self.theShelfBtn.titleLabel.font = TwelveTypeface;
        self.theShelfBtn.backgroundColor = VCBackgroundThree;
        [self.commodityView addSubview:self.theShelfBtn];
    }
    return self;
}

- (void)setCommodityShowModel:(CommodityShowStyleModel *)commodityShowModel {
    _commodityShowModel = commodityShowModel;
    /** 商品名称 */
    self.commodityNameLabel.text = commodityShowModel.name;
    /** 商品原价 */
    self.commodityOriginalPriceLable.viceLabel.text = [NSString stringWithFormat:@"%.2f元", commodityShowModel.price];
    /** 商品现价 */
    self.commodityPresentPriceLabel.viceLabel.text = [NSString stringWithFormat:@"%.2f元", commodityShowModel.sale_price];
    // 商品状态 0-下架 1-在售
    if (commodityShowModel.status == 0) {
        /** 商品名称 */
        self.commodityNameLabel.textColor = GrayH1;
        /** 商品现价 */
        self.commodityPresentPriceLabel.viceLabel.textColor = GrayH1;
        /** 上架 */
        [self.shelvesBtn setHidden:NO];
        /** 下架 */
        [self.theShelfBtn setHidden:YES];
    }else if (commodityShowModel.status == 1) {
        /** 商品名称 */
        self.commodityNameLabel.textColor = Black;
        /** 商品现价 */
        self.commodityPresentPriceLabel.viceLabel.textColor = RedColor;
        /** 上架 */
        [self.shelvesBtn setHidden:YES];
        /** 下架 */
        [self.theShelfBtn setHidden:NO];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 商品view */
    [self.commodityView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.top.equalTo(self.contentView.mas_top).offset(0.5);
    }];
    /** 商品名称 */
    [self.commodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.commodityView.mas_centerY).offset(-5);
        make.left.equalTo(self.commodityView.mas_left).offset(16);
    }];
    /** 商品原价 */
    [self.commodityOriginalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.commodityNameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.commodityNameLabel.mas_left);
        make.right.equalTo(self.commodityOriginalPriceLable.viceLabel.mas_right);
        make.bottom.equalTo(self.commodityOriginalPriceLable.viceLabel.mas_bottom);
    }];
    /** 商品现价 */
    [self.commodityPresentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.commodityView.mas_left).offset(135);
        make.centerY.equalTo(self.commodityOriginalPriceLable.mas_centerY);
        make.right.equalTo(self.commodityPresentPriceLabel.viceLabel.mas_right);
        make.bottom.equalTo(self.commodityPresentPriceLabel.viceLabel.mas_bottom);
    }];
    
    /** 上架 */
    [self.shelvesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.commodityView.mas_top);
        make.bottom.equalTo(self.commodityView.mas_bottom);
        make.right.equalTo(self.commodityView.mas_right);
        make.width.mas_equalTo(@60);
    }];
    /** 下架 */
    [self.theShelfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.commodityView.mas_top);
        make.bottom.equalTo(self.commodityView.mas_bottom);
        make.right.equalTo(self.commodityView.mas_right);
        make.width.mas_equalTo(@60);
    }];
}


@end

