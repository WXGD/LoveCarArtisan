//
//  CancellationViewCell.m
//  TradePlatform
//
//  Created by 弓杰 on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CancellationViewCell.h"

@interface CancellationViewCell ()

/** 赠品名称 */
@property (nonatomic, strong) UILabel *giftNameLabel;
/** 赠送次数 */
@property (nonatomic, strong) UILabel *giftNumLabel;
/** 赠送时间 */
@property (nonatomic, strong) leftRigText *giftTimeLabel;

@end

@implementation CancellationViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self openCardInfoLayoutView];
    }
    return self;
}

- (void)setCancellationModel:(CancellationModel *)cancellationModel {
    _cancellationModel = cancellationModel;
    /** 赠品名称 */
    self.giftNameLabel.text = cancellationModel.goods_name;
    /** 赠送次数 */
    self.giftNumLabel.text = [NSString stringWithFormat:@"%ld", cancellationModel.available_num];
    /** 赠送时间 */
    self.giftTimeLabel.rightText.text = cancellationModel.create_time;
}

- (void)openCardInfoLayoutView {
    /** 赠品名称 */
    self.giftNameLabel = [[UILabel alloc] init];
    self.giftNameLabel.text = @"赠品名称";
    self.giftNameLabel.font = FifteenTypefaceBold;
    self.giftNameLabel.textColor = Black;
    [self.contentView addSubview:self.giftNameLabel];
    /** 赠送次数 */
    self.giftNumLabel = [[UILabel alloc] init];
    self.giftNumLabel.text = @"赠送次数";
    self.giftNumLabel.font = ThirteenTypeface;
    self.giftNumLabel.textColor = BlueColor;
    [self.contentView addSubview:self.giftNumLabel];
    /** 赠送时间 */
    self.giftTimeLabel = [[leftRigText alloc] init];
    self.giftTimeLabel.leftText.text = @"赠送时间:";
    self.giftTimeLabel.leftText.textColor = GrayH2;
    self.giftTimeLabel.leftText.font = TwelveTypeface;
    self.giftTimeLabel.rightText.font = TwelveTypeface;
    self.giftTimeLabel.rightText.textColor = GrayH2;
    self.giftTimeLabel.rightText.text = @"赠送时间:";
    [self.contentView addSubview:self.giftTimeLabel];
    /** 核销按钮 */
    self.cancellationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancellationBtn setTitle:@"核销" forState:UIControlStateNormal];
    [self.cancellationBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.cancellationBtn.backgroundColor = HEXSTR_RGB(@"fafafa");
    self.cancellationBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.cancellationBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 核销按钮 */
    [self.cancellationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(@55);
    }];
    /** 赠品名称 */
    [self.giftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.contentView.mas_left).offset(16);
    }];
    /** 赠送时间 */
    [self.giftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.giftNameLabel.mas_bottom).offset(16);
        make.left.equalTo(self.giftNameLabel.mas_left);
        make.right.equalTo(self.giftTimeLabel.rightText.mas_right);
        make.bottom.equalTo(self.giftTimeLabel.rightText.mas_bottom);

    }];
    /** 赠送次数 */
    [self.giftNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.giftNameLabel.mas_centerY);
        make.right.equalTo(self.cancellationBtn.mas_left).offset(-16);
    }];
}


@end
