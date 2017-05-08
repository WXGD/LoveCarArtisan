//
//  OrderTypeTitleView.m
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderTypeTitleView.h"
#import "TopBotBtn.h"

@interface OrderTypeTitleView ()

/** 日期 */
@property (strong, nonatomic) TopBotBtn *dateText;
/** 客户数量 */
@property (strong, nonatomic) TopBotBtn *customerText;
/** 交易额 */
@property (strong, nonatomic) TopBotBtn *turnoverText;

@end

@implementation OrderTypeTitleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self orderTypeTitleLayoutView];
    }
    return self;
}

- (void)orderTypeTitleLayoutView {
    /** 日期 */
    self.dateText = [[TopBotBtn alloc] init];
    self.dateText.backgroundColor = WhiteColor;
    self.dateText.distanceFrame = 5;
    self.dateText.faxSpacing = 5;
    self.dateText.bomText.text = @"日期";
    self.dateText.topImage.image = [UIImage imageNamed:@"date_order_title"];
    [self addSubview:self.dateText];
    /** 客户数量 */
    self.customerText = [[TopBotBtn alloc] init];
    self.customerText.backgroundColor = WhiteColor;
    self.customerText.distanceFrame = 5;
    self.customerText.faxSpacing = 5;
    self.customerText.bomText.text = @"客户数量";
    self.customerText.topImage.image = [UIImage imageNamed:@"customer_order_title"];
    [self addSubview:self.customerText];
    /** 交易额 */
    self.turnoverText = [[TopBotBtn alloc] init];
    self.turnoverText.backgroundColor = WhiteColor;
    self.turnoverText.distanceFrame = 5;
    self.turnoverText.faxSpacing = 5;
    self.turnoverText.bomText.text = @"交易额";
    self.turnoverText.topImage.image = [UIImage imageNamed:@"turnover_by_order_title"];
    [self addSubview:self.turnoverText];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 客户数量 */
    [self.customerText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** 日期 */
    [self.dateText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.customerText.mas_left);
    }];
    /** 交易额 */
    [self.turnoverText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.customerText.mas_right);
        make.right.equalTo(self.mas_right);
    }];
    /** 日期,客户数量,交易额 */
    [@[self.dateText, self.customerText, self.turnoverText] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(5);
        make.width.equalTo(self.dateText.mas_width);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
