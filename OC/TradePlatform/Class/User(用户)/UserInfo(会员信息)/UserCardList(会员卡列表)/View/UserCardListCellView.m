//
//  UserCardListCellView.m
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardListCellView.h"

@interface UserCardListCellView ()

/** 横向分割线 */
@property (strong, nonatomic) UIView *dividingLineH;
/** 纵向分割线 */
@property (strong, nonatomic) UIView *dividingLineV;

@end

@implementation UserCardListCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self userCardListCellLayoutView];
    }
    return self;
}

- (void)userCardListCellLayoutView {
    /** 卡背景图片 */
    self.cardBackImage = [[UIImageView alloc] init];
    self.cardBackImage.image = [UIImage imageNamed:@"card_back"];
    self.cardBackImage.userInteractionEnabled = YES;
    [self addSubview:self.cardBackImage];
    /** 卡类型 */
    self.cardTypeImage = [[UIImageView alloc] init];
    self.cardTypeImage.image = [UIImage imageNamed:@"user_card_logo_available"];
    [self.cardBackImage addSubview:self.cardTypeImage];
    
    self.cardType = [[UILabel alloc] init];
    self.cardType.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    self.cardType.textColor = Black;
    self.cardType.text = @"卡类型";
    [self.cardBackImage addSubview:self.cardType];
    /** 卡号 */
    self.cardNumberLabel = [[UILabel alloc] init];
    self.cardNumberLabel.font = FourteenTypeface;
    self.cardNumberLabel.textColor = Black;
    self.cardNumberLabel.text = @"卡号";
    [self.cardBackImage addSubview:self.cardNumberLabel];
    
    /** 可用服务标题 */
    self.availableServiceTitle = [[UILabel alloc] init];
    self.availableServiceTitle.font = TwelveTypeface;
    self.availableServiceTitle.textColor = HEXSTR_RGB(@"9a9a9a");
    self.availableServiceTitle.text = @"可用服务：";
    [self.cardBackImage addSubview:self.availableServiceTitle];
    /** 可用服务内容 */
    self.availableServiceContent = [[UILabel alloc] init];
    self.availableServiceContent.font = TwelveTypeface;
    self.availableServiceContent.textColor = Black;
    self.availableServiceContent.numberOfLines = 0;
    [self.cardBackImage addSubview:self.availableServiceContent];
    /** 可用服务尖头 */
    self.availableServiceArraw = [[UIImageView alloc] init];
    self.availableServiceArraw.image = [UIImage imageNamed:@"card_bottom_arrow"];
    [self.cardBackImage addSubview:self.availableServiceArraw];
    [self.availableServiceArraw setHidden:YES];

    /** 余额标题 */
    self.balanceTitle = [[UILabel alloc] init];
    self.balanceTitle.font = FourteenTypeface;
    self.balanceTitle.textColor = HEXSTR_RGB(@"9a9a9a");
    self.balanceTitle.text = @"余额：";
    [self.cardBackImage addSubview:self.balanceTitle];
    /** 余额 */
    self.balance = [[UILabel alloc] init];
    self.balance.font = FourteenTypeface;
    self.balance.textColor = Black;
    self.balance.text = @"余额：";
    [self.cardBackImage addSubview:self.balance];
    /** 有效期标题 */
    self.expiryDateTitle = [[UILabel alloc] init];
    self.expiryDateTitle.font = FourteenTypeface;
    self.expiryDateTitle.textColor = HEXSTR_RGB(@"9a9a9a");
    self.expiryDateTitle.text = @"有效期至：";
    [self.cardBackImage addSubview:self.expiryDateTitle];
    /** 有效期 */
    self.expiryDate = [[UILabel alloc] init];
    self.expiryDate.font = FourteenTypeface;
    self.expiryDate.textColor = Black;
    self.expiryDate.text = @"有效期至：";
    [self.cardBackImage addSubview:self.expiryDate];
    /** 横向分割线 */
    self.dividingLineH = [[UIView alloc] init];
    self.dividingLineH.backgroundColor = DividingLine;
    [self.cardBackImage addSubview:self.dividingLineH];
    /** 编辑 */
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:Black forState:UIControlStateNormal];
    [self.cardBackImage addSubview:self.editBtn];
    /** 纵向分割线 */
    self.dividingLineV = [[UIView alloc] init];
    self.dividingLineV.backgroundColor = DividingLine;
    [self.cardBackImage addSubview:self.dividingLineV];
    /** 充值 */
    self.rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [self.rechargeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [self.cardBackImage addSubview:self.rechargeBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡背景图片 */
    [self.cardBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 卡类型 */
    [self.cardTypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardBackImage.mas_top).offset(20);
        make.left.equalTo(self.cardBackImage.mas_left).offset(16);
    }];
    [self.cardType mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cardTypeImage.mas_centerY);
        make.left.equalTo(self.cardTypeImage.mas_right).offset(7);
    }];
    /** 卡号 */
    [self.cardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cardTypeImage.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-17);
    }];
    /** 可用服务标题 */
    [self.availableServiceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardTypeImage.mas_bottom).offset(35);
        make.left.equalTo(self.cardBackImage.mas_left).offset(17);
    }];
    /** 可用服务尖头 */
    [self.availableServiceArraw mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.availableServiceTitle.mas_bottom).offset(8);
        make.right.equalTo(self.cardBackImage.mas_right).offset(-17);
    }];
    /** 可用服务内容 */
    [self.availableServiceContent mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.availableServiceTitle.mas_bottom).offset(8);
        make.left.equalTo(self.availableServiceTitle.mas_left);
        make.right.equalTo(self.cardBackImage.mas_right).offset(-38);
    }];
    /** 余额标题 */
    [self.balanceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.availableServiceContent.mas_bottom).offset(35);
        make.left.equalTo(self.availableServiceTitle.mas_left);
    }];
    /** 余额 */
    [self.balance mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.balanceTitle.mas_centerY);
        make.left.equalTo(self.balanceTitle.mas_right).offset(10);
    }];
    /** 有效期 */
    [self.expiryDate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.balanceTitle.mas_centerY);
        make.right.equalTo(self.cardBackImage.mas_right).offset(-17);
    }];
    /** 有效期标题 */
    [self.expiryDateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.balanceTitle.mas_centerY);
        make.right.equalTo(self.expiryDate.mas_left).offset(-10);
    }];
    /** 横向分割线 */
    [self.dividingLineH mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.balance.mas_bottom).offset(20);
        make.left.equalTo(self.cardBackImage.mas_left).offset(5);
        make.right.equalTo(self.cardBackImage.mas_right).offset(-5);
        make.height.mas_equalTo(@0.5);
    }];
    /** 纵向分割线 */
    [self.dividingLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineH.mas_bottom).offset(9);
        make.centerX.equalTo(self.cardBackImage.mas_centerX);
        make.width.mas_equalTo(@0.5);
        make.height.mas_equalTo(@15);
    }];
    /** 编辑 */
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineH.mas_bottom);
        make.right.equalTo(self.cardBackImage.mas_right);
        make.left.equalTo(self.dividingLineV.mas_right);
    }];
    /** 充值 */
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineH.mas_bottom);
        make.left.equalTo(self.cardBackImage.mas_left);
        make.right.equalTo(self.dividingLineV.mas_left);
    }];
}


@end
