//
//  SearchUserCardViewCell.m
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchUserCardViewCell.h"

@interface SearchUserCardViewCell ()

/** 车辆信息view */
@property (strong, nonatomic) UIView *carInfoView;
/** 卡名称 */
@property (strong, nonatomic) UILabel *cardNameLabel;
/** 对应用户手机号 */
@property (strong, nonatomic) UILabel *userPhoneLabel;
/** 对应用户车票号 */
@property (strong, nonatomic) UILabel *userPlnLabel;
/** 剩余次数 */
@property (strong, nonatomic) UILabel *remNumLabel;
/** 操作按钮view */
@property (strong, nonatomic) UIView *operaBtnView;

@end

@implementation SearchUserCardViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = VCBackground;
        /** 车辆信息view */
        self.carInfoView = [[UIView alloc] init];
        self.carInfoView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.carInfoView];
        /** 卡名称 */
        self.cardNameLabel = [[UILabel alloc] init];
        self.cardNameLabel.font = FourteenTypeface;
        self.cardNameLabel.textColor = Black;
        [self.carInfoView addSubview:self.cardNameLabel];
        /** 对应用户手机号 */
        self.userPhoneLabel = [[UILabel alloc] init];
        self.userPhoneLabel.font = FourteenTypeface;
        self.userPhoneLabel.textColor = GrayH1;
        [self.carInfoView addSubview:self.userPhoneLabel];
        
        /** 对应用户车票号 */
        self.userPlnLabel = [[UILabel alloc] init];
        self.userPlnLabel.font = FourteenTypeface;
        self.userPlnLabel.textColor = GrayH1;
        [self.carInfoView addSubview:self.userPlnLabel];
        
        /** 剩余次数 */
        self.remNumLabel = [[UILabel alloc] init];
        self.remNumLabel.font = TwelveTypeface;
        self.remNumLabel.textColor = GrayH1;
        [self.carInfoView addSubview:self.remNumLabel];
        
        /** 操作按钮view */
        self.operaBtnView = [[UIView alloc] init];
        self.operaBtnView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.operaBtnView];
        /** 编辑按钮 */
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
        self.editBtn.titleLabel.font = TwelveTypeface;
        self.editBtn.layer.masksToBounds = YES;
        self.editBtn.layer.cornerRadius = 2;
        self.editBtn.layer.borderWidth = 0.5;
        self.editBtn.layer.borderColor = NotClick.CGColor;
        [self.operaBtnView addSubview:self.editBtn];
        /** 充值按钮 */
        self.rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [self.rechargeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        self.rechargeBtn.titleLabel.font = TwelveTypeface;
        self.rechargeBtn.layer.masksToBounds = YES;
        self.rechargeBtn.layer.cornerRadius = 2;
        self.rechargeBtn.layer.borderWidth = 0.5;
        self.rechargeBtn.layer.borderColor = ThemeColor.CGColor;
        [self.operaBtnView addSubview:self.rechargeBtn];
    }
    return self;
}

- (void)setUserCardModel:(UserMemberCardModel *)userCardModel {
    _userCardModel = userCardModel;
    /** 卡名称 */
    self.cardNameLabel.text = [NSString stringWithFormat:@"%@（%@）", userCardModel.card_name, userCardModel.card_no];
    /** 对应用户手机号 */
    self.userPhoneLabel.text = userCardModel.mobile;
    /** 对应用户车票号 */
    self.userPlnLabel.text = userCardModel.car_plate_no;
    /** 剩余次数 */
    // 判断是次卡还是储值卡
    if (userCardModel.card_category_id == 1) { // 次卡
        /** 余次 */
        self.remNumLabel.text = [NSString stringWithFormat:@"余次:%ld次", userCardModel.num];
        // 充值按钮状态
        [self.rechargeBtn setUserInteractionEnabled:YES];
        [self.rechargeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        self.rechargeBtn.layer.borderColor = ThemeColor.CGColor;
        self.rechargeBtn.backgroundColor = WhiteColor;
    }else if (userCardModel.card_category_id == 2) { // 金额卡
        /** 余额 */
        self.remNumLabel.text = [NSString stringWithFormat:@"余额:%.2f元", userCardModel.money];
        // 充值按钮状态
        [self.rechargeBtn setUserInteractionEnabled:YES];
        [self.rechargeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        self.rechargeBtn.layer.borderColor = ThemeColor.CGColor;
        self.rechargeBtn.backgroundColor = WhiteColor;
    }else if (userCardModel.card_category_id == 3) { // 年卡
        /** 余次 */
        self.remNumLabel.text = @"余次:无限";
        // 充值按钮状态
        [self.rechargeBtn setUserInteractionEnabled:NO];
        [self.rechargeBtn setTitleColor:NotClick forState:UIControlStateNormal];
        self.rechargeBtn.layer.borderColor = NotClick.CGColor;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 车辆信息view */
    [self.carInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@72);
    }];
    /** 卡名称 */
    [self.cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.carInfoView.mas_centerY).offset(-5);
        make.left.equalTo(self.carInfoView.mas_left).offset(16);
    }];
    /** 对应用户手机号 */
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardNameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.cardNameLabel.mas_left);
    }];
    /** 剩余次数 */
    [self.remNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.cardNameLabel.mas_centerY);
        make.right.equalTo(self.carInfoView.mas_right).offset(-16);
    }];
    /** 对应用户车票号 */
    [self.userPlnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.userPhoneLabel.mas_centerY);
        make.right.equalTo(self.remNumLabel.mas_right);
    }];
    /** 操作按钮view */
    [self.operaBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carInfoView.mas_bottom).offset(0.5);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@44);
    }];
    /** 充值按钮 */
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.operaBtnView.mas_centerY);
        make.right.equalTo(self.operaBtnView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(62, 22));
    }];
    /** 编辑按钮 */
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.operaBtnView.mas_centerY);
        make.right.equalTo(self.rechargeBtn.mas_left).offset(-24);
        make.size.mas_equalTo(CGSizeMake(62, 22));
    }];
}



@end
