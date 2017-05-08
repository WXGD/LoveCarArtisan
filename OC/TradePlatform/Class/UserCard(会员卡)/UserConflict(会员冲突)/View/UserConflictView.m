//
//  UserConflictView.m
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserConflictView.h"

@interface UserConflictView ()<UITableViewDelegate, UITableViewDataSource>

/** 冲突用户 */
@property (strong, nonatomic) UIStackView *conflictBackView;
/** 冲突提示 */
@property (strong, nonatomic) UIView *conflictPromptView;
/** 冲突提示文字 */
@property (strong, nonatomic) UILabel *conflictPromptLabel;
/** 冲突提示删除按钮 */
@property (strong, nonatomic) UIButton *conflictPromptBtn;
/** 分割线 */
@property (strong, nonatomic) UIView *dividingLineView;
/** 删除view */
@property (strong, nonatomic) UIView *deleteBackView;
/** 用户选择保存的cell */
@property (strong, nonatomic) UserAndPlnViewCell *userSelectedCell;

@end

@implementation UserConflictView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self userConflictViewLayoutView];
    }
    return self;
}

#pragma mark - 按钮点击
// 移除冲突提示
- (void)conflictPromptBtnAction:(UIButton *)button {
    [self.conflictPromptView removeFromSuperview];
    [self.conflictBackView removeArrangedSubview:self.conflictPromptView];
}

// 勾选合并车辆
- (void)mergeBtnAction:(UIButton *)button {
    button.selected = !button.selected;
}

#pragma mark - view布局
- (void)userConflictViewLayoutView {
    /** 冲突用户 */
    self.conflictBackView = [[UIStackView alloc] init];
    self.conflictBackView.axis = UILayoutConstraintAxisVertical;
    [self addSubview:self.conflictBackView];
    /** 冲突提示 */
    self.conflictPromptView = [[UIView alloc] init];
    self.conflictPromptView.backgroundColor = HEXSTR_RGB(@"ffe0b2");
    [self.conflictBackView addArrangedSubview:self.conflictPromptView];
    /** 冲突提示文字 */
    self.conflictPromptLabel = [[UILabel alloc] init];
    self.conflictPromptLabel.font = TwelveTypeface;
    self.conflictPromptLabel.textColor = HEXSTR_RGB(@"e65100");
    self.conflictPromptLabel.text = @"删除一位用户，并把信息合并到另一位用户中！";
    self.conflictPromptLabel.numberOfLines = 0;
    [self.conflictPromptView addSubview:self.conflictPromptLabel];
    /** 冲突提示删除按钮 */
    self.conflictPromptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.conflictPromptBtn setTitle:@"x" forState:UIControlStateNormal];
    [self.conflictPromptBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.conflictPromptBtn addTarget:self action:@selector(conflictPromptBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.conflictPromptView addSubview:self.conflictPromptBtn];
    /** 分割线 */
    self.dividingLineView = [[UIView alloc] init];
    self.dividingLineView.backgroundColor = VCBackground;
    [self.conflictBackView addArrangedSubview:self.dividingLineView];
    /** 冲突用户列表 */
    self.conflictUserTableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.conflictUserTableView.delegate = self;
    self.conflictUserTableView.dataSource = self;
    self.conflictUserTableView.backgroundColor = CLEARCOLOR;
    self.conflictUserTableView.rowHeight = 62;
    self.conflictUserTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.conflictBackView addArrangedSubview:self.conflictUserTableView];
    /** 合并会员卡 */
    self.mergeUserCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mergeUserCardBtn setTitle:@"合并会员卡" forState:UIControlStateNormal];
    [self.mergeUserCardBtn setTitleColor:Black forState:UIControlStateNormal];
    self.mergeUserCardBtn.titleLabel.font = TwelveTypeface;
    [self.mergeUserCardBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.mergeUserCardBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    self.mergeUserCardBtn.backgroundColor = WhiteColor;
    self.mergeUserCardBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.mergeUserCardBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [self.mergeUserCardBtn addTarget:self action:@selector(mergeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mergeUserCardBtn];
    self.mergeUserCardBtn.selected = YES;
    /** 合并会员车辆 */
    self.mergeUserCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mergeUserCarBtn setTitle:@"合并车辆" forState:UIControlStateNormal];
    [self.mergeUserCarBtn setTitleColor:Black forState:UIControlStateNormal];
    self.mergeUserCarBtn.titleLabel.font = TwelveTypeface;
    [self.mergeUserCarBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.mergeUserCarBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    self.mergeUserCarBtn.backgroundColor = WhiteColor;
    self.mergeUserCarBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.mergeUserCarBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [self.mergeUserCarBtn addTarget:self action:@selector(mergeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mergeUserCarBtn];
    self.mergeUserCarBtn.selected = YES;
    /** 删除view */
    self.deleteBackView = [[UIView alloc] init];
    self.deleteBackView.backgroundColor = WhiteColor;
    [self addSubview:self.deleteBackView];
    /** 删除按钮 */
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];;
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:WhiteColor forState:UIControlStateSelected];
    self.deleteBtn.titleLabel.font = FourteenTypeface;
    self.deleteBtn.backgroundColor = ThemeColor;
    self.deleteBtn.layer.masksToBounds = YES;
    self.deleteBtn.layer.cornerRadius = 2;
    [self.deleteBackView addSubview:self.deleteBtn];
    
    
}

