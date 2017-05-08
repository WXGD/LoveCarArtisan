//
//  DailyUserView.m
//  TradePlatform
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailyUserView.h"


@interface DailyUserView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *dailyUserScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *dailyUserView;

/** 用户报表头部view */
@property (strong, nonatomic) UIView *userHeader;
/** 用户标题 */
@property (strong, nonatomic) UILabel *userTitle;

@end

@implementation DailyUserView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self dailyUserLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)dailyUserLayoutView {
    /** 背景scrollview */
    self.dailyUserScrollView = [[UIScrollView alloc] init];
    self.dailyUserScrollView.backgroundColor = VCBackground;
    [self addSubview:self.dailyUserScrollView];
    /** 填充scrollview的view */
    self.dailyUserView = [[UIView alloc] init];
    self.dailyUserView.backgroundColor = VCBackground;
    [self.dailyUserScrollView addSubview:self.dailyUserView];
    
    
    /** 用户报表头部view */
    self.userHeader = [[UIView alloc] init];
    self.userHeader.backgroundColor = ThemeColor;
    [self.dailyUserView addSubview:self.userHeader];
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
    [self.userHeader addSubview:self.detaChioceBtn];
    /** 用户数量 */
    self.userNum = [[UILabel alloc] init];
    self.userNum.textColor = WhiteColor;
    self.userNum.font = [UIFont fontWithName:@"Helvetica-Bold" size:75];
    [self.userHeader addSubview:self.userNum];
    /** 用户标题 */
    self.userTitle = [[UILabel alloc] init];
    self.userTitle.text = @"总用户人数（人）";
    self.userTitle.textColor = WhiteColor;
    self.userTitle.font = FourteenTypeface;
    [self.userHeader addSubview:self.userTitle];
    
    /** 男 */
    self.maleSexLabel = [[TwoWordsLabel alloc] init];
    self.maleSexLabel.twoWordsShowStyle = TextAndImageVerticallyLayoutAndSuperCenter;
    self.maleSexLabel.mainImage.image = [UIImage imageNamed:@"male"];
    self.maleSexLabel.mainLabel.text = @"男性用户（人）";
    self.maleSexLabel.mainLabel.textColor = GrayH2;
    self.maleSexLabel.mainLabel.font = TwelveTypeface;
    self.maleSexLabel.viceLabel.textColor = ThemeColor;
    self.maleSexLabel.viceLabel.font = ThirtyTypeface;
    self.maleSexLabel.backgroundColor = WhiteColor;
    [self.dailyUserView addSubview:self.maleSexLabel];
    /** 女 */
    self.femaleSexLabel = [[TwoWordsLabel alloc] init];
    self.femaleSexLabel.twoWordsShowStyle = TextAndImageVerticallyLayoutAndSuperCenter;
    self.femaleSexLabel.mainImage.image = [UIImage imageNamed:@"female"];
    self.femaleSexLabel.mainLabel.text = @"女性用户（人）";
    self.femaleSexLabel.mainLabel.textColor = GrayH2;
    self.femaleSexLabel.mainLabel.font = TwelveTypeface;
    self.femaleSexLabel.viceLabel.textColor = ThemeColor;
    self.femaleSexLabel.viceLabel.font = ThirtyTypeface;
    self.femaleSexLabel.backgroundColor = WhiteColor;
    [self.dailyUserView addSubview:self.femaleSexLabel];
    /** 未知 */
    self.unknownSexLabel = [[TwoWordsLabel alloc] init];
    self.unknownSexLabel.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.unknownSexLabel.mainLabel.text = @"性别未知（人）";
    self.unknownSexLabel.mainLabel.textColor = GrayH2;
    self.unknownSexLabel.mainLabel.font = TwelveTypeface;
    self.unknownSexLabel.viceLabel.textColor = GrayH1;
    self.unknownSexLabel.viceLabel.font = ThirtyTypeface;
    self.unknownSexLabel.backgroundColor = WhiteColor;
    [self.dailyUserView addSubview:self.unknownSexLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.dailyUserScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.dailyUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dailyUserScrollView.mas_top);
        make.left.equalTo(self.dailyUserScrollView.mas_left);
        make.bottom.equalTo(self.dailyUserScrollView.mas_bottom);
        make.right.equalTo(self.dailyUserScrollView.mas_right);
        make.width.equalTo(self.dailyUserScrollView.mas_width);
    }];

    
    /** 用户报表头部view */
    [self.userHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dailyUserView.mas_top);
        make.left.equalTo(self.dailyUserView.mas_left);
        make.right.equalTo(self.dailyUserView.mas_right);
    }];
    /** 日期选择按钮 */
    [self.detaChioceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.userHeader.mas_centerX);
        make.top.equalTo(self.userHeader.mas_top).offset(25);
        make.width.mas_equalTo(@125);
        make.height.mas_equalTo(@35);
    }];
    /** 用户数量 */
    [self.userNum mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.userHeader.mas_centerX);
        make.top.equalTo(self.detaChioceBtn.mas_bottom).offset(85);
    }];
    /** 用户标题 */
    [self.userTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.userHeader.mas_centerX);
        make.top.equalTo(self.userNum.mas_bottom).offset(35);
    }];
    /** 用户报表头部view高度 */
    [self.userHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.userTitle.mas_bottom).offset(30);
    }];
    /** 男 */
    [self.maleSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userHeader.mas_bottom);
        make.left.equalTo(self.dailyUserView.mas_left);
        make.bottom.equalTo(self.maleSexLabel.viceLabel.mas_bottom).offset(20);
    }];
    /** 女 */
    [self.femaleSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userHeader.mas_bottom);
        make.left.equalTo(self.maleSexLabel.mas_right);
        make.right.equalTo(self.dailyUserView.mas_right);
        make.bottom.equalTo(self.femaleSexLabel.viceLabel.mas_bottom).offset(20);
    }];
    /** 男,女 */
    [@[self.maleSexLabel, self.femaleSexLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.maleSexLabel.mas_width);
    }];
    /** 未知 */
    [self.unknownSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.maleSexLabel.mas_bottom);
        make.left.equalTo(self.dailyUserView.mas_left);
        make.right.equalTo(self.dailyUserView.mas_right);
        make.bottom.equalTo(self.unknownSexLabel.viceLabel.mas_bottom).offset(10);
    }];
    /** 填充scrollview的view的高度 */
    [self.dailyUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.unknownSexLabel.mas_bottom).offset(20);
    }];
}

@end

