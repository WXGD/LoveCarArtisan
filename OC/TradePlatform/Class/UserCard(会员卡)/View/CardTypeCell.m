//
//  CardTypeCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardTypeCell.h"
#import "CardTypeCellView.h"

@implementation CardTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEARCOLOR;
        /** 卡类型cellview */
        self.cardTypeCellView = [[CardTypeCellView alloc] init];
        [self.contentView addSubview:self.cardTypeCellView];
    }
    return self;
}



/** 卡类型模型 */
- (void)setCardTypeModel:(CardTypeModel *)cardTypeModel {
    _cardTypeModel = cardTypeModel;
    /** 卡号 */
    self.cardTypeCellView.cardNumLabel.text = [NSString stringWithFormat:@"%03ld", cardTypeModel.code];
    /** 卡名称 */
    self.cardTypeCellView.cardNameLabel.text = cardTypeModel.name;
    /** 卡类型 */
    switch (cardTypeModel.card_category_id) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            self.cardTypeCellView.cardTypeLabel.text = @"次卡";
            break;
        }
        case 2: {
            self.cardTypeCellView.cardTypeLabel.text = @"储值卡";
            break;
        }
        case 3: {
            self.cardTypeCellView.cardTypeLabel.text = @"年卡";
            break;
        }
        default:
            break;
    }
    /** 可用服务 */
    self.cardTypeCellView.availableServiceLabel.text = cardTypeModel.used_goods_text;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡类型cellview */
    [self.cardTypeCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

@end
