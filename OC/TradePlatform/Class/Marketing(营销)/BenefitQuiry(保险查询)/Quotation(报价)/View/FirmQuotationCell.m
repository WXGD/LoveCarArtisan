//
//  FirmQuotationCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FirmQuotationCell.h"


@interface FirmQuotationCell ()

/** 保险公司logo */
@property (strong, nonatomic) UIImageView *firmLogoImg;
/** 可选标记 */
@property (strong, nonatomic) UIImageView *optionalSign;
/** 公司报价 */
@property (strong, nonatomic) UILabel *firmQuotationLabel;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation FirmQuotationCell
-(void)setInsuranceQuoteModel:(InsuranceQuoteModel *)insuranceQuoteModel{
    _insuranceQuoteModel = insuranceQuoteModel;
    [self.firmLogoImg setImageWithImageUrl:insuranceQuoteModel.insurance_company_icon perchImage:@"company_icon"];
    self.firmQuotationLabel.text = [NSString stringWithFormat:@"%.2f",insuranceQuoteModel.actual_total_price];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = WhiteColor;
        /** 保险公司logo */
        self.firmLogoImg = [[UIImageView alloc] init];
        self.firmLogoImg.image = [UIImage imageNamed:@"benefit_ping_an"];
        [self.contentView addSubview:self.firmLogoImg];
        /** 可选标记 */
        self.optionalSign = [[UIImageView alloc] init];
        self.optionalSign.image = [UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:self.optionalSign];
        /** 公司报价 */
        self.firmQuotationLabel = [[UILabel alloc] init];
        self.firmQuotationLabel.text = @"公司报价";
        self.firmQuotationLabel.textColor = ThemeColor;
        self.firmQuotationLabel.font = FourteenTypeface;
        [self.contentView addSubview:self.firmQuotationLabel];
        /** 分割线 */
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = DividingLine;
        [self.contentView addSubview:self.lineView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 保险公司logo */
    [self.firmLogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(77, 32));
    }];
    /** 可选标记 */
    [self.optionalSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    /** 公司报价 */
    [self.firmQuotationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.optionalSign.mas_left).offset(-16);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
}

@end
