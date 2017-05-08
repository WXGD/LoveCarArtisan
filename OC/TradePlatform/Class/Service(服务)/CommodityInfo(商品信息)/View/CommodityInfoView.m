//
//  CommodityInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommodityInfoView.h"

@implementation CommodityInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commodityInfoLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)commodityInfoLayoutView {
    /** 商品名称 */
    self.commodityName = [[UsedCellView alloc] init];
    self.commodityName.cellLabel.text = @"服务名称";
    self.commodityName.cellLabel.font = FifteenTypeface;
    self.commodityName.cellLabel.textColor = Black;
    self.commodityName.describeLabel.font = ThirteenTypeface;
    self.commodityName.describeLabel.textColor = GrayH1;
    self.commodityName.isSplistLine = YES;
    self.commodityName.isCellImage = YES;
    self.commodityName.usedCellBtn.tag = CommodityNameBtnAction;
    [self addSubview:self.commodityName];
    /** 销售价 */
    self.presentPrice = [[UsedCellView alloc] init];
    self.presentPrice.cellLabel.text = @"售价";
    self.presentPrice.cellLabel.font = FifteenTypeface;
    self.presentPrice.cellLabel.textColor = Black;
    self.presentPrice.describeLabel.font = ThirteenTypeface;
    self.presentPrice.describeLabel.textColor = GrayH1;
    self.presentPrice.isSplistLine = YES;
    self.presentPrice.isCellImage = YES;
    self.presentPrice.usedCellBtn.tag = PresentPriceBtnAction;
    [self addSubview:self.presentPrice];
    /** 原价 */
    self.originalPrice = [[UsedCellView alloc] init];
    self.originalPrice.cellLabel.text = @"原价";
    self.originalPrice.cellLabel.font = FifteenTypeface;
    self.originalPrice.cellLabel.textColor = Black;
    self.originalPrice.describeLabel.font = ThirteenTypeface;
    self.originalPrice.describeLabel.textColor = GrayH1;
    self.originalPrice.isSplistLine = YES;
    self.originalPrice.isCellImage = YES;
    self.originalPrice.usedCellBtn.tag = OriginalPriceBtnAction;
    [self addSubview:self.originalPrice];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 商品名称 */
    [self.commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 原价 */
    [self.originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.commodityName.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 销售价 */
    [self.presentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.originalPrice.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
}

@end
