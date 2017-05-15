//
//  SelectFirmCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SelectFirmCell.h"

@interface SelectFirmCell ()

/** 保险公司logo */
@property (strong, nonatomic) UIImageView *firmLogoImg;
/** 选中标记 */
@property (strong, nonatomic) UIButton *selectSign;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation SelectFirmCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = WhiteColor;
        /** 保险公司logo */
        self.firmLogoImg = [[UIImageView alloc] init];
        self.firmLogoImg.image = [UIImage imageNamed:@"benefit_ping_an"];
        [self.contentView addSubview:self.firmLogoImg];
        /** 选中标记 */
        self.selectSign = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectSign setImage:[UIImage imageNamed:@"benefit_no_select"] forState:UIControlStateNormal];
        [self.selectSign setImage:[UIImage imageNamed:@"benefit_select"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.selectSign];
        /** 分割线 */
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = DividingLine;
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setFirmModel:(BenefitFirmModel *)firmModel {
    _firmModel = firmModel;
    /** 保险公司logo */
    [self.firmLogoImg setImageWithImageUrl:firmModel.icon_thumb perchImage:@"placeholder_logo"];
    /** 选中标记 */
    self.selectSign.selected = firmModel.checkMark;
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
    /** 选中标记 */
    [self.selectSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right).offset(-16);
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
