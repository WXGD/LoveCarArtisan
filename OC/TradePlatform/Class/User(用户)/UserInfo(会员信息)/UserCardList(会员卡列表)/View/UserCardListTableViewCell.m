//
//  UserCardListTableViewCell.m
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardListTableViewCell.h"

@interface UserCardListTableViewCell ()


@end

@implementation UserCardListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userCardListCellView = [[UserCardListCellView alloc] init];
        self.userCardListCellView.layer.masksToBounds = YES;
        self.userCardListCellView.layer.cornerRadius = 5;
        [self.contentView addSubview:self.userCardListCellView];
    }
    return self;
}



- (void)setUserCardModel:(UserMemberCardModel *)userCardModel {
    _userCardModel = userCardModel;
    /** 卡名称 */
    self.userCardListCellView.cardType.text = userCardModel.name;
    /** 卡号 */
    self.userCardListCellView.cardNumberLabel.text = userCardModel.card_no;
    /** 有效期 */
    self.userCardListCellView.expiryDate.text = userCardModel.end_time;
    /** 可用服务内容 */
    self.userCardListCellView.availableServiceContent.text = userCardModel.used_goods_text;
    // 判断会员卡是否过期
    if (userCardModel.end_time.length == 0) {
        /** 卡类型 */
        self.userCardListCellView.cardTypeImage.image = [UIImage imageNamed:@"user_card_logo_available"];
        /** 卡背景图片 */
        self.userCardListCellView.cardBackImage.image = [UIImage imageNamed:@"card_back"];
        /** 可用服务尖头 */
        self.userCardListCellView.availableServiceArraw.image = [UIImage imageNamed:@"card_bottom_arrow"];
        /** 有效期 */
        self.userCardListCellView.expiryDate.text = @"永久";
    }else if (userCardModel.is_expire == 0) { // 未过期
        /** 卡类型 */
        self.userCardListCellView.cardTypeImage.image = [UIImage imageNamed:@"user_card_logo_available"];
        /** 卡背景图片 */
        self.userCardListCellView.cardBackImage.image = [UIImage imageNamed:@"card_back"];
        /** 可用服务尖头 */
        self.userCardListCellView.availableServiceArraw.image = [UIImage imageNamed:@"card_bottom_arrow"];
    }else  if (userCardModel.is_expire == 1) { // 过期
        /** 卡背景图片 */
        self.userCardListCellView.cardBackImage.image = [UIImage imageNamed:@"card_expired_back"];
        /** 卡类型 */
        self.userCardListCellView.cardTypeImage.image = [UIImage imageNamed:@"user_card_logo_no_available"];
        /** 可用服务尖头 */
        self.userCardListCellView.availableServiceArraw.image = [UIImage imageNamed:@"card_bottom_arrow_expired"];
        /** 卡类型 */
        self.userCardListCellView.cardType.textColor = RGB(187, 187, 187);
        /** 卡号 */
        self.userCardListCellView.cardNumberLabel.textColor = RGB(187, 187, 187);
        /** 可用服务内容 */
        self.userCardListCellView.availableServiceContent.textColor = RGB(187, 187, 187);
        /** 余额标题 */
        self.userCardListCellView.balanceTitle.textColor = RGB(187, 187, 187);
        /** 余额 */
        self.userCardListCellView.balance.textColor = RGB(187, 187, 187);
        /** 有效期 */
        self.userCardListCellView.expiryDate.textColor = RGB(187, 187, 187);
        /** 有效期标题 */
        self.userCardListCellView.expiryDateTitle.textColor = RGB(187, 187, 187);
    }
    // 判断是次卡还是储值卡
    if (self.userCardModel.card_category_id == 1) { // 次卡
        /** 余次 */
        self.userCardListCellView.balanceTitle.text = @"余次：";
        self.userCardListCellView.balance.text = [NSString stringWithFormat:@"%ld", (long)userCardModel.num];
    }else if (self.userCardModel.card_category_id == 2) { // 金额卡
        /** 余额 */
        self.userCardListCellView.balanceTitle.text = @"余额：";
        self.userCardListCellView.balance.text = [NSString stringWithFormat:@"%.2f", userCardModel.money];
    }else if (self.userCardModel.card_category_id == 3) { // 年卡
        /** 余次 */
        self.userCardListCellView.balanceTitle.text = @"余次：";
        self.userCardListCellView.balance.text = @"无限";
    }
    // 判断充值，编辑按钮是否可用
    if (userCardModel.is_expire == 0 && self.userCardModel.card_category_id != 3) { // 未过期且不是年卡，充值，编辑按钮都可用
        /** 充值 */
        [self.userCardListCellView.rechargeBtn setUserInteractionEnabled:YES];
        [self.userCardListCellView.rechargeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        /** 编辑 */
        [self.userCardListCellView.editBtn setUserInteractionEnabled:YES];
        [self.userCardListCellView.editBtn setTitleColor:Black forState:UIControlStateNormal];
    }else if (userCardModel.is_expire == 0 && self.userCardModel.card_category_id == 3) { // 未过期,但是是年卡，充值不可用，编辑可用
        /** 充值 */
        [self.userCardListCellView.rechargeBtn setUserInteractionEnabled:NO];
        [self.userCardListCellView.rechargeBtn setTitleColor:NotClick forState:UIControlStateNormal];
        /** 编辑 */
        [self.userCardListCellView.editBtn setUserInteractionEnabled:YES];
        [self.userCardListCellView.editBtn setTitleColor:Black forState:UIControlStateNormal];
    }else  if (userCardModel.is_expire == 1){ // 过期卡,充值，编辑都不可用
        /** 充值 */
        [self.userCardListCellView.rechargeBtn setUserInteractionEnabled:NO];
        [self.userCardListCellView.rechargeBtn setTitleColor:NotClick forState:UIControlStateNormal];
        /** 编辑 */
        [self.userCardListCellView.editBtn setUserInteractionEnabled:NO];
        [self.userCardListCellView.editBtn setTitleColor:NotClick forState:UIControlStateNormal];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.userCardListCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom);
    }];
}



@end
