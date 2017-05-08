//
//  CreditCardTableViewCell.m
//  CarRepairFactory
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CreditCardTableViewCell.h"
#import "CreditCardCellView.h"

@interface CreditCardTableViewCell ()

/** 会员卡cell */
@property (strong, nonatomic) CreditCardCellView *creditCardCellView;

@end

@implementation CreditCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.creditCardCellView = [[CreditCardCellView alloc] init];
        self.creditCardCellView.layer.masksToBounds = YES;
        self.creditCardCellView.layer.cornerRadius = 5;
        self.creditCardCellView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.creditCardCellView];
    }
    return self;
}

- (void)setUserCard:(UserMemberCardModel *)userCard {
    _userCard = userCard;
    /** 卡名称 */
    self.creditCardCellView.cardType.text = userCard.name;
    /** 卡号 */
    self.creditCardCellView.cardNumberLabel.text = userCard.card_no;
    if (userCard.end_time.length != 0) {
        /** 有效期 */
        self.creditCardCellView.expiryDate.text = userCard.end_time;
    }else {
        /** 有效期 */
        self.creditCardCellView.expiryDate.text = @"无限";
    }
    // 判断是次卡还是储值卡
    if (self.userCard.card_category_id == 1) { // 次卡
        /** 余次 */
        self.creditCardCellView.balanceTitle.text = @"余次";
        self.creditCardCellView.balance.text = [NSString stringWithFormat:@"%ld", (long)userCard.num];
    }else if (self.userCard.card_category_id == 2) { // 金额卡
        /** 余额 */
        self.creditCardCellView.balanceTitle.text = @"余额";
        self.creditCardCellView.balance.text = [NSString stringWithFormat:@"%.2f", userCard.money];
    }else if (self.userCard.card_category_id == 3) { // 年卡
        /** 余次 */
        self.creditCardCellView.balanceTitle.text = @"余次";
        self.creditCardCellView.balance.text = @"无限";
    }
    // 判断会员卡是否可用
    if (userCard.is_used) { // 可用
        /** 卡类型 */
        self.creditCardCellView.cardTypeImage.image = [UIImage imageNamed:@"user_card_logo_available"];
        /** 卡类型 */
        self.creditCardCellView.cardType.textColor = Black;
        /** 卡号 */
        self.creditCardCellView.cardNumberLabel.textColor = Black;
        /** 余额标题 */
        self.creditCardCellView.balanceTitle.textColor = HEXSTR_RGB(@"9a9a9a");
        /** 余额 */
        self.creditCardCellView.balance.textColor = Black;
        /** 有效期 */
        self.creditCardCellView.expiryDate.textColor = Black;
        /** 有效期标题 */
        self.creditCardCellView.expiryDateTitle.textColor = HEXSTR_RGB(@"9a9a9a");
    }else {
        self.creditCardCellView.cardTypeImage.image = [UIImage imageNamed:@"user_card_logo_no_available"];        
        /** 卡类型 */
        self.creditCardCellView.cardType.textColor = NotClick;
        /** 卡号 */
        self.creditCardCellView.cardNumberLabel.textColor = NotClick;
        /** 余额标题 */
        self.creditCardCellView.balanceTitle.textColor = NotClick;
        /** 余额 */
        self.creditCardCellView.balance.textColor = NotClick;
        /** 有效期 */
        self.creditCardCellView.expiryDate.textColor = NotClick;
        /** 有效期标题 */
        self.creditCardCellView.expiryDateTitle.textColor = NotClick;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.creditCardCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
