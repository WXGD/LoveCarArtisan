//
//  UserCardView.m
//  TradePlatform
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardView.h"

@interface UserCardView ()<UITableViewDelegate, UITableViewDataSource>

/** 头部背景图片 */
@property (strong, nonatomic) UIImageView *headerBackImage;
/** 分割线 */
@property (strong, nonatomic) UIView *userCardHeaderLineView;
/** tableHeader */
@property (strong, nonatomic) UIView *tableHeader;


@end

@implementation UserCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self userCardViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)userCardViewLayoutView {

    /** 头部背景图片 */
    self.headerBackImage = [[UIImageView alloc] init];
    self.headerBackImage.image = [UIImage imageNamed:@"header_choice_back"];
    self.headerBackImage.userInteractionEnabled = YES;
    [self addSubview:self.headerBackImage];
    /** 新增卡类型 */
    self.addCardTypeBtn = [[TopBotBtn alloc] init];
    self.addCardTypeBtn.distanceFrame = 22;
    self.addCardTypeBtn.faxSpacing = 10;
    self.addCardTypeBtn.bomText.text = @"新增卡";
    self.addCardTypeBtn.bomText.textColor = WhiteColor;
    self.addCardTypeBtn.bomText.font = FifteenTypeface;
    self.addCardTypeBtn.topImage.image = [UIImage imageNamed:@"add_card_type"];
    self.addCardTypeBtn.topBotBtn.tag = AddCardTypeBtnAction;
    [self.headerBackImage addSubview:self.addCardTypeBtn];
    /** 分割线 */
    self.userCardHeaderLineView = [[UIView alloc] init];
    self.userCardHeaderLineView.backgroundColor = RGBA(255, 255, 255, 0.6);
    [self.headerBackImage addSubview:self.userCardHeaderLineView];
    /** 自定义开卡 */
    self.customOpenCardBtn = [[TopBotBtn alloc] init];
    self.customOpenCardBtn.distanceFrame = 22;
    self.customOpenCardBtn.faxSpacing = 10;
    self.customOpenCardBtn.bomText.text = @"自定义开卡";
    self.customOpenCardBtn.bomText.textColor = WhiteColor;
    self.customOpenCardBtn.bomText.font = FifteenTypeface;
    self.customOpenCardBtn.topImage.image = [UIImage imageNamed:@"custom_open_card"];
    self.customOpenCardBtn.topBotBtn.tag = CustomOpenCardBtnAction;
    [self.headerBackImage addSubview:self.customOpenCardBtn];
    /** 会员卡类型列表table */
    self.userCardTypeTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.userCardTypeTable.delegate = self;
    self.userCardTypeTable.dataSource = self;
    self.userCardTypeTable.backgroundColor = CLEARCOLOR;
    self.userCardTypeTable.rowHeight = 140;
    self.userCardTypeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.userCardTypeTable];
    // tableview高度随数据高度变化而变化
    [self.userCardTypeTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    /** tableHeader */
    self.tableHeader = [[UIView alloc] init];
    self.userCardTypeTable.tableHeaderView = self.tableHeader;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 头部背景图片 */
    [self.headerBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 分割线 */
    [self.userCardHeaderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.headerBackImage.mas_centerY);
        make.centerX.equalTo(self.headerBackImage.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(0.5, 30));
    }];
    /** 新增卡类型 */
    [self.addCardTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerBackImage.mas_top);
        make.left.equalTo(self.headerBackImage.mas_left);
        make.right.equalTo(self.userCardHeaderLineView.mas_left);
    }];
    /** 自定义开卡 */
    [self.customOpenCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerBackImage.mas_top);
        make.left.equalTo(self.userCardHeaderLineView.mas_right);
        make.right.equalTo(self.headerBackImage.mas_right);
    }];
    /** 会员卡类型列表table */
    [self.userCardTypeTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerBackImage.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** tableHeader */
    [self.tableHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userCardTypeTable.mas_left);
        make.right.equalTo(self.userCardTypeTable.mas_right);
        make.height.mas_equalTo(@10);
    }];
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userCardTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cardTypeCell";
    CardTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CardTypeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    // 模型赋值
    cell.cardTypeModel = [self.userCardTypeArray objectAtIndex:indexPath.row];
    /** 用户会员卡 */
    cell.cardTypeCellView.userCardBtn.tag = indexPath.row;
    [cell.cardTypeCellView.userCardBtn addTarget:self action:@selector(userCardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 开卡 */
    cell.cardTypeCellView.openCardBtn.tag = indexPath.row;
    [cell.cardTypeCellView.openCardBtn addTarget:self action:@selector(openCardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:CardTypeCellClickIndexPath:)]) {
        [_delegate tableView:tableView CardTypeCellClickIndexPath:indexPath];
    }
}
// 用户会员卡按钮点击
- (void)userCardBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(userCardClickAction:)]) {
        [_delegate userCardClickAction:button.tag];
    }
}
// 开卡按钮点击
- (void)openCardBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(openCardClickAction:)]) {
        [_delegate openCardClickAction:button.tag];
    }
}



@end
