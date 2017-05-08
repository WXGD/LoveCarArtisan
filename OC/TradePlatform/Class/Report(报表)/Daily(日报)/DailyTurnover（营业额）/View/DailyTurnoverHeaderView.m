//
//  DailyTurnoverHeaderView.m
//  TradePlatform
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailyTurnoverHeaderView.h"


@interface DailyTurnoverHeaderView ()

/** 营业额标题 */
@property (strong, nonatomic) UILabel *turnoverTitle;

@end

@implementation DailyTurnoverHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dailyTurnoverHeaderLayoutView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self dailyTurnoverHeaderLayoutView];
    }
    return self;
}

#pragma mark - view布局
- (void)dailyTurnoverHeaderLayoutView {
    /** 日期选择按钮 */
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.detaChioceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.detaChioceBtn setTitle:dateString forState:UIControlStateNormal];
    [self.detaChioceBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.detaChioceBtn.titleLabel.font = FourteenTypeface;
    [self.detaChioceBtn setImage:[UIImage imageNamed:@"white_sele_arrow"] forState:UIControlStateNormal];
    self.detaChioceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    self.detaChioceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 8);
    self.detaChioceBtn.layer.masksToBounds = YES;
    self.detaChioceBtn.layer.cornerRadius = 17;
    self.detaChioceBtn.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self addSubview:self.detaChioceBtn];
    /** 营业额数量 */
    self.turnoverNum = [[UILabel alloc] init];
    self.turnoverNum.textColor = WhiteColor;
    self.turnoverNum.font = [UIFont fontWithName:@"Helvetica-Bold" size:75];
    [self addSubview:self.turnoverNum];
    /** 营业额标题 */
    self.turnoverTitle = [[UILabel alloc] init];
    self.turnoverTitle.text = @"总营业额（元）";
    self.turnoverTitle.textColor = WhiteColor;
    self.turnoverTitle.font = FourteenTypeface;
    [self addSubview:self.turnoverTitle];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 日期选择按钮 */
    [self.detaChioceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(25);
        make.width.mas_equalTo(@125);
        make.height.mas_equalTo(@35);
    }];
    /** 营业额数量 */
    [self.turnoverNum mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.detaChioceBtn.mas_bottom).offset(85);
    }];
    /** 营业额标题 */
    [self.turnoverTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.turnoverNum.mas_bottom).offset(35);
    }];
}




@end
