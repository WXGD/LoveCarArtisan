//
//  CardTypeChoiceCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardTypeChoiceCell.h"

@implementation CardTypeChoiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEARCOLOR;
        /** 选择卡类型模型 */
        self.cardInfoCellView = [[OpenCardInfoView alloc] init];
        [self.contentView addSubview:self.cardInfoCellView];
        /** 选择卡按钮 */
        self.choiceCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.choiceCardBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [self.choiceCardBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        self.choiceCardBtn.backgroundColor = HEXSTR_RGB(@"fafafa");
        [self.contentView addSubview:self.choiceCardBtn];
    }
    return self;
}

/** 会员卡信息模型 */
- (void)setCardInfoModel:(CardTypeModel *)cardInfoModel {
    _cardInfoModel = cardInfoModel;
    /** 卡号 */
    self.cardInfoCellView.cardNumLabel.text = [NSString stringWithFormat:@"%03ld", cardInfoModel.code];
    /** 卡名称 */
    self.cardInfoCellView.cardNameLabel.text = cardInfoModel.name;
    /** 卡类型 */
    switch (cardInfoModel.card_category_id) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            self.cardInfoCellView.cardTypeLabel.text = @"次卡";
            /** 可用次数 */
            self.cardInfoCellView.canNumMoneyLabel.leftText.text = @"可用次数:";
            /** 可用次数 */
            self.cardInfoCellView.canNumMoneyLabel.rightText.text = [NSString stringWithFormat:@"%ld次", cardInfoModel.available_num];
            break;
        }
        case 2: {
            self.cardInfoCellView.cardTypeLabel.text = @"储值卡";
            /** 可用金额 */
            self.cardInfoCellView.canNumMoneyLabel.leftText.text = @"可用金额:";
            /** 可用金额 */
            self.cardInfoCellView.canNumMoneyLabel.rightText.text = [NSString stringWithFormat:@"%.2f元", cardInfoModel.face_money];
            break;
        }
        case 3: {
            self.cardInfoCellView.cardTypeLabel.text = @"年卡";
            /** 可用次数 */
            self.cardInfoCellView.canNumMoneyLabel.leftText.text = @"可用年限:";
            /** 可用次数 */
            self.cardInfoCellView.canNumMoneyLabel.rightText.text = [NSString stringWithFormat:@"%ld年", cardInfoModel.available_year];;
            break;
        }
        default:
            break;
    }
    /** 可用服务 */
    self.cardInfoCellView.availableServiceLabel.text = cardInfoModel.used_goods_text;
    /** 原价 */
    self.cardInfoCellView.costPriceLabel.rightText.text = [NSString stringWithFormat:@"%.2f元", cardInfoModel.price];
    /** 选择卡按钮 */
    self.choiceCardBtn.selected = cardInfoModel.checkMark;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 选择卡按钮 */
    [self.choiceCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(@55);
    }];
    /** 选择卡类型模型 */
    [self.cardInfoCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.choiceCardBtn.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

@end