#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conflictUserArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"UserConflictViewCell";
    UserAndPlnViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UserAndPlnViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.conflictUserModel = [self.conflictUserArray objectAtIndex:indexPath.row];
    cell.cellSelectedBtn.tag = indexPath.row;
    [cell.cellSelectedBtn addTarget:self action:@selector(cellSelectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
// cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(userCellSelectIndexPath:)]) {
        [_delegate userCellSelectIndexPath:indexPath];
    }
}
// cell上选中标记点击方法
- (void)cellSelectedBtnAction:(UIButton *)button {
    self.userSelectedCell.cellSelectedBtn.selected = NO;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    UserAndPlnViewCell *userAndPlnCell = [self.conflictUserTableView cellForRowAtIndexPath:indexPath];
    userAndPlnCell.cellSelectedBtn.selected = !userAndPlnCell.cellSelectedBtn.selected;
    self.userSelectedModel = [self.conflictUserArray objectAtIndex:indexPath.row];
    // 遍历，找到用户未选中的用户模型
    for (UserModel *userModel in self.conflictUserArray) {
        if (userModel.provider_user_id != self.userSelectedModel.provider_user_id) {
            self.userUnSelectedModel = userModel;
        }
    }
    self.userSelectedCell = userAndPlnCell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 删除view */
    [self.deleteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 删除按钮 */
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.deleteBackView.mas_left).offset(16);
        make.right.equalTo(self.deleteBackView.mas_right).offset(-16);
        make.centerY.equalTo(self.deleteBackView.mas_centerY);
        make.height.mas_equalTo(@45);
    }];
    /** 合并会员卡 */
    [self.mergeUserCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.deleteBackView.mas_top).offset(-0.5);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(@45);
    }];
    /** 合并会员车辆 */
    [self.mergeUserCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mergeUserCardBtn.mas_centerY);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@45);
    }];
    /** 冲突用户 */
    [self.conflictBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mergeUserCarBtn.mas_top);
    }];
    /** 冲突提示删除按钮 */
    [self.conflictPromptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.conflictPromptView.mas_right);
        make.top.equalTo(self.conflictPromptView.mas_top);
        make.bottom.equalTo(self.conflictPromptView.mas_bottom);
        make.width.mas_equalTo(@44);
    }];
    /** 冲突提示文字 */
    [self.conflictPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conflictPromptView.mas_top).offset(0);
        make.left.equalTo(self.conflictPromptView.mas_left).offset(16);
        make.right.equalTo(self.conflictPromptBtn.mas_left).offset(-16);
    }];
    /** 冲突提示 */
    [self.conflictPromptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.conflictPromptLabel.mas_bottom).offset(0);
    }];
    /** 分割线 */
    [self.dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    /** 冲突用户列表 */
    [self.conflictUserTableView mas_makeConstraints:^(MASConstraintMaker *make) {

    }];
}



@end
