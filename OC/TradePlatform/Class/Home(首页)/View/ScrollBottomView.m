//
//  ScrollBottomView.m
//  TradePlatform
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ScrollBottomView.h"

@interface ScrollBottomView ()

/** 爱车工匠 */
@property (strong, nonatomic) UILabel *appNameLabel;
/** 提示语View */
@property (strong, nonatomic) UIView *signView;
/** 提示语 */
@property (strong, nonatomic) UILabel *signLabel;
/** 天 */
@property (strong, nonatomic) UILabel *dayLabel;
/** 左分割线 */
@property (strong, nonatomic) UIView *leftDividingLineView;
/** 右分割线 */
@property (strong, nonatomic) UIView *rightDividingLineView;

@end

@implementation ScrollBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self scrollBottomViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)scrollBottomViewLayoutView {
    /** 爱车工匠 */
    self.appNameLabel = [[UILabel alloc] init];
    self.appNameLabel.text = @"爱车工匠已陪伴您";
    self.appNameLabel.font = TwelveTypeface;
    self.appNameLabel.textColor = NotClick;
    [self addSubview:self.appNameLabel];
    /** 提示语View */
    self.signView = [[UIView alloc] init];
    [self addSubview:self.signView];
    /** 提示语 */
    self.signLabel = [[UILabel alloc] init];
    self.signLabel.text = @"0";
    self.signLabel.font = EighteenTypeface;
    self.signLabel.textColor = GrayH2;
    [self.signView addSubview:self.signLabel];
    // 获取商户信息user
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    // 获取用户注册时间
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:merchantInfo.create_time];
    // 获取当前时间
    NSDate *datenow = [NSDate date];
    // 计算注册天数
    self.signLabel.text = [self calcDaysFromBegin:date end:datenow];
    /** 天 */
    self.dayLabel = [[UILabel alloc] init];
    self.dayLabel.text = @"天";
    self.dayLabel.font = TwelveTypeface;
    self.dayLabel.textColor = GrayH2;
    [self.signView addSubview:self.dayLabel];
    /** 左分割线 */
    self.leftDividingLineView = [[UIView alloc] init];
    self.leftDividingLineView.backgroundColor = [UIColor colorWithRed:221 / 254.0 green:221 / 254.0 blue:221 / 254.0 alpha:1];
    [self addSubview:self.leftDividingLineView];
    /** 右分割线 */
    self.rightDividingLineView = [[UIView alloc] init];
    self.rightDividingLineView.backgroundColor = [UIColor colorWithRed:221 / 254.0 green:221 / 254.0 blue:221 / 254.0 alpha:1];
    [self addSubview:self.rightDividingLineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 爱车工匠 */
    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** 提示语View */
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.appNameLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** 提示语 */
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.signView.mas_top);
        make.left.equalTo(self.signView.mas_left);
    }];
    /** 天 */
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.signLabel.mas_centerY);
        make.left.equalTo(self.signLabel.mas_right).offset(5);
    }];
    /** 提示语View宽高 */
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.signLabel.mas_bottom);
        make.right.equalTo(self.dayLabel.mas_right);
    }];
    /** 左分割线 */
    [self.leftDividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.signView.mas_centerY);
        make.right.equalTo(self.signView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 1));
    }];
    /** 右分割线 */
    [self.rightDividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.signView.mas_centerY);
        make.left.equalTo(self.signView.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 1));
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.signView.mas_bottom).offset(20);
    }];
}

/** 计算两个时间间隔的天数 */
- (NSString *)calcDaysFromBegin:(NSDate *)inBegin end:(NSDate *)inEnd {
    NSInteger unitFlags = NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [cal components:unitFlags fromDate:inBegin];
    NSDate *newBegin  = [cal dateFromComponents:comps];
    NSCalendar *cal2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps2 = [cal2 components:unitFlags fromDate:inEnd];
    NSDate *newEnd  = [cal2 dateFromComponents:comps2];
    NSTimeInterval interval = [newEnd timeIntervalSinceDate:newBegin];
    NSInteger beginDays = ((NSInteger)interval) / (3600*24);
    beginDays = beginDays + 1;
    return [NSString stringWithFormat:@"%ld", beginDays];
}
@end
