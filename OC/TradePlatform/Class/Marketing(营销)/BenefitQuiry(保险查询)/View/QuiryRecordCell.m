//
//  QuiryRecordCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QuiryRecordCell.h"
#import "leftRigText.h"

@interface QuiryRecordCell ()

/** 查询记录状态标记 */
@property (strong, nonatomic) UIImageView *quiryRecordStateImage;
/** 车牌号 */
@property (strong, nonatomic) UILabel *plnLabel;
/** 到期时间 */
@property (strong, nonatomic) leftRigText *expireTimeLabel;
/** 查询状态 */
@property (strong, nonatomic) UILabel *quiryStateLabel;

@end


@implementation QuiryRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        [self marketingTableCellLayoutView];
    }
    return self;
}

- (void)marketingTableCellLayoutView {
    /** 查询记录状态标记 */
    self.quiryRecordStateImage = [[UIImageView alloc] init];
    self.quiryRecordStateImage.userInteractionEnabled = YES;
    [self.contentView addSubview:self.quiryRecordStateImage];
    /** 车牌号 */
    self.plnLabel = [[UILabel alloc] init];
    self.plnLabel.font = FifteenTypeface;
    self.plnLabel.textColor = Black;
    [self.quiryRecordStateImage addSubview:self.plnLabel];
    /** 到期时间 */
    self.expireTimeLabel = [[leftRigText alloc] init];
    self.expireTimeLabel.leftText.text = @"到期时间:";
    self.expireTimeLabel.leftText.textColor = GrayH2;
    self.expireTimeLabel.leftText.font = TwelveTypeface;
    self.expireTimeLabel.rightText.font = TwelveTypeface;
    self.expireTimeLabel.rightText.textColor = GrayH2;
    [self.quiryRecordStateImage addSubview:self.expireTimeLabel];
    /** 查询状态 */
    self.quiryStateLabel = [[UILabel alloc] init];
    self.quiryStateLabel.font = FourteenTypeface;
    [self.quiryRecordStateImage addSubview:self.quiryStateLabel];
}

- (void)setQuiryRecordModel:(BennfitQuiryRecordModel *)quiryRecordModel {
    _quiryRecordModel = quiryRecordModel;
    /** 车牌号 */
    self.plnLabel.text = quiryRecordModel.car_plate_no;
    /** 到期时间 */
    self.expireTimeLabel.rightText.text = quiryRecordModel.end_time;
    /** 查询状态 （1:查询中。2:完成。3:失败） */
    switch (quiryRecordModel.status) {
        case 1: {
            /** 查询状态 */
            self.quiryStateLabel.text = @"查询中";
            self.quiryStateLabel.textColor = BlueColor;
            /** 查询记录状态标记 */
            self.quiryRecordStateImage.image = [UIImage imageNamed:@"quiry_record_ongoing"];
            break;
        }
        case 2: {
            /** 查询状态 */
            self.quiryStateLabel.text = @"完成";
            self.quiryStateLabel.textColor = ThemeColor;
            /** 查询记录状态标记 */
            self.quiryRecordStateImage.image = [UIImage imageNamed:@"quiry_record_success"];
            break;
        }
        case 3: {
            /** 查询状态 */
            self.quiryStateLabel.text = @"查询失败";
            self.quiryStateLabel.textColor = HEXSTR_RGB(@"e53935");
            /** 查询记录状态标记 */
            self.quiryRecordStateImage.image = [UIImage imageNamed:@"quiry_record_failure"];
            break;
        }
        default:
            break;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 查询记录状态标记 */
    [self.quiryRecordStateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    /** 车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.quiryRecordStateImage.mas_centerY).offset(-5);
        make.left.equalTo(self.quiryRecordStateImage.mas_left).offset(21);
    }];
    /** 到期时间 */
    [self.expireTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.quiryRecordStateImage.mas_centerY).offset(5);
        make.left.equalTo(self.plnLabel.mas_left);
        make.right.equalTo(self.expireTimeLabel.rightText.mas_right);
        make.bottom.equalTo(self.expireTimeLabel.rightText.mas_bottom);
    }];
    /** 查询状态 */
    [self.quiryStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.right.equalTo(self.quiryRecordStateImage.mas_right).offset(-16);
    }];
}


@end
