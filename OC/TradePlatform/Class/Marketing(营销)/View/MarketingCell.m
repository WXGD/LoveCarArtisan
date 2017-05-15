//
//  MarketingCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MarketingCell.h"


@interface MarketingCell ()



@end


@implementation MarketingCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self marketingTableCellLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)marketingTableCellLayoutView {
    /** 营销项目logo */
    self.marketingProjectLogo = [[UIImageView alloc] init];
    [self addSubview:self.marketingProjectLogo];
    /** 营销项目名称 */
    self.marketingProjectName = [[UILabel alloc] init];
    self.marketingProjectName.font = SixteenTypeface;
    [self addSubview:self.marketingProjectName];
    /** 营销项目副标题 */
    self.marketingProjectViceTitle = [[UILabel alloc] init];
    self.marketingProjectViceTitle.font = TwelveTypeface;
    self.marketingProjectViceTitle.textColor = GrayH2;
    self.marketingProjectViceTitle.numberOfLines = 0;
    [self addSubview:self.marketingProjectViceTitle];
    /** 营销项目箭头 */
    self.marketingProjectArrowImage = [[UIImageView alloc] init];
    self.marketingProjectArrowImage.image = [UIImage imageNamed:@"right_arrow"];
    [self addSubview:self.marketingProjectArrowImage];
    /** 覆盖按钮 */
    self.marketingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.marketingBtn];
}


//- (void)setMarketingProjectModel:(MarketingProjectModel *)marketingProjectModel {
//    _marketingProjectModel = marketingProjectModel;
//    /** 营销项目logo */
//    self.marketingProjectLogo.image = [UIImage imageNamed:marketingProjectModel.marketing_project_logo];
//    /** 营销项目名称 */
//    self.marketingProjectName.text = marketingProjectModel.marketing_project_name;
//    self.marketingProjectName.textColor = HEXSTR_RGB(marketingProjectModel.marketing_project_name_title_color);
//    /** 营销项目副标题 */
//    self.marketingProjectViceTitle.text = marketingProjectModel.marketing_project_vice_title;
//}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 营销项目logo */
    [self.marketingProjectLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(24);
        make.size.mas_equalTo(CGSizeMake(59, 59));
    }];
    /** 营销项目名称 */
    [self.marketingProjectName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY).offset(-8);
        make.left.equalTo(self.marketingProjectLogo.mas_right).offset(24);
    }];
    /** 营销项目副标题 */
    [self.marketingProjectViceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_centerY).offset(8);
        make.left.equalTo(self.marketingProjectName.mas_left);
        make.right.equalTo(self.mas_right).offset(-42);
    }];
    /** 营销项目箭头 */
    [self.marketingProjectArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    /** 覆盖按钮 */
    [self.marketingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.marketingProjectLogo.mas_bottom).offset(21);
    }];
}


@end
