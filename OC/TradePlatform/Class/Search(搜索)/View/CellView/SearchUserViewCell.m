//
//  SearchUserViewCell.m
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchUserViewCell.h"

@interface SearchUserViewCell ()

/** 用户cell */
@property (strong, nonatomic) UsedCellView *userCellView;
/** 车牌view */
//@property (nonatomic, strong) UIView *plnView;
/** 车牌号 */
@property (nonatomic, strong) UILabel *plnLabel;

@end

@implementation SearchUserViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 用户cell */
        self.userCellView = [[UsedCellView alloc] init];
        self.userCellView.usedCellTypeChoice = BigPictureVerticallyLayout;
        self.userCellView.dividingLineChoice = DividingLineRightLayout;
        self.userCellView.isCellImageSize = YES;
        self.userCellView.cellImageSize = CGSizeMake(52, 52);
        self.userCellView.cellImage.layer.masksToBounds = YES;
        self.userCellView.cellImage.layer.cornerRadius = 2;
        self.userCellView.cellLabel.textColor = Black;
        self.userCellView.cellLabel.font = FifteenTypeface;
        self.userCellView.viceLabel.textColor = GrayH1;
        self.userCellView.viceLabel.font = FourteenTypeface;
        self.userCellView.isArrow = YES;
        self.userCellView.isCellBtn = YES;
        self.userCellView.isCellImage = YES;
        self.userCellView.isArrow = YES;
        [self.contentView addSubview:self.userCellView];
        /** 车牌view */
//        self.plnView = [[UIView alloc] init];
//        self.plnView.backgroundColor = HEXSTR_RGB(@"f0f9ff");
//        self.plnView.layer.masksToBounds = YES;
//        self.plnView.layer.cornerRadius = 2;
//        self.plnView.layer.borderWidth = 0.5;
//        self.plnView.layer.borderColor = DividingLine.CGColor;
//        [self.contentView addSubview:self.plnView];
        /** 车牌号 */
        self.plnLabel = [[UILabel alloc] init];
        self.plnLabel.textColor = GrayH2;
        self.plnLabel.font = ThirteenTypeface;
        [self.userCellView addSubview:self.plnLabel];
    }
    return self;
}


- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    /** 用户名称 */
    self.userCellView.cellLabel.text = userModel.name;
    /** 用户手机号 */
    self.userCellView.viceLabel.text = userModel.mobile;
    /** 用户头像 */
    [self.userCellView.cellImage setImageWithImageUrl:userModel.avatar_thumb perchImage:@"placeholder_search_user"];
    /** 用户车牌号 */
//    if (userModel.car_plate_no.length == 0) {
//        [self.plnView setHidden:YES];
//    }else {
//        [self.plnView setHidden:NO];
        self.plnLabel.text = userModel.car_plate_no;
//    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /** 用户cell */
    @weakify(self)
    [self.userCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
//    /** 车牌view */
//    [self.plnView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.right.equalTo(self.userCellView.arrowImage.mas_left).offset(-16);
//        make.centerY.equalTo(self.userCellView.arrowImage.mas_centerY);
//        make.left.equalTo(self.plnLabel.mas_left).offset(-10);
//        make.height.mas_equalTo(@20);
//    }];
    /** 车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
//        make.centerY.equalTo(self.plnView.mas_centerY);
//        make.centerX.equalTo(self.plnView.mas_centerX);
        make.centerY.equalTo(self.userCellView.cellLabel.mas_centerY);
        make.right.equalTo(self.userCellView.arrowImage.mas_left);
    }];
}


@end
