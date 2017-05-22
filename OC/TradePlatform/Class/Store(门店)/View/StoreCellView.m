//
//  StoreCellView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "StoreCellView.h"

@implementation StoreCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self storeCellLayoutView];
        // 添加订单商品
        //        [self addOrderGoods];
    }
    return self;
}

- (void)storeCellLayoutView {
    /** 门店图片 */
    self.storeImage = [[UIImageView alloc] init];
    self.storeImage.image = [UIImage imageNamed:@""];
    [self addSubview:self.storeImage];
    /** 门店名字 */
    self.storeNameLabel = [[UILabel alloc] init];
    self.storeNameLabel.text = @"";
    self.storeNameLabel.font = FifteenTypefaceBold;
    self.storeNameLabel.textColor = Black;
    [self addSubview:self.storeNameLabel];
    /** 门店地址 */
    self.storeAddressLabel = [[UILabel alloc] init];
    self.storeAddressLabel.text = @"";
    self.storeAddressLabel.numberOfLines = 0;
    self.storeAddressLabel.font = TwelveTypeface;
    self.storeAddressLabel.textColor = GrayH2;
    [self addSubview:self.storeAddressLabel];
    /** 箭头图片 */
    self.arrowImage = [[UIImageView alloc] init];
    self.arrowImage.image = [UIImage imageNamed:@"right_arrow"];
    [self addSubview:self.arrowImage];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 图片 */
    [self.storeImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(@80);
        make.width.mas_equalTo(@80);
    }];
    /** 门店名称 */
    [self.storeNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(24);
        make.left.equalTo(self.storeImage.mas_right).offset(16);
        make.right.equalTo(self.mas_right).offset(-32);
        make.height.mas_equalTo(@18);
    }];
    /** 门店地址 */
    [self.storeAddressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.storeNameLabel.mas_bottom).offset(13);
        make.left.equalTo(self.storeImage.mas_right).offset(16);
        make.right.equalTo(self.mas_right).offset(-32);
        make.height.mas_greaterThanOrEqualTo(@0);
        make.height.mas_lessThanOrEqualTo(@55);
    }];
    /** 箭头图片 */
    [self.arrowImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
@end
