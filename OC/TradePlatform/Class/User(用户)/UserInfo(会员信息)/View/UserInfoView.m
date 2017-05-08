//
//  UserInfoView.m
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserInfoView.h"
#import "UserCarCell.h"

@interface UserInfoView ()<UITableViewDelegate, UITableViewDataSource>

/** 开卡View */
@property (strong, nonatomic) UIView *openCardView;

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *userInfoScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *userInfoView;

@end

@implementation UserInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpLayoutView];
    }
    return self;
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userCarArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"userCarCell";
    UserCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UserCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.userCarModel = [self.userCarArray objectAtIndex:indexPath.row];
    /** 编辑按钮 */
    cell.userCarView.editBtn.tag = indexPath.row;
    [cell.userCarView.editBtn addTarget:self action:@selector(editCarInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 二手车估值 */
    cell.userCarView.useCarValuationBtn.tag = indexPath.row;
    [cell.userCarView.useCarValuationBtn addTarget:self action:@selector(useCarValuationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 查保险 */
    cell.userCarView.quiryBenefitBtn.tag = indexPath.row;
    [cell.userCarView.quiryBenefitBtn addTarget:self action:@selector(quiryBenefitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

/** 编辑按钮 */
- (void)editCarInfoBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(editCarInfoBtnDelegate:)]) {
        [_delegate editCarInfoBtnDelegate:button];
    }
}
/** 二手车估值 */
- (void)useCarValuationBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(useCarValuationBtnDelegate:)]) {
        [_delegate useCarValuationBtnDelegate:button];
    }
}
/** 查保险 */
- (void)quiryBenefitBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(quiryBenefitBtnDelegate:)]) {
        [_delegate quiryBenefitBtnDelegate:button];
    }
}

