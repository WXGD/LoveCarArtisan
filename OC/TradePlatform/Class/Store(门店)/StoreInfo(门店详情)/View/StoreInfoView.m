//
//  StoreInfoView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "StoreInfoView.h"

@implementation StoreInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self storeInfoLayoutView];
    }
    return self;
}

- (void)storeInfoLayoutView {
    self.storeInfoScrollerView = [[UIScrollView alloc] init];
    self.storeInfoScrollerView.showsVerticalScrollIndicator = NO;
    self.storeInfoScrollerView.backgroundColor = VCBackground;
    [self addSubview:self.storeInfoScrollerView];
    
    self.storeInfostackView = [[UIStackView alloc] init];
    self.storeInfostackView.axis = UILayoutConstraintAxisVertical;
    [self.storeInfoScrollerView addSubview:self.storeInfostackView];
    
    self.imageBgView = [[UIView alloc] init];
    [self.storeInfostackView addArrangedSubview:self.imageBgView];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageBgView addSubview:self.imageView];
    /** 店名 */
    self.storeNameView = [[UsedCellView alloc] init];
    self.storeNameView.usedCellBtn.tag = StoreNameBtnAction;
    self.storeNameView.isCellImageSize = YES;
    self.storeNameView.isCellImage = YES;
    self.storeNameView.cellLabel.text = @"店名";
    self.storeNameView.describeLabel.font = FourteenTypeface;
    self.storeNameView.describeLabel.textColor = GrayH1;
    [self.storeInfostackView addArrangedSubview:self.storeNameView];
    /** 客服电话 */
    self.telPhoneView = [[UsedCellView alloc] init];
    self.telPhoneView.usedCellBtn.tag = StoreTelPhoneBtnAction;
    self.telPhoneView.isCellImageSize = YES;
    self.telPhoneView.isCellImage = YES;
    self.telPhoneView.cellLabel.text = @"客服电话";
    self.telPhoneView.describeLabel.font = FourteenTypeface;
    self.telPhoneView.describeLabel.textColor = GrayH1;
    [self.storeInfostackView addArrangedSubview:self.telPhoneView];
    /** 短信 */
    self.messagePhoneView = [[UsedCellView alloc] init];
    self.messagePhoneView.usedCellBtn.tag = StoreMessagePhoneBtnAction;
    self.messagePhoneView.isCellImageSize = YES;
    self.messagePhoneView.isCellImage = YES;
    self.messagePhoneView.cellLabel.text = @"短信通知电话";
    self.messagePhoneView.describeLabel.font = FourteenTypeface;
    self.messagePhoneView.describeLabel.textColor = GrayH1;
    [self.storeInfostackView addArrangedSubview:self.messagePhoneView];
    
    /** 地址 */
    self.addressView = [[UsedCellView alloc] init];
    self.addressView.usedCellBtn.tag = StoreAddressBtnAction;
    self.addressView.isCellImageSize = YES;
    self.addressView.isCellImage = YES;
    self.addressView.cellLabel.text = @"地址";
    [self.storeInfostackView addArrangedSubview:self.addressView];
    /** 具体地址 */
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.textAlignment = NSTextAlignmentRight;
    self.addressLabel.font = FourteenTypeface;
    self.addressLabel.textColor = GrayH1;
    [self.addressView addSubview:self.addressLabel];
    /** 营业时间 */
    self.timeView = [[UsedCellView alloc] init];
    self.timeView.usedCellBtn.tag = StoreTimeBtnAction;
    self.timeView.isCellImageSize = YES;
    self.timeView.isCellImage = YES;
    self.timeView.cellLabel.text = @"营业时间";
    self.timeView.describeLabel.font = FourteenTypeface;
    self.timeView.describeLabel.textColor = GrayH1;
    [self.storeInfostackView addArrangedSubview:self.timeView];
    /** VX */
    self.qrCodeView = [[UsedCellView alloc] init];
    self.qrCodeView.usedCellBtn.tag = StoreQrBtnAction;
    self.qrCodeView.isCellImageSize = YES;
    self.qrCodeView.isCellImage = YES;
//    self.qrCodeView.isArrow = YES;
    self.qrCodeView.cellLabel.text = @"微信公众二维码";
    self.qrCodeView.describeLabel.font = FourteenTypeface;
    self.qrCodeView.describeLabel.textColor = GrayH1;
    [self.storeInfostackView addArrangedSubview:self.qrCodeView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.storeInfoScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.storeInfostackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.storeInfoScrollerView.mas_top);
        make.left.equalTo(self.storeInfoScrollerView.mas_left);
        make.bottom.equalTo(self.storeInfoScrollerView.mas_bottom);
        make.right.equalTo(self.storeInfoScrollerView.mas_right);
        make.width.equalTo(self.storeInfoScrollerView.mas_width);
    }];
    /** 图片bg */
    [self.imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@180);
    }];
    /** 图片bg */
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.imageBgView.mas_top);
        make.left.equalTo(self.imageBgView.mas_left);
        make.bottom.equalTo(self.imageBgView.mas_bottom);
        make.right.equalTo(self.imageBgView.mas_right);
    }];
    /** 店名 */
    [self.storeNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 客服电话 */
    [self.telPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 短信通知电话 */
    [self.messagePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 地址 */
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 具体地址 */
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addressView.mas_left).offset(130);
        make.right.equalTo(self.addressView.mas_right).offset(-45);
        make.centerY.mas_equalTo(self.addressView.cellLabel.centerY);
    }];
    /** 营业时间 */
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 微信公众二维码 */
    [self.qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 填充scrollview的view的高度 */
    [self.storeInfostackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.storeInfoScrollerView.mas_bottom);
    }];
}
@end
