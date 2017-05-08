//
//  ExpireCell.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import "ExpireCell.h"

@interface ExpireCell ()

/** 背景view */
@property (strong, nonatomic) UIView *expireBackView;
/** 用户名 */
@property (strong, nonatomic) UILabel *userNameLabel;
/** 车牌号 */
@property (strong, nonatomic) UILabel *plnLabel;
/** 卡名称 */
@property (strong, nonatomic) UILabel *cardNameLabel;
/** 卡余额／余次 */
@property (strong, nonatomic) UILabel *surplusLabel;
/** 过期时间 */
@property (strong, nonatomic) UILabel *expireTimeLabel;
/** 手机号 */
@property (strong, nonatomic) UILabel *phoneLabel;
/** 电话图片 */
@property (strong, nonatomic) UIImageView *phoneImage;

@end

@implementation ExpireCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self expireCellLayoutView];
    }
    return self;
}

- (void)expireCellLayoutView {
    /** 背景view */
    self.expireBackView = [[UIView alloc] init];
    self.expireBackView.backgroundColor = WhiteColor;
    self.expireBackView.layer.masksToBounds = YES;
    self.expireBackView.layer.cornerRadius = 2;
    self.expireBackView.layer.borderColor = DividingLine.CGColor;
    self.expireBackView.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.expireBackView];
    /** 用户名 */
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.font = TwelveTypeface;
    self.userNameLabel.textColor = Black;
    [self.expireBackView addSubview:self.userNameLabel];
    /** 车牌号 */
    self.plnLabel = [[UILabel alloc] init];
    self.plnLabel.font = TwelveTypeface;
    self.plnLabel.textColor = Black;
    [self.expireBackView addSubview:self.plnLabel];
    /** 卡名称 */
    self.cardNameLabel = [[UILabel alloc] init];
    self.cardNameLabel.font = TwelveTypeface;
    self.cardNameLabel.textColor = GrayH2;
    [self.expireBackView addSubview:self.cardNameLabel];
    /** 卡余额／余次 */
    self.surplusLabel = [[UILabel alloc] init];
    self.surplusLabel.font = TwelveTypeface;
    self.surplusLabel.textColor = BlueColor;
    [self.expireBackView addSubview:self.surplusLabel];
    /** 过期时间 */
    self.expireTimeLabel = [[UILabel alloc] init];
    self.expireTimeLabel.font = TwelveTypeface;
    self.expireTimeLabel.textColor = Black;
    [self.expireBackView addSubview:self.expireTimeLabel];
    /** 手机号 */
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.font = TwelveTypeface;
    self.phoneLabel.textColor = Black;
    [self.expireBackView addSubview:self.phoneLabel];
    /** 电话图片 */
    self.phoneImage = [[UIImageView alloc] init];
    self.phoneImage.image = [UIImage imageNamed:@"marketing_expire_phone"];
    [self.expireBackView addSubview:self.phoneImage];
}


- (void)setExpircUserModel:(ExpircUserModel *)expircUserModel {
    _expircUserModel = expircUserModel;
    /** 用户名 */
    self.userNameLabel.text = expircUserModel.user_name;
    /** 车牌号 */
    self.plnLabel.text = expircUserModel.car_plate_no;
    /** 卡名称 */
    self.cardNameLabel.text = expircUserModel.card_name;
    /** 过期时间 */
    self.expireTimeLabel.text = expircUserModel.end_time;
    self.expireTimeLabel.textColor = Black;
    /** 手机号 */
    self.phoneLabel.text = expircUserModel.mobile;
    switch (self.expireCellType) {
            /** 会员卡过期 */
        case UserCardExpireCellShowType: {
            switch (expircUserModel.card_category_id) {
                    // 1-次卡
                case 1:  {
                    /** 卡余额／余次 */
                    self.surplusLabel.text = [NSString stringWithFormat:@"余次：%ld次", expircUserModel.num];
                    break;
                }
                    // 2-余额卡
                case 2:  {
                    /** 卡余额／余次 */
                    self.surplusLabel.text = [NSString stringWithFormat:@"余额：%.2f元", expircUserModel.money];
                    break;
                }
                default:
                    break;
            }
            break;
        }
            /** 长期未到店  */
        case longNotShopExpireCellShowType: {
            /** 卡余额／余次 */
            self.expireTimeLabel.text = [NSString stringWithFormat:@"未到店%ld天", expircUserModel.num];
            self.expireTimeLabel.textColor = BlueColor;
            break;
        }
            /** 余额 */
        case BalanceExpireCellShowType: {
            /** 卡余额／余次 */
            self.surplusLabel.text = [NSString stringWithFormat:@"余额：%.2f元", expircUserModel.money];
            break;
        }
            /** 余次 */
        case LeaveSecondExpireCellShowType: {
            /** 卡余额／余次 */
            self.surplusLabel.text = [NSString stringWithFormat:@"余次：%ld次", expircUserModel.num];
            break;
        }
        default:
            break;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [self.expireBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 用户名 */
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.expireBackView.mas_top).offset(21);
        make.left.equalTo(self.expireBackView.mas_left).offset(16);
        make.height.mas_equalTo(@14.5);
    }];
    /** 车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(12);
        make.left.equalTo(self.userNameLabel.mas_left);
        make.height.mas_equalTo(@14.5);
    }];
    /** 卡名称 */
    [self.cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.expireBackView.mas_centerX);
        make.centerY.equalTo(self.userNameLabel.mas_centerY);
        make.height.mas_equalTo(@14.5);
    }];
    /** 卡余额／余次 */
    [self.surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.cardNameLabel.mas_centerX);
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.height.mas_equalTo(@14.5);
    }];
    /** 电话图片 */
    [self.phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.expireBackView.mas_right).offset(-16);
        make.centerY.equalTo(self.expireBackView.mas_centerY);
    }];
    /** 过期时间 */
    [self.expireTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.phoneImage.mas_left).offset(-10);
        make.centerY.equalTo(self.userNameLabel.mas_centerY);
        make.height.mas_equalTo(@14.5);
    }];
    /** 手机号 */
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.expireTimeLabel.mas_right);
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.height.mas_equalTo(@14.5);
    }];
}


@end
