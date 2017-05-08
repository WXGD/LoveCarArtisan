//
//  ConfictCarViewCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConfictCarViewCell.h"

@interface ConfictCarViewCell ()

/** 车辆信息view */
@property (strong, nonatomic) UsedCellView *carInfoView;

@end

@implementation ConfictCarViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 车辆信息view */
        self.carInfoView = [[UsedCellView alloc] init];
        self.carInfoView.backgroundColor = WhiteColor;
        self.carInfoView.cellLabel.textColor = Black;
        self.carInfoView.cellLabel.font = FourteenTypeface;
        self.carInfoView.describeLabel.textColor = Black;
        self.carInfoView.describeLabel.font = FourteenTypeface;
        self.carInfoView.dividingLineChoice = DividingLineFullScreenLayout;
        self.carInfoView.isArrow = YES;
        self.carInfoView.isCellImage = YES;
        self.carInfoView.isCellBtn = YES;
        [self.contentView addSubview:self.carInfoView];
    }
    return self;
}

- (void)setConfictCarModel:(CWFUserCarModel *)confictCarModel {
    _confictCarModel = confictCarModel;
    // 车辆品牌型号名
    self.carInfoView.cellLabel.text = confictCarModel.car_brand_series;
    // 车牌号
    self.carInfoView.describeLabel.text = confictCarModel.car_plate_no;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 车辆信息view */
    [self.carInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}


@end
