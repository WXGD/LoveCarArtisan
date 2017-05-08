//
//  UserMemberCardCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserMemberCardCell.h"

@implementation UserMemberCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEARCOLOR;
        /** 用户会员卡cellview */
        self.userMemberCardCellView = [[UserMemberCardCellView alloc] init];
        [self.contentView addSubview:self.userMemberCardCellView];
    }
    return self;
}



/** 用户会员卡模型 */
- (void)setUserMemberCardModel:(UserMemberCardModel *)userMemberCardModel {
    _userMemberCardModel = userMemberCardModel;
    /** 卡号 */
    self.userMemberCardCellView.cardNumLabel.text = userMemberCardModel.card_no;
    /** 卡名称 */
    self.userMemberCardCellView.cardNameLabel.text = userMemberCardModel.name;
    /** 余次/余额 */
    /** 卡类型 */
    switch (userMemberCardModel.card_category_id) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            self.userMemberCardCellView.noreThan.leftText.text = @"余次：";
            self.userMemberCardCellView.noreThan.rightText.text = [NSString stringWithFormat:@"%ld", userMemberCardModel.num];
            /** 充值 */
            [self.userMemberCardCellView.rechargeBtn setUserInteractionEnabled:YES];
            [self.userMemberCardCellView.rechargeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
            self.userMemberCardCellView.rechargeBtn.layer.borderColor = ThemeColor.CGColor;
            break;
        }
        case 2: {
            self.userMemberCardCellView.noreThan.leftText.text = @"余额：";
            self.userMemberCardCellView.noreThan.rightText.text = [NSString stringWithFormat:@"%.2f", userMemberCardModel.money];
            /** 充值 */
            [self.userMemberCardCellView.rechargeBtn setUserInteractionEnabled:YES];
            [self.userMemberCardCellView.rechargeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
            self.userMemberCardCellView.rechargeBtn.layer.borderColor = ThemeColor.CGColor;
            break;
        }
        case 3: {
            self.userMemberCardCellView.noreThan.leftText.text = @"余次：";
            self.userMemberCardCellView.noreThan.rightText.text = @"无限";
            /** 充值 */
            [self.userMemberCardCellView.rechargeBtn setUserInteractionEnabled:NO];
            [self.userMemberCardCellView.rechargeBtn setTitleColor:NotClick forState:UIControlStateNormal];
            self.userMemberCardCellView.rechargeBtn.layer.borderColor = NotClick.CGColor;
            break;
        }
        default:
            break;
    }
    /** 客户手机 */
    self.userMemberCardCellView.userPhone.rightText.text = userMemberCardModel.mobile;
    /** 有效期 */
    if (userMemberCardModel.end_time.length != 0) {
        self.userMemberCardCellView.expiryDate.rightText.text = userMemberCardModel.end_time;
    }else {
        self.userMemberCardCellView.expiryDate.rightText.text = @"永久";
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 用户会员卡cellview */
    [self.userMemberCardCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

@end
