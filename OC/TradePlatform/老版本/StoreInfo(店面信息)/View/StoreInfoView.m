//
//  StoreInfoView.m
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StoreInfoView.h"

@interface StoreInfoView ()

@end

@implementation StoreInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self storeInfoLayoutView];
    }
    return self;
}

- (void)storeInfoLayoutView {
    /** 门头图片 */
    self.storeBigImageView = [[UsedCellView alloc] init];
    self.storeBigImageView.usedCellTypeChoice = DescribeImageHorizontalLayout;
    self.storeBigImageView.cellImage.image = [UIImage imageNamed:@"about_us"];
    self.storeBigImageView.isCellImageSize = YES;
    self.storeBigImageView.cellImageSize = CGSizeMake(100, 50);
    self.storeBigImageView.describeImageSize = CGSizeMake(70, 35);
    self.storeBigImageView.describeImage.layer.masksToBounds = YES;
    self.storeBigImageView.describeImage.layer.cornerRadius = 5;
    self.storeBigImageView.cellLabel.text = @"门头图片";
    self.storeBigImageView.cellLabel.font = FifteenTypeface;
    self.storeBigImageView.isSplistLine = YES;
    self.storeBigImageView.isCellImage = YES;
    self.storeBigImageView.usedCellBtn.tag = StoreInfoBigImageBtnAction;
    [self addSubview:self.storeBigImageView];
    /** 名称 */
    self.storeNameView = [[UsedCellView alloc] init];
    self.storeNameView.cellImage.image = [UIImage imageNamed:@"about_us"];
    self.storeNameView.cellLabel.text = @"名称";
    self.storeNameView.cellLabel.font = FifteenTypeface;
    self.storeNameView.describeLabel.font = FourteenTypeface;
    self.storeNameView.describeLabel.textColor = GrayH1;
    self.storeNameView.isCellImage = YES;
    self.storeNameView.usedCellBtn.tag = StoreInfoNameBtnAction;
    [self addSubview:self.storeNameView];
    /** 电话 */
    self.storePhoneView = [[UsedCellView alloc] init];
    self.storePhoneView.cellImage.image = [UIImage imageNamed:@"about_us"];
    self.storePhoneView.cellLabel.text = @"电话";
    self.storePhoneView.cellLabel.font = FifteenTypeface;
    self.storePhoneView.describeLabel.font = FourteenTypeface;
    self.storePhoneView.describeLabel.textColor = GrayH1;
    self.storePhoneView.isCellImage = YES;
    self.storePhoneView.usedCellBtn.tag = StoreInfoPhoneBtnAction;
    [self addSubview:self.storePhoneView];
    /** 地址 */
    self.storeAddressView = [[UsedCellView alloc] init];
    self.storeAddressView.cellImage.image = [UIImage imageNamed:@"about_us"];
    self.storeAddressView.cellLabel.text = @"地址";
    self.storeAddressView.cellLabel.font = FifteenTypeface;
    self.storeAddressView.describeLabel.font = FourteenTypeface;
    self.storeAddressView.describeLabel.textColor = GrayH1;
    self.storeAddressView.describeLabel.text = @"便捷管理";
    self.storeAddressView.isSplistLine = YES;
    self.storeAddressView.isCellImage = YES;
    self.storeAddressView.usedCellBtn.tag = StoreInfoAddressBtnAction;
    [self addSubview:self.storeAddressView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 门头图片 */
    [self.storeBigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(@60);
    }];
    /** 名称 */
    [self.storeNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.storeBigImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 电话 */
    [self.storePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.storeNameView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 地址 */
    [self.storeAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.storePhoneView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
}

@end
