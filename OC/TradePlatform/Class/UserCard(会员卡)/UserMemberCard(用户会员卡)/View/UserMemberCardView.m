//
//  UserMemberCardView.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserMemberCardView.h"

@interface UserMemberCardView ()<UITableViewDelegate, UITableViewDataSource>

/** 头部背景 */
@property (strong, nonatomic) UIView *headerBackView;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation UserMemberCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self userMemberCardLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)userMemberCardLayoutView {
    /** 头部背景 */
    self.headerBackView = [[UIView alloc] init];
    self.headerBackView.backgroundColor = ThemeColor;
    [self addSubview:self.headerBackView];
    /** 总储值次数 */
    self.totalSaveNumLabel = [[TopBotText alloc] init];
    self.totalSaveNumLabel.topText.text = @"储值次数";
    self.totalSaveNumLabel.topText.textColor = RGBA(255, 255, 255, 0.5);
    self.totalSaveNumLabel.topText.font = ThirteenTypeface;
    self.totalSaveNumLabel.bomText.text = @"储值次数";
    self.totalSaveNumLabel.bomText.textColor = WhiteColor;
    self.totalSaveNumLabel.bomText.font = SixteenTypeface;
    [self.headerBackView addSubview:self.totalSaveNumLabel];
    /** 分割线 */
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = RGBA(255, 255, 255, 0.6);
    [self.headerBackView addSubview:self.lineView];
    /** 总储值金额 */
    self.totalSaveMoneyLabel = [[TopBotText alloc] init];
    self.totalSaveMoneyLabel.topText.text = @"储值金额";
    self.totalSaveMoneyLabel.topText.textColor = RGBA(255, 255, 255, 0.5);
    self.totalSaveMoneyLabel.topText.font = ThirteenTypeface;
    self.totalSaveMoneyLabel.bomText.text = @"储值金额";
    self.totalSaveMoneyLabel.bomText.textColor = WhiteColor;
    self.totalSaveMoneyLabel.bomText.font = SixteenTypeface;
    [self.headerBackView addSubview:self.totalSaveMoneyLabel];
    /** 用户会员卡列表table */
    self.userMemberCardTypeTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.userMemberCardTypeTable.delegate = self;
    self.userMemberCardTypeTable.dataSource = self;
    self.userMemberCardTypeTable.backgroundColor = CLEARCOLOR;
    self.userMemberCardTypeTable.rowHeight = 140;
    self.userMemberCardTypeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.userMemberCardTypeTable];
    // tableview高度随数据高度变化而变化
    [self.userMemberCardTypeTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 头部背景 */
    [self.headerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@85);
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.headerBackView.mas_centerY);
        make.centerX.equalTo(self.headerBackView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(0.5, 30));
    }];
    /** 总储值次数 */
    [self.totalSaveNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.headerBackView.mas_centerY);
        make.left.equalTo(self.headerBackView.mas_left);
        make.right.equalTo(self.lineView.mas_left);
    }];
    /** 总储值金额 */
    [self.totalSaveMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.headerBackView.mas_centerY);
        make.left.equalTo(self.lineView.mas_right);
        make.right.equalTo(self.headerBackView.mas_right);
    }];
    /** 用户会员卡列表table */
    [self.userMemberCardTypeTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerBackView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];

}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userMemberCardTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"userMemberCardCell";
    UserMemberCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UserMemberCardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.userMemberCardModel = [self.userMemberCardTypeArray objectAtIndex:indexPath.row];
    /** 编辑 */
    cell.userMemberCardCellView.editBtn.tag = indexPath.row;
    [cell.userMemberCardCellView.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 充值 */
    cell.userMemberCardCellView.rechargeBtn.tag = indexPath.row;
    [cell.userMemberCardCellView.rechargeBtn addTarget:self action:@selector(rechargeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

/** 编辑 */
- (void)editBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(editClickAction:)]) {
        [_delegate editClickAction:button.tag];
    }
}
/** 充值 */
- (void)rechargeBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(rechargeClickAction:)]) {
        [_delegate rechargeClickAction:button.tag];
    }
}

@end
