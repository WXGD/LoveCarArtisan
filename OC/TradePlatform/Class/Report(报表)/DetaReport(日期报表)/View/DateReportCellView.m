
//
//  DateReportCellView.m
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DateReportCellView.h"

@interface DateReportCellView ()


@end

@implementation DateReportCellView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self dateReportCellLayoutView];
    }
    return self;
}

- (void)dateReportCellLayoutView {
    /** 日期 */
    self.dateLable = [[UILabel alloc] init];
    self.dateLable.text = @"0000-00-00";
    self.dateLable.font = TwelveTypeface;
    self.dateLable.textColor = Black;
    self.dateLable.textAlignment = NSTextAlignmentCenter;
    self.dateLable.numberOfLines = 0;
    [self addSubview:self.dateLable];
    /** 客户数量 */
    self.customerNmuLable = [[UILabel alloc] init];
    self.customerNmuLable.text = @"0人";
    self.customerNmuLable.font = TenTypeface;
    self.customerNmuLable.textColor = Black;
    self.customerNmuLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.customerNmuLable];
    /** 客户数量增长率 */
    self.customerNmuGrowthRateLable = [[UILabel alloc] init];
    self.customerNmuGrowthRateLable.font = TenTypeface;
    self.customerNmuGrowthRateLable.textColor = Black;
    self.customerNmuGrowthRateLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.customerNmuGrowthRateLable];
    /** 交易额 */
    self.turnoverLable = [[UILabel alloc] init];
    self.turnoverLable.text = @"0元";
    self.turnoverLable.font = TenTypeface;
    self.turnoverLable.textColor = Black;
    self.turnoverLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.turnoverLable];
    /** 交易额增长率 */
    self.turnoverGrowthRateLable = [[UILabel alloc] init];
    self.turnoverGrowthRateLable.font = TenTypeface;
    self.turnoverGrowthRateLable.textColor = Black;
    self.turnoverGrowthRateLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.turnoverGrowthRateLable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 客户数量 */
    [self.customerNmuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
//    /** 客户数量增长率 */
//    [self.customerNmuGrowthRateLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.top.equalTo(self.mas_centerY).offset(4);
//        make.centerX.equalTo(self.customerNmuLable.mas_centerX);
//    }];
    /** 日期 */
    [self.dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.customerNmuLable.mas_left);
    }];
    /** 交易额 */
    [self.turnoverLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY);
        make.left.equalTo(self.customerNmuLable.mas_right);
        make.right.equalTo(self.mas_right);
    }];
//    /** 交易额增长率 */
//    [self.turnoverGrowthRateLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.top.equalTo(self.mas_centerY).offset(4);
//        make.centerX.equalTo(self.turnoverLable.mas_centerX);
//    }];
    /** 日期,客户数量,客户数量增长率,交易额,交易额增长率 */
    [@[self.dateLable, self.customerNmuLable, self.customerNmuGrowthRateLable, self.turnoverLable, self.turnoverGrowthRateLable] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.dateLable.mas_width);
    }];
}

@end
