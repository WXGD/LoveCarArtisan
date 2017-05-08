//
//  UserCarOptCell.m
//  TradePlatform
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCarOptCell.h"

@interface UserCarOptCell ()


/** 车牌号 */
@property (strong, nonatomic) UILabel *plnLabel;
/** 车型号 */
@property (strong, nonatomic) UILabel *carBrandLabel;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;
/** cellRight背景view */
@property (strong, nonatomic) UIView *cellRightBackView;
/** 行驶里程标题 */
@property (strong, nonatomic) UILabel *mileageTitle;
/** 行驶里程 */
@property (strong, nonatomic) UILabel *mileageLabel;
/** 下次保养时间标题 */
@property (strong, nonatomic) UILabel *nextTimeTitle;
/** 下次保养时间 */
@property (strong, nonatomic) UILabel *nextTimeLabel;

@end

@implementation UserCarOptCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** cell背景view */
        self.cellBackView = [[UIView alloc] init];
        self.cellBackView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.cellBackView];
        /** 车牌号 */
        self.plnLabel = [[UILabel alloc] init];
        self.plnLabel.textColor = ThemeColor;
        self.plnLabel.font = SixteenTypefaceBold;
        [self.cellBackView addSubview:self.plnLabel];
        /** 车型号 */
        self.carBrandLabel = [[UILabel alloc] init];
        self.carBrandLabel.textColor = GrayH1;
        self.carBrandLabel.font = TwelveTypeface;
        [self.cellBackView addSubview:self.carBrandLabel];
        /** 分割线 */
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = DividingLine;
        [self.cellBackView addSubview:self.lineView];
        /** cellRight背景view */
        self.cellRightBackView = [[UIView alloc] init];
        [self.cellBackView addSubview:self.cellRightBackView];
        /** 行驶里程标题 */
        self.mileageTitle = [[UILabel alloc] init];
        self.mileageTitle.text = @"行驶里程";
        self.mileageTitle.textColor = GrayH2;
        self.mileageTitle.font = TwelveTypeface;
        [self.cellRightBackView addSubview:self.mileageTitle];
        /** 行驶里程 */
        self.mileageLabel = [[UILabel alloc] init];
        self.mileageLabel.textColor = Black;
        self.mileageLabel.font = FourteenTypeface;
        [self.cellRightBackView addSubview:self.mileageLabel];
        /** 下次保养时间标题 */
        self.nextTimeTitle = [[UILabel alloc] init];
        self.nextTimeTitle.text = @"下次保养时间";
        self.nextTimeTitle.textColor = GrayH2;
        self.nextTimeTitle.font = TwelveTypeface;
        [self.cellRightBackView addSubview:self.nextTimeTitle];
        /** 下次保养时间 */
        self.nextTimeLabel = [[UILabel alloc] init];
        self.nextTimeLabel.textColor = Black;
        self.nextTimeLabel.font = FourteenTypeface;
        [self.cellRightBackView addSubview:self.nextTimeLabel];
    }
    return self;
}


- (void)setUserCarModel:(UserCarModel *)userCarModel {
    _userCarModel = userCarModel;
    /** 车牌号 */
    self.plnLabel.text = userCarModel.car_plate_no;
    /** 车型号 */
    self.carBrandLabel.text = userCarModel.car_brand_series;
    /** 行驶里程 */
    self.mileageLabel.text = userCarModel.mileage;
    /** 下次保养时间 */
    self.nextTimeLabel.text = userCarModel.next_maintain;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** cell背景view */
    [self.cellBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.equalTo(self.nextTimeLabel.mas_bottom).offset(16);
    }];
    /** 车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cellBackView.mas_top).offset(16);
        make.left.equalTo(self.cellBackView.mas_left).offset(16);
    }];
    /** 车型号 */
    [self.carBrandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnLabel.mas_bottom).offset(16);
        make.left.equalTo(self.plnLabel.mas_left);
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cellBackView.mas_top).offset(16);
        make.bottom.equalTo(self.cellBackView.mas_bottom).offset(-16);
        make.left.equalTo(self.mas_left).offset(130);
        make.width.mas_equalTo(@0.5);
    }];
    /** cellRight背景view */
    [self.cellRightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.lineView.mas_right);
        make.right.equalTo(self.contentView.mas_right);
    }];
    /** 行驶里程标题 */
    [self.mileageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.left.equalTo(self.cellRightBackView.mas_left).offset(16);
    }];
    /** 行驶里程 */
    [self.mileageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.carBrandLabel.mas_centerY);
        make.left.equalTo(self.mileageTitle.mas_left);
    }];
    /** 下次保养时间标题 */
    [self.nextTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.left.equalTo(self.cellRightBackView.mas_centerX);
    }];
    /** 下次保养时间 */
    [self.nextTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.carBrandLabel.mas_centerY);
        make.left.equalTo(self.nextTimeTitle.mas_left);
    }];
}



@end
