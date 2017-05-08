//
//  ShortcutView.m
//  TradePlatform
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShortcutView.h"

@implementation ShortcutView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self shortcutMethodLayoutView];
    }
    return self;
}

- (void)shortcutMethodLayoutView {
    /** 新增服务 */
    self.speedAddScrview = [[UsedCellView alloc] init];
    self.speedAddScrview.cellImage.image = [UIImage imageNamed:@"home_page_add_service"];
    self.speedAddScrview.cellLabel.text = @"新增服务";
    self.speedAddScrview.cellLabel.font = FifteenTypeface;
    self.speedAddScrview.isArrow = YES;
    self.speedAddScrview.usedCellBtn.tag = SpeedAddScrviewBtnAction;
    [self addSubview:self.speedAddScrview];
    /** 新增客户 */
    self.speedAddUser = [[UsedCellView alloc] init];
    self.speedAddUser.cellImage.image = [UIImage imageNamed:@"home_page_add_user"];
    self.speedAddUser.cellLabel.text = @"新增用户";
    self.speedAddUser.cellLabel.font = FifteenTypeface;
    self.speedAddUser.isArrow = YES;
    self.speedAddUser.usedCellBtn.tag = SpeedAddUserBtnAction;
    [self addSubview:self.speedAddUser];
    /** 开卡 */
    self.speedOpenCard = [[UsedCellView alloc] init];
    self.speedOpenCard.cellImage.image = [UIImage imageNamed:@"home_page_open_card"];
    self.speedOpenCard.cellLabel.text = @"自定义开卡";
    self.speedOpenCard.cellLabel.font = FifteenTypeface;
    self.speedOpenCard.isArrow = YES;
    self.speedOpenCard.usedCellBtn.tag = SpeedOpenCardBtnAction;
    [self addSubview:self.speedOpenCard];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    @weakify(self)
    /** 新增服务 */
    [self.speedAddScrview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@50);
    }];
    /** 新增客户 */
    [self.speedAddUser mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.speedAddScrview.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 开卡 */
    [self.speedOpenCard mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.speedAddUser.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
}


@end