- (void)setUpLayoutView {
    /** 背景scrollview */
    self.userInfoScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.userInfoScrollView];
    /** 填充scrollview的view */
    self.userInfoView = [[UIView alloc] init];
    [self.userInfoScrollView addSubview:self.userInfoView];

    /** 会员头像，名称，微信号 */
    self.userHeaderView = [[UsedCellView alloc] init];
    self.userHeaderView.cellLabel.text = @"姓名";
    self.userHeaderView.cellLabel.font = FifteenTypeface;
    self.userHeaderView.describeLabel.textColor = GrayH1;
    self.userHeaderView.describeLabel.font = ThirteenTypeface;
    self.userHeaderView.isCellImage = YES;
    self.userHeaderView.dividingLineChoice = DividingLineFullScreenLayout;
    self.userHeaderView.usedCellBtn.tag = UserHeaderBtnAction;
    [self.userInfoView addSubview:self.userHeaderView];
    /** 电话 */
    self.userPhoneView = [[UsedCellView alloc] init];
    self.userPhoneView.cellLabel.text = @"手机号";
    self.userPhoneView.cellLabel.font = FifteenTypeface;
    self.userPhoneView.describeLabel.textColor = GrayH1;
    self.userPhoneView.describeLabel.font = ThirteenTypeface;
    self.userPhoneView.usedCellBtn.tag = UserPhoneBtnAction;
    self.userPhoneView.isCellImage = YES;
    self.userPhoneView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.userInfoView addSubview:self.userPhoneView];
    /** 消费记录 */
    self.purchaseHistoryView = [[UsedCellView alloc] init];
    self.purchaseHistoryView.cellLabel.text = @"消费记录";
    self.purchaseHistoryView.cellLabel.font = FifteenTypeface;
    self.purchaseHistoryView.describeLabel.textColor = GrayH1;
    self.purchaseHistoryView.describeLabel.font = ThirteenTypeface;
    self.purchaseHistoryView.usedCellBtn.tag = PurchaseHistoryBtnAction;
    self.purchaseHistoryView.isCellImage = YES;
    self.purchaseHistoryView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.userInfoView addSubview:self.purchaseHistoryView];
    /** 会员卡 */
    self.userCodeView = [[UsedCellView alloc] init];
    self.userCodeView.cellLabel.text = @"会员卡";
    self.userCodeView.cellLabel.font = FifteenTypeface;
    self.userCodeView.describeLabel.textColor = GrayH1;
    self.userCodeView.describeLabel.font = ThirteenTypeface;
    self.userCodeView.usedCellBtn.tag = UserCodeBtnAction;
    self.userCodeView.isCellImage = YES;
    self.userCodeView.isSplistLine = YES;
    [self.userInfoView addSubview:self.userCodeView];
    /** 会员车辆 */
    self.userCarView = [[UsedCellView alloc] init];
    self.userCarView.cellLabel.text = @"车辆";
    self.userCarView.cellLabel.font = FifteenTypeface;
    self.userCarView.cellLabel.textColor = Black;
    self.userCarView.describeLabel.text = @"添加车辆";
    self.userCarView.describeLabel.textColor = BlueColor;
    self.userCarView.describeLabel.font = FourteenTypeface;
    self.userCarView.usedCellBtn.tag = UserCarBtnAction;
    self.userCarView.isCellImage = YES;
    self.userCarView.isArrow = YES;
    self.userCarView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.userInfoView addSubview:self.userCarView];
    self.userCarTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 46) style:UITableViewStylePlain];
    self.userCarTable.delegate = self;
    self.userCarTable.dataSource = self;
    self.userCarTable.rowHeight = 130;
    self.userCarTable.backgroundColor = CLEARCOLOR;
    self.userCarTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userCarTable.bounces = NO;
    [self.userInfoView addSubview:self.userCarTable];
    UIView *tabFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    tabFootView.backgroundColor = WhiteColor;
    self.userCarTable.tableFooterView = tabFootView;
    /** 开卡View */
    self.openCardView = [[UIView alloc] init];
    self.openCardView.backgroundColor = WhiteColor;
    [self addSubview:self.openCardView];
    /** 开卡 */
    self.openCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.openCardBtn setTitle:@"开卡" forState:UIControlStateNormal];
    [self.openCardBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.openCardBtn.titleLabel.font = SixteenTypeface;
    self.openCardBtn.backgroundColor = ThemeColor;
    self.openCardBtn.layer.masksToBounds = YES;
    self.openCardBtn.layer.cornerRadius = 2;
    self.openCardBtn.tag = OpenCardBtnAction;
    [self.openCardView addSubview:self.openCardBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 开卡 */
    [self.openCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 开卡 */
    [self.openCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.openCardView.mas_left).offset(16);
        make.right.equalTo(self.openCardView.mas_right).offset(-16);
        make.centerY.equalTo(self.openCardView.mas_centerY);
        make.height.mas_equalTo(@40);
    }];
    /** 背景scrollview */
    [self.userInfoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.openCardView.mas_top).offset(-10);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userInfoScrollView.mas_top);
        make.left.equalTo(self.userInfoScrollView.mas_left);
        make.bottom.equalTo(self.userInfoScrollView.mas_bottom);
        make.right.equalTo(self.userInfoScrollView.mas_right);
        make.width.equalTo(self.userInfoScrollView.mas_width);
    }];
    /** 会员头像，名称，微信号 */
    [self.userHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userInfoView.mas_left);
        make.right.equalTo(self.userInfoView.mas_right);
        make.top.equalTo(self.userInfoView.mas_top);
        make.height.mas_equalTo(@50);
    }];
    /** 电话 */
    [self.userPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userInfoView.mas_left);
        make.right.equalTo(self.userInfoView.mas_right);
        make.top.equalTo(self.userHeaderView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 消费记录 */
    [self.purchaseHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userInfoView.mas_left);
        make.right.equalTo(self.userInfoView.mas_right);
        make.top.equalTo(self.userPhoneView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 会员卡 */
    [self.userCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userInfoView.mas_left);
        make.right.equalTo(self.userInfoView.mas_right);
        make.top.equalTo(self.purchaseHistoryView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 会员车辆 */
    [self.userCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userInfoView.mas_left);
        make.right.equalTo(self.userInfoView.mas_right);
        make.top.equalTo(self.userCodeView.mas_bottom).offset(10);
        make.height.mas_equalTo(@44);
    }];
    [self.userCarTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userInfoView.mas_left);
        make.right.equalTo(self.userInfoView.mas_right);
        make.top.equalTo(self.userCarView.mas_bottom);
        make.height.mas_equalTo(@(130 * self.userCarArray.count + 10));
    }];
    /** 填充scrollview的view的高度 */
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.userCarTable.mas_bottom);
    }];
}

@end
