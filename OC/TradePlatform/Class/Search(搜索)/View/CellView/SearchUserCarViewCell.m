//
//  SearchUserCarViewCell.m
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchUserCarViewCell.h"

@interface SearchUserCarViewCell ()

/** 用户车辆cell */
@property (strong, nonatomic) UsedCellView *userCarCellView;
/** 手机号 */
@property (nonatomic, strong) UILabel *phoneLabel;

@end

@implementation SearchUserCarViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 用户车辆cell */
        self.userCarCellView = [[UsedCellView alloc] init];
        self.userCarCellView.usedCellTypeChoice = BigPictureVerticallyLayout;
        self.userCarCellView.dividingLineChoice = DividingLineRightLayout;
        self.userCarCellView.isCellBtn = YES;
        self.userCarCellView.isArrow = YES;
        self.userCarCellView.isCellImageSize = YES;
        self.userCarCellView.cellImageSize = CGSizeMake(52, 52);
        self.userCarCellView.cellImage.layer.masksToBounds = YES;
        self.userCarCellView.cellImage.layer.cornerRadius = 26;
        self.userCarCellView.cellImage.layer.borderWidth = 0.5;
        self.userCarCellView.cellImage.layer.borderColor = DividingLine.CGColor;
        self.userCarCellView.cellLabel.textColor = Black;
        self.userCarCellView.cellLabel.font = FifteenTypeface;
        self.userCarCellView.viceLabel.textColor = GrayH1;
        self.userCarCellView.viceLabel.font = FourteenTypeface;
        [self.contentView addSubview:self.userCarCellView];
        /** 手机号 */
        self.phoneLabel = [[UILabel alloc] init];
        self.phoneLabel.textColor = GrayH2;
        self.phoneLabel.font = ThirteenTypeface;
        [self.userCarCellView addSubview:self.phoneLabel];
    }
    return self;
}


/** 用户车辆 */
- (void)setUserCarModel:(UserCarModel *)userCarModel {
    _userCarModel = userCarModel;
    // 图片
    [self.userCarCellView.cellImage setImageWithImageUrl:userCarModel.car_brand_image perchImage:@"placeholder_search_car"];
    // 车辆品牌
    self.userCarCellView.cellLabel.text = userCarModel.car_brand_name;
    // 车牌号
    self.userCarCellView.viceLabel.text = userCarModel.car_plate_no;
    /** 手机号 */
    self.phoneLabel.text = userCarModel.mobile;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /** 用户cell */
    @weakify(self)
    [self.userCarCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    /** 手机号 */
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.userCarCellView.cellLabel.mas_centerY);
        make.right.equalTo(self.userCarCellView.arrowImage.mas_left);
    }];
}


@end
