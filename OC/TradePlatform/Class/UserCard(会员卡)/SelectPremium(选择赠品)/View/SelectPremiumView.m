//
//  SelectPremiumView.m
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SelectPremiumView.h"
// 单利
#import "ServiceCategoryHandle.h"
#import "ServiceProviderModel.h"

@interface SelectPremiumView ()<UITableViewDelegate, UITableViewDataSource, AddSubBtnDelegate>

/** 添加赠品View */
@property (strong, nonatomic) UIView *addGiftView;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;

@end


@implementation SelectPremiumView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.giftGoodsArray = [[NSMutableArray alloc] init];
        [self selectPremiumLayoutView];
    }
    return self;
}


#pragma mark - view布局
- (void)selectPremiumLayoutView {
    /** 添加赠品View */
    self.addGiftView = [[UIView alloc] init];
    self.addGiftView.backgroundColor = WhiteColor;
    [self addSubview:self.addGiftView];
    /** 添加赠品 */
    self.addGiftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addGiftBtn setTitle:@"添加赠品" forState:UIControlStateNormal];
    [self.addGiftBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.addGiftBtn.titleLabel.font = EighteenTypeface;
    self.addGiftBtn.backgroundColor = ThemeColor;
    [self.addGiftView addSubview:self.addGiftBtn];
    /** 赠品View */
    self.selectPremiumStackView = [[UIStackView alloc] init];
    self.selectPremiumStackView.axis = UILayoutConstraintAxisVertical;
    [self addSubview:self.selectPremiumStackView];
    /** 赠送次数输入view */
    self.giveNumPriceBackView = [[UIView alloc] init];
    [self.selectPremiumStackView addArrangedSubview:self.giveNumPriceBackView];
    /** 赠送次数／金额 */
    self.giveNumPriceView = [[UsedCellView alloc] init];
    self.giveNumPriceView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.giveNumPriceView.cellLabel.text = @"赠送次数";
    self.giveNumPriceView.cellLabel.font = FifteenTypeface;
    self.giveNumPriceView.cellLabel.textColor = GrayH1;
    self.giveNumPriceView.viceTextFiled.placeholder = @"请输入赠送次数";
    self.giveNumPriceView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.giveNumPriceView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.giveNumPriceView.viceTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.giveNumPriceView.viceTextFiled.textColor = Black;
    self.giveNumPriceView.isCellImage = YES;
    self.giveNumPriceView.isSplistLine = YES;
    self.giveNumPriceView.isArrow = YES;
    self.giveNumPriceView.isCellBtn = YES;
    [self.giveNumPriceBackView addSubview:self.giveNumPriceView];
    /** 分割线 */
    self.lineView = [[UIView alloc] init];
    [self.selectPremiumStackView addArrangedSubview:self.lineView];
    /** 赠送服务 */
    self.giftServiceTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.giftServiceTable.delegate = self;
    self.giftServiceTable.dataSource = self;
    self.giftServiceTable.rowHeight = 194;
    self.giftServiceTable.backgroundColor = CLEARCOLOR;
    self.giftServiceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.selectPremiumStackView addArrangedSubview:self.giftServiceTable];
    // tableview高度随数据高度变化而变化
    [self.giftServiceTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // 添加回收键盘的手势
    UITapGestureRecognizer *premiumTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(premiumTapAction:)];
    [self.giftServiceTable addGestureRecognizer:premiumTap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 添加赠品View */
    [self.addGiftView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 添加赠品 */
    [self.addGiftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addGiftView.mas_left).offset(16);
        make.right.equalTo(self.addGiftView.mas_right).offset(-16);
        make.centerY.equalTo(self.addGiftView.mas_centerY);
        make.height.mas_equalTo(@40);
    }];
    /** 赠品View */
    [self.selectPremiumStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.addGiftBtn.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 赠送次数输入view */
    [self.giveNumPriceBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@60);
    }];
    /** 赠送次数／金额 */
    [self.giveNumPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.giveNumPriceBackView.mas_bottom);
        make.left.equalTo(self.giveNumPriceBackView.mas_left);
        make.right.equalTo(self.giveNumPriceBackView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    /** 赠送服务 */
    [self.giftServiceTable mas_makeConstraints:^(MASConstraintMaker *make) {

    }];
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.giftGoodsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"giftServiceCell";
    GiftServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GiftServiceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.premiumModel = [self.giftGoodsArray objectAtIndex:indexPath.row];
    /** 赠品标题 */
    cell.delTitleView.cellLabel.text = [NSString stringWithFormat:@"赠品%ld", indexPath.row + 1];
    /** 删除赠品 */
    cell.delTitleView.arrowImage.tag = indexPath.row;
    [cell.delTitleView.arrowImage addTarget:self action:@selector(delPremiumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 服务类别 */
    cell.serviceClassView.usedCellBtn.tag = indexPath.row;
    [cell.serviceClassView.usedCellBtn addTarget:self action:@selector(serviceClassBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 服务 */
    cell.serviceView.usedCellBtn.tag = indexPath.row;
    [cell.serviceView.usedCellBtn addTarget:self action:@selector(serviceGoodsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 数量操作 */
    cell.numOperBtn.addBtn.tag = indexPath.row;
    cell.numOperBtn.subBtn.tag = indexPath.row;
    cell.numOperBtn.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self endEditing:YES];
}

/** 删除赠品 */
- (void)delPremiumBtnAction:(UIButton *)button {
    /** 删除赠品 */
    if (_delegate && [_delegate respondsToSelector:@selector(delPremiumBtnDelegate:)]) {
        [_delegate delPremiumBtnDelegate:button];
    }
}
/** 服务类别 */
- (void)serviceClassBtnAction:(UIButton *)button {
    /** 服务类别 */
    if (_delegate && [_delegate respondsToSelector:@selector(serviceClassBtnDelegate:)]) {
        [_delegate serviceClassBtnDelegate:button];
    }
}
/** 服务 */
- (void)serviceGoodsBtnAction:(UIButton *)button {
    /** 服务 */
    if (_delegate && [_delegate respondsToSelector:@selector(serviceGoodsBtnDelegate:)]) {
        [_delegate serviceGoodsBtnDelegate:button];
    }
}
/** 数量操作 */
- (void)addSubBtnDelegate:(UIButton *)button {
    /** 数量操作 */
    if (_delegate && [_delegate respondsToSelector:@selector(addSubPremiumDelegate:)]) {
        [_delegate addSubPremiumDelegate:button];
    }
}

#pragma mark - 回收键盘的方法
- (void)premiumTapAction:(UIButton *)button {
    [self endEditing:YES];
}


@end
