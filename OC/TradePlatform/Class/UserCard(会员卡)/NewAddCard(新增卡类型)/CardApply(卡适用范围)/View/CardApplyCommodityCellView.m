//
//  CardApplyCommodityCellView.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardApplyCommodityCellView.h"

@implementation CardApplyCommodityCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** 名称 */
        self.cardApplyName = [[UILabel alloc] init];
        self.cardApplyName.text = @"可提现余额(元)";
        self.cardApplyName.textColor = GrayH2;
        self.cardApplyName.font = FifteenTypeface;
        [self.contentView addSubview:self.cardApplyName];
        /** 选中标记 */
        self.commodityChoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.commodityChoiceBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [self.commodityChoiceBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [self.commodityChoiceBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
        [self.contentView addSubview:self.commodityChoiceBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 名称 */
    [self.cardApplyName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    /** 选中标记 */
    [self.commodityChoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
}

@end
