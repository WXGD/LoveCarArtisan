//
//  MyAccountView.m
//  TradePlatform
//
//  Created by apple on 2017/1/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyAccountView.h"
#import "RecordTableCell.h"

@interface MyAccountView () <UITableViewDelegate, UITableViewDataSource>

/** 金额头部view */
@property (strong, nonatomic) UIView *moneyHeaderView;
/** 可提现余额标题 */
@property (strong, nonatomic) UILabel *myBalance;
/** 提现记录标题 */
@property (strong, nonatomic) UILabel *presentationRecord;

@end

@implementation MyAccountView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self myAccountLayoutView];
    }
    return self;
}

- (void)myAccountLayoutView {
    /** 金额头部view */
    self.moneyHeaderView = [[UIView alloc] init];
    self.moneyHeaderView.backgroundColor = ThemeColor;
    [self addSubview:self.moneyHeaderView];
    /** 可提现余额 */
    self.myBalanceLabel = [[UILabel alloc] init];
    self.myBalanceLabel.textColor = WhiteColor;
    self.myBalanceLabel.font = ThirtySixTypeface;
    [self.moneyHeaderView addSubview:self.myBalanceLabel];
    /** 可提现余额标题 */
    self.myBalance = [[UILabel alloc] init];
    self.myBalance.text = @"可提现余额(元)";
    self.myBalance.textColor = WhiteColor;
    self.myBalance.font = FifteenTypeface;
    [self.moneyHeaderView addSubview:self.myBalance];
    /** 已提现余额 */
    self.userBalanceLabel = [[TwoWordsLabel alloc] init];
    self.userBalanceLabel.twoWordsShowStyle = TextHorizontalLayoutAndSuperCenter;
    self.userBalanceLabel.mainLabel.text = @"已提现金额：";
    self.userBalanceLabel.mainLabel.font = TwelveTypeface;
    self.userBalanceLabel.viceLabel.font = FifteenTypeface;
    self.userBalanceLabel.mainLabel.textColor = WhiteColor;
    self.userBalanceLabel.viceLabel.textColor = WhiteColor;
    [self.moneyHeaderView addSubview:self.userBalanceLabel];
    /** 申请提现 */
    self.applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.applyBtn setTitle:@"申请提现" forState:UIControlStateNormal];
    [self.applyBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.applyBtn.titleLabel.font = EighteenTypeface;
    self.applyBtn.backgroundColor = ThemeColor;
    self.applyBtn.layer.masksToBounds = YES;
    self.applyBtn.layer.cornerRadius = 10;
    [self addSubview:self.applyBtn];
    /** 提现记录标题 */
    self.presentationRecord = [[UILabel alloc] init];
    self.presentationRecord.text = @"提现记录";
    self.presentationRecord.textColor = GrayH2;
    self.presentationRecord.font = TwelveTypeface;
    [self addSubview:self.presentationRecord];
    /** 提现记录 */
    self.recordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100) style:UITableViewStylePlain];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    self.recordTableView.rowHeight = 70;
    self.recordTableView.backgroundColor = CLEARCOLOR;
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.recordTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 金额头部view */
    [self.moneyHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 可提现余额 */
    [self.myBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.moneyHeaderView.mas_top).offset(25);
    }];
    /** 可提现余额标题 */
    [self.myBalance mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.myBalanceLabel.mas_bottom).offset(20);
    }];
    /** 已提现余额 */
    [self.userBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.myBalance.mas_bottom).offset(25);
        make.right.equalTo(self.userBalanceLabel.viceLabel.mas_right);
        make.bottom.equalTo(self.userBalanceLabel.viceLabel.mas_bottom);
    }];
    /** 金额头部view高度 */
    [self.moneyHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.userBalanceLabel.mas_bottom).offset(25);
    }];
    /** 申请提现 */
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(45);
        make.right.equalTo(self.mas_right).offset(-45);
        make.top.equalTo(self.moneyHeaderView.mas_bottom).offset(35);
        make.height.mas_equalTo(@50);
    }];
    /** 提现记录标题 */
    [self.presentationRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.applyBtn.mas_bottom).offset(35);
        make.height.mas_equalTo(@30);
    }];
    /** 提现记录 */
    [self.recordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.presentationRecord.mas_bottom).offset(1);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"recordTableCell";
    RecordTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[RecordTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.withdrawRecordModel = [self.recordArray objectAtIndex:indexPath.row];
    return cell;
}

@end
