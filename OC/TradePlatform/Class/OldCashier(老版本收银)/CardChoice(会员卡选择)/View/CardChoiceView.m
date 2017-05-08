//
//  CardChoiceView.m
//  TradePlatform
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardChoiceView.h"
#import "CreditCardTableViewCell.h"
#import "UserMemberCardModel.h"

@interface CardChoiceView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation CardChoiceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cardChoiceLayoutView];
    }
    return self;
}

- (void)cardChoiceLayoutView {
    /** 会员卡table */
    self.cardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.cardTableView.backgroundColor = [UIColor clearColor];
    self.cardTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.cardTableView.delegate = self;
    self.cardTableView.dataSource = self;
    [self addSubview:self.cardTableView];
    // tableview高度随数据高度变化而变化
    [self.cardTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}


#pragma mark - tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSMutableArray *noUserCard = [self.cardArray lastObject];
    if (noUserCard.count == 0) {
        return 1;
    }
    return self.cardArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *userCard = [self.cardArray objectAtIndex:section];
    return userCard.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CreditCardsChoiceTableCell";
    CreditCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CreditCardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSMutableArray *usedCard = [self.cardArray objectAtIndex:indexPath.section];
    UserMemberCardModel *userCard = [usedCard objectAtIndex:indexPath.row];
    cell.userCard = userCard;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else {
        return 45;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self sectionHeaderView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(cardChoicedidSelectAction:)]) {
        [_delegate cardChoicedidSelectAction:indexPath];
    }
}


#pragma mark - 区头view
- (UIView *)sectionHeaderView {
    UIView *notAvailableView = [[UIView alloc] init];
    notAvailableView.backgroundColor = VCBackground;
    
    UILabel *notAvailableLabel = [[UILabel alloc] init];
    notAvailableLabel.text = @"不可用卡";
    notAvailableLabel.font = FourteenTypeface;
    notAvailableLabel.textColor = Black;
    [notAvailableView addSubview:notAvailableLabel];
    [notAvailableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(notAvailableView.mas_centerX);
        make.centerY.equalTo(notAvailableView.mas_centerY).offset(7.5);
    }];
    /********************** 虚线 **************************/
    // 左边虚线
    UIView *leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = HEXSTR_RGB(@"e5e5e5");
    [notAvailableView addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(notAvailableView.mas_left).offset(16);
        make.centerY.equalTo(notAvailableLabel.mas_centerY);
        make.right.equalTo(notAvailableLabel.mas_left).offset(-30);
        make.height.mas_equalTo(@1);
    }];
    // 右边虚线
    UIView *rightLineView = [[UIView alloc] init];
    rightLineView.backgroundColor = HEXSTR_RGB(@"e5e5e5");
    [notAvailableView addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(notAvailableLabel.mas_right).offset(30);
        make.centerY.equalTo(notAvailableLabel.mas_centerY);
        make.right.equalTo(notAvailableView.mas_right).offset(-16);
        make.height.mas_equalTo(@1);
    }];
    return notAvailableView;
}


@end
