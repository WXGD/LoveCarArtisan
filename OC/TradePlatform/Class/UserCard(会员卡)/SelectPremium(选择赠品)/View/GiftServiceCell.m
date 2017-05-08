//
//  GiftServiceCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GiftServiceCell.h"

@interface GiftServiceCell ()

/** 赠品标记 */
@property (strong, nonatomic) UIImageView *giftSign;
/** 赠送数量 */
@property (strong, nonatomic) UsedCellView *giftNumView;

@end

@implementation GiftServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEARCOLOR;
        /** 赠品标题 */
        self.delTitleView = [[UsedCellView alloc] init];
        self.delTitleView.backgroundColor = WhiteColor;
        [self.delTitleView.arrowImage setImage:nil forState:UIControlStateNormal];
        [self.delTitleView.arrowImage setTitle:@"取消" forState:UIControlStateNormal];
        [self.delTitleView.arrowImage setTitleColor:HEXSTR_RGB(@"e53935") forState:UIControlStateNormal];
        self.delTitleView.cellImage.image = [UIImage imageNamed:@"premium"];
        self.delTitleView.cellLabel.textColor = ThemeColor;
        self.delTitleView.cellLabel.font = FourteenTypeface;
        self.delTitleView.dividingLineChoice = DividingLineFullScreenLayout;
        self.delTitleView.isCellBtn = YES;
        [self.contentView addSubview:self.delTitleView];
        /** 服务类别 */
        self.serviceClassView = [[UsedCellView alloc] init];
        [self.serviceClassView.arrowImage setImage:[UIImage imageNamed:@"bottom_arrow_gray"] forState:UIControlStateNormal];
        self.serviceClassView.backgroundColor = WhiteColor;
        self.serviceClassView.cellLabel.text = @"类别";
        self.serviceClassView.cellLabel.textColor = GrayH1;
        self.serviceClassView.cellLabel.font = FourteenTypeface;
        self.serviceClassView.describeLabel.font = FourteenTypeface;
        self.serviceClassView.describeLabel.text = @"请选择类别";
        self.serviceClassView.describeLabel.textColor = Black;
        self.serviceClassView.isCellImage = YES;
        self.serviceClassView.dividingLineChoice = DividingLineFullScreenLayout;
        [self.contentView addSubview:self.serviceClassView];
        /** 服务 */
        self.serviceView = [[UsedCellView alloc] init];
        [self.serviceView.arrowImage setImage:[UIImage imageNamed:@"bottom_arrow_gray"] forState:UIControlStateNormal];
        self.serviceView.backgroundColor = WhiteColor;
        self.serviceView.cellLabel.text = @"服务";
        self.serviceView.cellLabel.textColor = GrayH1;
        self.serviceView.cellLabel.font = FourteenTypeface;
        self.serviceView.describeLabel.font = FourteenTypeface;
        self.serviceView.describeLabel.text = @"请选择服务";
        self.serviceView.describeLabel.textColor = Black;
        self.serviceView.isCellImage = YES;
        self.serviceView.dividingLineChoice = DividingLineFullScreenLayout;
        [self.contentView addSubview:self.serviceView];
        /** 赠送数量 */
        self.giftNumView = [[UsedCellView alloc] init];
        self.giftNumView.backgroundColor = WhiteColor;
        self.giftNumView.cellLabel.text = @"数量";
        self.giftNumView.cellLabel.textColor = GrayH1;
        self.giftNumView.cellLabel.font = FourteenTypeface;
        self.giftNumView.isSplistLine = YES;
        self.giftNumView.isCellImage = YES;
        self.giftNumView.isArrow = YES;
        self.giftNumView.isCellBtn = YES;
        [self.contentView addSubview:self.giftNumView];
        /** 数量操作 */
        self.numOperBtn = [[AddSubNumView alloc] init];
        [self.giftNumView addSubview:self.numOperBtn];
    }
    return self;
}

/** 赠品模型 */
- (void)setPremiumModel:(PremiumModel *)premiumModel {
    _premiumModel = premiumModel;
    /** 服务类别 */
    self.serviceClassView.describeLabel.text = premiumModel.serviceModel.name;
    /** 服务 */
    self.serviceView.describeLabel.text = premiumModel.goodsModel.name;
    /** 赠送数量 */
    self.numOperBtn.numTF.text = [NSString stringWithFormat:@"%ld", premiumModel.premiumNum];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 赠品标题 */
    [self.delTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 服务类别 */
    [self.serviceClassView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.delTitleView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 服务 */
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serviceClassView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 赠送数量 */
    [self.giftNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serviceView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 数量操作 */
    [self.numOperBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.giftNumView.mas_centerY);
        make.right.equalTo(self.giftNumView.mas_right).offset(-16);
    }];
}


@end
