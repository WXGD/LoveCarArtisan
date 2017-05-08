//
//  UserAndPlnViewCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserAndPlnViewCell.h"

@interface UserAndPlnViewCell ()

/** cell背景view */
@property (strong, nonatomic) UIView *cellBackView;
/** 用户头像图片 */
@property (strong, nonatomic) UIImageView *userHeadImage;
/** 用户名称 */
@property (strong, nonatomic) UILabel *userNameLabel;
/** 用户手机 */
@property (strong, nonatomic) UILabel *userPhoneLabel;
/** 用户车牌号 */
@property (strong, nonatomic) UILabel *userPlnLabel;
/** cell尖头 */
@property (strong, nonatomic) UIImageView *cellArroryImage;
/** 分割线 */
@property (strong, nonatomic) UIView *dividingLineView;

@end

@implementation UserAndPlnViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        [self userAndPlnLayoutView];
    }
    return self;
}

- (void)userAndPlnLayoutView {
    /** cell背景view */
    self.cellBackView = [[UIView alloc] init];
    self.cellBackView.backgroundColor = WhiteColor;
    [self.contentView addSubview:self.cellBackView];
    /** cell选中标记 */
    self.cellSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cellSelectedBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.cellSelectedBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.cellBackView addSubview:self.cellSelectedBtn];
    /** 用户头像图片 */
    self.userHeadImage = [[UIImageView alloc] init];
    self.userHeadImage.layer.masksToBounds = YES;
    self.userHeadImage.layer.cornerRadius = 2;
    [self.cellBackView addSubview:self.userHeadImage];
    /** 用户名称 */
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.text = @"用户名称";
    self.userNameLabel.textColor = Black;
    self.userNameLabel.font = FourteenTypeface;
    [self.cellBackView addSubview:self.userNameLabel];
    /** 用户手机 */
    self.userPhoneLabel = [[UILabel alloc] init];
    self.userPhoneLabel.text = @"用户手机";
    self.userPhoneLabel.textColor = GrayH1;
    self.userPhoneLabel.font = TwelveTypeface;
    [self.cellBackView addSubview:self.userPhoneLabel];
    /** 用户车牌号 */
    self.userPlnLabel = [[UILabel alloc] init];
    self.userPlnLabel.text = @"用户车牌号";
    self.userPlnLabel.textColor = Black;
    self.userPlnLabel.font = TwelveTypeface;
    [self.cellBackView addSubview:self.userPlnLabel];
    /** cell尖头 */
    self.cellArroryImage = [[UIImageView alloc] init];
    self.cellArroryImage.image = [UIImage imageNamed:@"right_arrow"];
    [self.cellBackView addSubview:self.cellArroryImage];
    /** 分割线 */
    self.dividingLineView = [[UIView alloc] init];
    self.dividingLineView.backgroundColor = DividingLine;
    [self.cellBackView addSubview:self.dividingLineView];
}

- (void)setConflictUserModel:(UserModel *)conflictUserModel {
    _conflictUserModel = conflictUserModel;
    /** cell选中标记 */
//    @property (strong, nonatomic) UIButton *cellSelectedBtn;
    /** 用户头像图片 */
    [self.userHeadImage setImageWithImageUrl:conflictUserModel.avatar_thumb perchImage:@"placeholder_search_user"];
    /** 用户名称 */
    self.userNameLabel.text = conflictUserModel.name;
    /** 用户手机 */
    self.userPhoneLabel.text = conflictUserModel.mobile;
    /** 用户车牌号 */
    self.userPlnLabel.text = conflictUserModel.car_plate_no;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** cell背景view */
    [self.cellBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    /** cell选中标记 */
    [self.cellSelectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cellBackView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    /** 用户头像图片 */
    [self.userHeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cellBackView.mas_centerY);
        make.left.equalTo(self.cellSelectedBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(52, 52));
    }];
    /** 用户名称 */
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cellBackView.mas_centerY).offset(-10);
        make.left.equalTo(self.userHeadImage.mas_right).offset(16);
    }];
    /** 用户手机 */
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cellBackView.mas_centerY).offset(10);
        make.left.equalTo(self.userHeadImage.mas_right).offset(16);
    }];
    /** cell尖头 */
    [self.cellArroryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.userHeadImage.mas_centerY);
        make.right.equalTo(self.cellBackView.mas_right).offset(-16);
    }];
    /** 用户车牌号 */
    [self.userPlnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.userHeadImage.mas_centerY);
        make.right.equalTo(self.cellArroryImage.mas_left).offset(-16);
    }];
    /** 分割线 */
    [self.dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.cellBackView.mas_bottom);
        make.left.equalTo(self.userHeadImage.mas_left);
        make.right.equalTo(self.cellBackView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
}


@end
