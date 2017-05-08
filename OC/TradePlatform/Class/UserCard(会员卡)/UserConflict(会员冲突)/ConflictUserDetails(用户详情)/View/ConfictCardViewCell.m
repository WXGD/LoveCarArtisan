//
//  ConfictCardViewCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConfictCardViewCell.h"

@interface ConfictCardViewCell ()

/** 可用服务标题 */
@property (strong, nonatomic) UILabel *availableServiceTitle;
/** 余额标题 */
@property (strong, nonatomic) UILabel *balanceTitle;
/** 有效期标题 */
@property (strong, nonatomic) UILabel *expiryDateTitle;
/** 分割线 */
@property (strong, nonatomic) UIView *dividingLineView;

/** 卡类型 */
@property (strong, nonatomic) UILabel *cardType;
/** 卡号 */
@property (strong, nonatomic) UILabel *cardNumberLabel;
/** 可用服务内容 */
@property (strong, nonatomic) UILabel *availableServiceContent;
/** 余额 */
@property (strong, nonatomic) UILabel *balance;
/** 有效期 */
@property (strong, nonatomic) UILabel *expiryDate;

@end

@implementation ConfictCardViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self confictCardCellLayoutView];
    }
    return self;
}

- (void)confictCardCellLayoutView {
    /** 卡类型 */
    self.cardType = [[UILabel alloc] init];
    self.cardType.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.cardType.textColor = Black;
    [self.contentView addSubview:self.cardType];
    /** 卡号 */
    self.cardNumberLabel = [[UILabel alloc] init];
    self.cardNumberLabel.font = FourteenTypeface;
    self.cardNumberLabel.textColor = Black;
    [self.contentView addSubview:self.cardNumberLabel];
    /** 可用服务标题 */
    self.availableServiceTitle = [[UILabel alloc] init];
    self.availableServiceTitle.font = TwelveTypeface;
    self.availableServiceTitle.textColor = GrayH2;
    self.availableServiceTitle.text = @"可用服务：";
    [self.contentView addSubview:self.availableServiceTitle];
    /** 可用服务内容 */
    self.availableServiceContent = [[UILabel alloc] init];
    self.availableServiceContent.font = TwelveTypeface;
    self.availableServiceContent.textColor = Black;
    [self.contentView addSubview:self.availableServiceContent];
    /** 余额标题 */
    self.balanceTitle = [[UILabel alloc] init];
    self.balanceTitle.font = TwelveTypeface;
    self.balanceTitle.textColor = GrayH2;
    self.balanceTitle.text = @"余额：";
    [self.contentView addSubview:self.balanceTitle];
    /** 余额 */
    self.balance = [[UILabel alloc] init];
    self.balance.font = TwelveTypeface;
    self.balance.textColor = HEXSTR_RGB(@"e53935");
    [self.contentView addSubview:self.balance];
    /** 有效期标题 */
    self.expiryDateTitle = [[UILabel alloc] init];
    self.expiryDateTitle.font = TwelveTypeface;
    self.expiryDateTitle.textColor = GrayH2;
    self.expiryDateTitle.text = @"有效期至：";
    [self.contentView addSubview:self.expiryDateTitle];
    /** 有效期 */
    self.expiryDate = [[UILabel alloc] init];
    self.expiryDate.font = TwelveTypeface;
    self.expiryDate.textColor = Black;
    [self.contentView addSubview:self.expiryDate];
    /** 分割线 */
    self.dividingLineView = [[UIView alloc] init];
    self.dividingLineView.backgroundColor = DividingLine;
    [self.contentView addSubview:self.dividingLineView];
}


- (void)setConfictCardModel:(UserMemberCardModel *)confictCardModel {
    _confictCardModel = confictCardModel;
    /** 卡类型 */
    self.cardType.text = confictCardModel.name;
    /** 卡号 */
    self.cardNumberLabel.text = confictCardModel.card_no;
    /** 可用服务内容 */
    self.availableServiceContent.text = confictCardModel.used_goods_text;
    /** 余额 */
    // 判断是次卡还是储值卡
    if (confictCardModel.card_category_id == 1) { // 次卡
        /** 余次 */
        self.balanceTitle.text = @"余次：";
        self.balance.text = [NSString stringWithFormat:@"%ld次", (long)confictCardModel.num];
    }else if (confictCardModel.card_category_id == 2) { // 金额卡
        /** 余额 */
        self.balanceTitle.text = @"余额：";
        self.balance.text = [NSString stringWithFormat:@"%.2f元", confictCardModel.money];
    }else if (confictCardModel.card_category_id == 3) { // 年卡
        /** 余次 */
        self.balanceTitle.text = @"余次：";
        self.balance.text = @"无限";
    }
    /** 有效期 */
    if (confictCardModel.end_time.length != 0) {
        /** 有效期 */
        self.expiryDate.text = confictCardModel.end_time;
    }else {
        /** 有效期 */
        self.expiryDate.text = @"无限";
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡类型 */
    [self.cardType mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.contentView.mas_left).offset(16);
    }];
    /** 卡号 */
    [self.cardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cardType.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    /** 可用服务标题 */
    [self.availableServiceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardType.mas_bottom).offset(16);
        make.left.equalTo(self.cardType.mas_left);
        make.width.mas_equalTo(@(62));
    }];
    /** 可用服务内容 */
    [self.availableServiceContent mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.availableServiceTitle.mas_centerY);
        make.left.equalTo(self.availableServiceTitle.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];

    /** 有效期标题 */
    [self.expiryDateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.availableServiceTitle.mas_bottom).offset(16);
        make.left.equalTo(self.cardType.mas_left);
    }];
    /** 有效期 */
    [self.expiryDate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.expiryDateTitle.mas_centerY);
        make.left.equalTo(self.expiryDateTitle.mas_right);
    }];
    /** 余额 */
    [self.balance mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.expiryDateTitle.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    /** 余额标题 */
    [self.balanceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.expiryDateTitle.mas_centerY);
        make.right.equalTo(self.balance.mas_left);
    }];
    /** 分割线 */
    [self.dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
}


@end
