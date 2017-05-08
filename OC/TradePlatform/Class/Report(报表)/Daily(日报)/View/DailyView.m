//
//  DailyView.m
//  TradePlatform
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailyView.h"
#import "UsedCellView.h"

@interface DailyView ()

/** 用户 */
@property (strong, nonatomic) UsedCellView *userTitleView;
/** 营业额 */
@property (strong, nonatomic) UsedCellView *turnoverTitleView;

/** 用户数据 */
@property (strong, nonatomic) UIView *userDateView;
/** 营业额数据 */
@property (strong, nonatomic) UIView *turnoverDateView;

@end

@implementation DailyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self dailyLayoutView];
    }
    return self;
}

#pragma mark - view布局
- (void)dailyLayoutView {
    /** 用户数据 */
    self.userDateView = [[UIView alloc] init];
    self.userDateView.backgroundColor = RGB(202, 225, 192);
    [self addSubview:self.userDateView];

    /** 用户 */
    self.userTitleView = [[UsedCellView alloc] init];
    self.userTitleView.cellImage.image = [UIImage imageNamed:@"report_user"];
    self.userTitleView.cellLabel.text = @"用户";
    self.userTitleView.cellLabel.font = FifteenTypeface;
    self.userTitleView.isArrow = YES;
    self.userTitleView.isSplistLine = YES;
    self.userTitleView.isCellBtn = YES;
    [self.userDateView addSubview:self.userTitleView];
    /** 今日用户 */
    self.todayUser = [[TwoWordsLabel alloc] init];
    self.todayUser.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.todayUser.mainLabel.text = @"今日用户（人）";
    self.todayUser.mainLabel.textColor = ThemeColor;
    self.todayUser.mainLabel.font = FourteenTypeface;
    self.todayUser.viceLabel.textColor = ThemeColor;
    self.todayUser.viceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:40];
    self.todayUser.backgroundColor = WhiteColor;
    [self.userDateView addSubview:self.todayUser];
    /** 昨日用户 */
    self.yesterdayUser = [[TwoWordsLabel alloc] init];
    self.yesterdayUser.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.yesterdayUser.mainLabel.text = @"昨日用户（人）";
    self.yesterdayUser.mainLabel.textColor = GrayH1;
    self.yesterdayUser.mainLabel.font = FifteenTypeface;
    self.yesterdayUser.viceLabel.textColor = GrayH1;
    self.yesterdayUser.viceLabel.font = EighteenTypeface;
    [self.userDateView addSubview:self.yesterdayUser];
    /** 今日用户增长率 */
    self.todayUserGrowthRate = [[TwoWordsLabel alloc] init];
    self.todayUserGrowthRate.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.todayUserGrowthRate.mainLabel.text = @"增长率（%）";
    self.todayUserGrowthRate.mainLabel.textColor = GrayH1;
    self.todayUserGrowthRate.mainLabel.font = FifteenTypeface;
    self.todayUserGrowthRate.viceLabel.textColor = GrayH1;
    self.todayUserGrowthRate.viceLabel.font = EighteenTypeface;
    [self.userDateView addSubview:self.todayUserGrowthRate];
    /** 用户 */
    self.userViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userViewBtn.tag = UserBtnAction;
    [self.userDateView addSubview:self.userViewBtn];
    
    /** 营业额数据 */
    self.turnoverDateView = [[UIView alloc] init];
    self.turnoverDateView.backgroundColor = RGB(202, 225, 192);
    [self addSubview:self.turnoverDateView];
    /** 营业额 */
    self.turnoverTitleView = [[UsedCellView alloc] init];
    self.turnoverTitleView.cellImage.image = [UIImage imageNamed:@"daily_turnover_by"];
    self.turnoverTitleView.cellLabel.text = @"营业额";
    self.turnoverTitleView.cellLabel.font = FifteenTypeface;
    self.turnoverTitleView.isArrow = YES;
    self.turnoverTitleView.isSplistLine = YES;
    self.turnoverTitleView.isCellBtn = YES;
    [self.turnoverDateView addSubview:self.turnoverTitleView];
    /** 今日营业额 */
    self.todayTurnover = [[TwoWordsLabel alloc] init];
    self.todayTurnover.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.todayTurnover.mainLabel.text = @"今日营业额（元）";
    self.todayTurnover.mainLabel.textColor = ThemeColor;
    self.todayTurnover.mainLabel.font = FifteenTypeface;
    self.todayTurnover.viceLabel.textColor = ThemeColor;
    self.todayTurnover.viceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:40];
    self.todayTurnover.backgroundColor = WhiteColor;
    [self.turnoverDateView addSubview:self.todayTurnover];
    /** 昨日营业额 */
    self.yesterdayTurnover = [[TwoWordsLabel alloc] init];
    self.yesterdayTurnover.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.yesterdayTurnover.mainLabel.text = @"昨日营业额（元）";
    self.yesterdayTurnover.mainLabel.textColor = GrayH1;
    self.yesterdayTurnover.mainLabel.font = FifteenTypeface;
    self.yesterdayTurnover.viceLabel.textColor = GrayH1;
    self.yesterdayTurnover.viceLabel.font = EighteenTypeface;
    [self.turnoverDateView addSubview:self.yesterdayTurnover];
    /** 今日营业额增长率 */
    self.todayTurnoverGrowthRate = [[TwoWordsLabel alloc] init];
    self.todayTurnoverGrowthRate.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.todayTurnoverGrowthRate.mainLabel.text = @"增长率（%）";
    self.todayTurnoverGrowthRate.mainLabel.textColor = GrayH1;
    self.todayTurnoverGrowthRate.mainLabel.font = FifteenTypeface;
    self.todayTurnoverGrowthRate.viceLabel.textColor = GrayH1;
    self.todayTurnoverGrowthRate.viceLabel.font = EighteenTypeface;
    [self.turnoverDateView addSubview:self.todayTurnoverGrowthRate];
    /** 营业额 */
    self.turnoverViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.turnoverViewBtn.tag = TurnoverBtnAction;
    [self.turnoverDateView addSubview:self.turnoverViewBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 用户数据 */
    [self.userDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 用户 */
    [self.userTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userDateView.mas_top);
        make.left.equalTo(self.userDateView.mas_left);
        make.right.equalTo(self.userDateView.mas_right);
        make.height.mas_equalTo(@30);
    }];
    /** 今日用户 */
    [self.todayUser mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userTitleView.mas_bottom);
        make.left.equalTo(self.userDateView.mas_left);
        make.right.equalTo(self.userDateView.mas_right);
        make.height.mas_equalTo(@100);
    }];
    /** 昨日用户 */
    [self.yesterdayUser mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.todayUser.mas_bottom);
        make.left.equalTo(self.userDateView.mas_left);
    }];
    /** 今日用户增长率 */
    [self.todayUserGrowthRate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.todayUser.mas_bottom);
        make.left.equalTo(self.yesterdayUser.mas_right);
        make.right.equalTo(self.userDateView.mas_right);
    }];
    /** 昨日用户,今日用户增长率 */
    [@[self.yesterdayUser, self.todayUserGrowthRate] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.yesterdayUser.mas_width);
        make.height.mas_equalTo(@70);
    }];
    /** 用户数据的高度 */
    [self.userDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.todayUserGrowthRate.mas_bottom);
    }];
    /** 用户 */
    [self.userViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userDateView.mas_top);
        make.left.equalTo(self.userDateView.mas_left);
        make.right.equalTo(self.userDateView.mas_right);
        make.bottom.equalTo(self.userDateView.mas_bottom);
    }];
    
    /** 营业额数据 */
    [self.turnoverDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userDateView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 营业额 */
    [self.turnoverTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.turnoverDateView.mas_top);
        make.left.equalTo(self.turnoverDateView.mas_left);
        make.right.equalTo(self.turnoverDateView.mas_right);
        make.height.mas_equalTo(@30);
    }];
    /** 今日营业额 */
    [self.todayTurnover mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.turnoverTitleView.mas_bottom);
        make.left.equalTo(self.turnoverDateView.mas_left);
        make.right.equalTo(self.turnoverDateView.mas_right);
        make.height.mas_equalTo(@100);
    }];
    /** 昨日营业额 */
    [self.yesterdayTurnover mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.todayTurnover.mas_bottom);
        make.left.equalTo(self.turnoverDateView.mas_left);
    }];
    /** 今日营业额增长率 */
    [self.todayTurnoverGrowthRate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.todayTurnover.mas_bottom);
        make.left.equalTo(self.yesterdayTurnover.mas_right);
        make.right.equalTo(self.turnoverDateView.mas_right);
    }];
    /** 昨日营业额,今日营业额增长率 */
    [@[self.yesterdayTurnover, self.todayTurnoverGrowthRate] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.yesterdayTurnover.mas_width);
        make.height.mas_equalTo(@70);
    }];
    /** 营业额数据高度 */
    [self.turnoverDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.todayTurnoverGrowthRate.mas_bottom);
    }];
    /** 营业额 */
    [self.turnoverViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.turnoverDateView.mas_top);
        make.left.equalTo(self.turnoverDateView.mas_left);
        make.right.equalTo(self.turnoverDateView.mas_right);
        make.bottom.equalTo(self.turnoverDateView.mas_bottom);
    }];
}

@end
