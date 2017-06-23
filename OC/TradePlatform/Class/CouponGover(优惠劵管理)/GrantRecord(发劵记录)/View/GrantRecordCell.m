//
//  GrantRecordCell.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GrantRecordCell.h"

@interface GrantRecordCell ()

/** 优惠劵ID */
@property (strong, nonatomic) UILabel *couponID;
/** 发劵时间 */
@property (strong, nonatomic) UILabel *grantTimerLabel;
/** 用户手机 */
@property (strong, nonatomic) UILabel *userPhoneLabel;
/** 用户车牌 */
@property (strong, nonatomic) UILabel *userPlnLabel;
/** 已经使用 */
@property (strong, nonatomic) UIButton *nowUsedBtn;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation GrantRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 优惠劵ID */
        self.couponID = [[UILabel alloc] init];
        self.couponID.textColor = ThemeColor;
        self.couponID.font = FifteenTypefaceBold;
        self.couponID.textAlignment = NSTextAlignmentCenter;
        self.couponID.backgroundColor = VCBackgroundThree;
        [self.contentView addSubview:self.couponID];
        /** 发劵时间 */
        self.grantTimerLabel = [[UILabel alloc] init];
        self.grantTimerLabel.textColor = GrayH2;
        self.grantTimerLabel.font = TwelveTypeface;
        [self.contentView addSubview:self.grantTimerLabel];
        /** 用户手机 */
        self.userPhoneLabel = [[UILabel alloc] init];
        self.userPhoneLabel.textColor = GrayH1;
        self.userPhoneLabel.font = FourteenTypeface;
        [self.contentView addSubview:self.userPhoneLabel];
        /** 用户车牌 */
        self.userPlnLabel = [[UILabel alloc] init];
        self.userPlnLabel.textColor = GrayH1;
        self.userPlnLabel.font = FourteenTypeface;
        [self.contentView addSubview:self.userPlnLabel];
        /** 分割线 */
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = DividingLine;
        [self.contentView addSubview:self.lineView];
        /** 已经使用 */
        self.nowUsedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nowUsedBtn setTitle:@"已使用" forState:UIControlStateNormal];
        [self.nowUsedBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
        self.nowUsedBtn.titleLabel.font = TwelveTypeface;
        self.nowUsedBtn.layer.masksToBounds = YES;
        self.nowUsedBtn.layer.cornerRadius = 2;
        self.nowUsedBtn.layer.borderWidth = 0.5;
        self.nowUsedBtn.layer.borderColor = NotClick.CGColor;
        [self.contentView addSubview:self.nowUsedBtn];
        /** 作废按钮 */
        self.invalidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.invalidBtn setTitle:@"作废" forState:UIControlStateNormal];
        [self.invalidBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        self.invalidBtn.titleLabel.font = TwelveTypeface;
        self.invalidBtn.layer.masksToBounds = YES;
        self.invalidBtn.layer.cornerRadius = 2;
        self.invalidBtn.layer.borderWidth = 0.5;
        self.invalidBtn.layer.borderColor = ThemeColor.CGColor;
        [self.contentView addSubview:self.invalidBtn];
    }
    return self;
}

- (void)setGrantRecordModel:(GrantRecordModel *)grantRecordModel {
    _grantRecordModel = grantRecordModel;
    /** 优惠劵ID */
    self.couponID.text = [NSString stringWithFormat:@"%ld", grantRecordModel.coupon_record_no];
    /** 发劵时间 */
    if (grantRecordModel.available_end_time.length == 0) {
        self.grantTimerLabel.text = @"不限期";
    }else {
        self.grantTimerLabel.text = [NSString stringWithFormat:@"限%@至%@使用", grantRecordModel.available_start_time, grantRecordModel.available_end_time];
    }
    /** 用户手机 */
    self.userPhoneLabel.text = grantRecordModel.mobile;
    /** 用户车牌 */
    self.userPlnLabel.text = grantRecordModel.car_plate_no;
    // 判断是否可用使用
    if (grantRecordModel.status == 0) { // 可使用
        /** 已经使用 */
        [self.nowUsedBtn setHidden:YES];
        /** 作废按钮 */
        [self.invalidBtn setHidden:NO];
    }else {
        /** 作废按钮 */
        [self.invalidBtn setHidden:YES];
        /** 已经使用 */
        [self.nowUsedBtn setHidden:NO];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 优惠劵ID */
    [self.couponID mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(@92);
    }];
    /** 发劵时间 */
    [self.grantTimerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.couponID.mas_right).offset(16);
        make.right.equalTo(self.nowUsedBtn.mas_left).offset(-10);
    }];
    /** 用户手机 */
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.grantTimerLabel.mas_bottom).offset(10);
        make.left.equalTo(self.couponID.mas_right).offset(16);
        make.right.equalTo(self.nowUsedBtn.mas_left).offset(-10);
    }];
    /** 用户车牌 */
    [self.userPlnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userPhoneLabel.mas_bottom).offset(10);
        make.left.equalTo(self.couponID.mas_right).offset(16);
        make.right.equalTo(self.nowUsedBtn.mas_left).offset(-10);
    }];
    /** 作废按钮 */
    [self.invalidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(62, 22));
    }];
    /** 已经使用 */
    [self.nowUsedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(71, 22));
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
}

@end
