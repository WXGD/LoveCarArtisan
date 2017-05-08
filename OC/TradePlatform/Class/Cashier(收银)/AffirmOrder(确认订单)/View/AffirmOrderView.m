//
//  AffirmOrderView.m
//  TradePlatform
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AffirmOrderView.h"
// view
#import "UUInputAccessoryView.h"
#import "AffirmGoodsCell.h"

@interface AffirmOrderView ()<UITableViewDelegate, UITableViewDataSource>

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *affirmOrderScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *affirmOrderView;
/** 用户信息标题view */
@property (strong, nonatomic) UsedCellView *userInfoTitleView;
/** 用户信息view */
@property (strong, nonatomic) UIView *userInfoView;
/** 服务信息标题view */
@property (strong, nonatomic) UsedCellView *serviceInfoTitleView;
/** 服务信息table */
@property (strong, nonatomic) UITableView *serviceInfoTable;
/** 价格确认标题view */
@property (strong, nonatomic) UsedCellView *priceAffirmTitleView;
/** 订单总价标题 */
@property (strong, nonatomic) UILabel *orderTotalTitleLabel;

@end

@implementation AffirmOrderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self affirmOrderLayoutView];
    }
    return self;
}


- (void)setServiceInfoArray:(NSMutableArray *)serviceInfoArray {
    _serviceInfoArray = serviceInfoArray;
    /** 服务信息table */
    @weakify(self)
    [self.serviceInfoTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.height.mas_equalTo(@(79 * self.serviceInfoArray.count));
    }];
    [self.serviceInfoTable reloadData];
}

#pragma mark - 修改销售价按钮
- (void)pretiumBtnAction:(UIButton *)button {
    // 弹出键盘
    [UUInputAccessoryView showKeyboardType:UIKeyboardTypeNumbersAndPunctuation content:self.pretiumView.viceTextFiled.text Block:^(NSString *contentStr) {
        if (contentStr.length == 0) return ;
        self.pretiumView.viceTextFiled.text = contentStr;
    }];
}

#pragma mark - view布局
- (void)affirmOrderLayoutView {
    /** 确认收款 */
    self.affirmCashierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.affirmCashierBtn setTitle:@"收银" forState:UIControlStateNormal];
    [self.affirmCashierBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.affirmCashierBtn.titleLabel.font = SixteenTypeface;
    self.affirmCashierBtn.backgroundColor = ThemeColor;
    [self addSubview:self.affirmCashierBtn];
    /** 背景scrollview */
    self.affirmOrderScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.affirmOrderScrollView];
    /** 填充scrollview的view */
    self.affirmOrderView = [[UIView alloc] init];
    [self.affirmOrderScrollView addSubview:self.affirmOrderView];
    
    /** 用户信息标题view */
    self.userInfoTitleView = [[UsedCellView alloc] init];
    self.userInfoTitleView.cellLabel.text = @"用户信息";
    self.userInfoTitleView.cellLabel.font = FifteenTypeface;
    self.userInfoTitleView.cellLabel.textColor = ThemeColor;
    self.userInfoTitleView.isCellImage = YES;
    self.userInfoTitleView.isArrow = YES;
    self.userInfoTitleView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.affirmOrderView addSubview:self.userInfoTitleView];
    /** 用户信息view */
    self.userInfoView = [[UIView alloc] init];
    self.userInfoView.backgroundColor = WhiteColor;
    [self.affirmOrderView addSubview:self.userInfoView];
    /** 用户手机号 */
    self.userPhoneLabel = [[UILabel alloc] init];
    self.userPhoneLabel.text = @"用户手机号";
    self.userPhoneLabel.font = FourteenTypeface;
    self.userPhoneLabel.textColor = GrayH1;
    [self.userInfoView addSubview:self.userPhoneLabel];
    /** 用户车牌号 */
    self.userPlnLabel = [[UILabel alloc] init];
    self.userPlnLabel.text = @"用户车牌号";
    self.userPlnLabel.font = FourteenTypeface;
    self.userPlnLabel.textColor = GrayH1;
    [self.userInfoView addSubview:self.userPlnLabel];
    /** 订单时间 */
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.text = @"订单时间";
    self.orderTimeLabel.font = TwelveTypeface;
    self.orderTimeLabel.textColor = GrayH2;
    [self.userInfoView addSubview:self.orderTimeLabel];
    /** 服务信息标题view */
    self.serviceInfoTitleView = [[UsedCellView alloc] init];
    self.serviceInfoTitleView.cellLabel.text = @"服务信息";
    self.serviceInfoTitleView.cellLabel.font = FifteenTypeface;
    self.serviceInfoTitleView.cellLabel.textColor = ThemeColor;
    self.serviceInfoTitleView.isCellImage = YES;
    self.serviceInfoTitleView.isArrow = YES;
    self.serviceInfoTitleView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.affirmOrderView addSubview:self.serviceInfoTitleView];
    /** 服务信息table */
    self.serviceInfoTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.serviceInfoTable.delegate = self;
    self.serviceInfoTable.dataSource = self;
    self.serviceInfoTable.rowHeight = 79;
    self.serviceInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.serviceInfoTable.bounces = NO;
    [self.affirmOrderView addSubview:self.serviceInfoTable];
    /** 价格确认标题view */
    self.priceAffirmTitleView = [[UsedCellView alloc] init];
    self.priceAffirmTitleView.cellLabel.text = @"价格确认";
    self.priceAffirmTitleView.cellLabel.font = FifteenTypeface;
    self.priceAffirmTitleView.cellLabel.textColor = ThemeColor;
    self.priceAffirmTitleView.isCellImage = YES;
    self.priceAffirmTitleView.isArrow = YES;
    self.priceAffirmTitleView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.affirmOrderView addSubview:self.priceAffirmTitleView];
    /** 订单总价标题 */
    self.orderTotalTitleLabel = [[UILabel alloc] init];
    self.orderTotalTitleLabel.text = @"总价";
    self.orderTotalTitleLabel.font = TwelveTypeface;
    self.orderTotalTitleLabel.textColor = GrayH1;
    [self.priceAffirmTitleView addSubview:self.orderTotalTitleLabel];
    /** 订单总价 */
    self.orderTotalLabel = [[UILabel alloc] init];
    self.orderTotalLabel.text = @"总价";
    self.orderTotalLabel.font = TwelveTypeface;
    self.orderTotalLabel.textColor = GrayH1;
    [self.priceAffirmTitleView addSubview:self.orderTotalLabel];
    /** 销售价view */
    self.pretiumView = [[UsedCellView alloc] init];
    self.pretiumView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.pretiumView.arrowImage setTitle:@"元" forState:UIControlStateNormal];
    [self.pretiumView.arrowImage setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.pretiumView.arrowImage setImage:nil forState:UIControlStateNormal];
    self.pretiumView.arrowImage.titleLabel.font = FourteenTypeface;
    self.pretiumView.backgroundColor = WhiteColor;
    self.pretiumView.cellLabel.text = @"成交价";
    self.pretiumView.cellLabel.textColor = GrayH1;
    self.pretiumView.cellLabel.font = FourteenTypeface;
    self.pretiumView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.pretiumView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.pretiumView.viceTextFiled.font = FourteenTypeface;
    self.pretiumView.viceTextFiled.textColor = RedColor;
    self.pretiumView.isCellImage = YES;
    self.pretiumView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.pretiumView.usedCellBtn addTarget:self action:@selector(pretiumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.affirmOrderView addSubview:self.pretiumView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 确认收款 */
    [self.affirmCashierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.height.mas_equalTo(@50);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 背景scrollview */
    [self.affirmOrderScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.affirmCashierBtn.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.affirmOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.affirmOrderScrollView.mas_top);
        make.left.equalTo(self.affirmOrderScrollView.mas_left);
        make.bottom.equalTo(self.affirmOrderScrollView.mas_bottom);
        make.right.equalTo(self.affirmOrderScrollView.mas_right);
        make.width.equalTo(self.affirmOrderScrollView.mas_width);
        make.bottom.equalTo(self.pretiumView.mas_bottom);
    }];
    
    /** 用户信息标题view */
    [self.userInfoTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.affirmOrderView.mas_left);
        make.right.equalTo(self.affirmOrderView.mas_right);
        make.top.equalTo(self.affirmOrderView.mas_top);
        make.height.mas_equalTo(@40);
    }];
    /** 用户信息view */
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.affirmOrderView.mas_left);
        make.right.equalTo(self.affirmOrderView.mas_right);
        make.top.equalTo(self.userInfoTitleView.mas_bottom);
        make.bottom.equalTo(self.orderTimeLabel.mas_bottom).offset(16);
    }];
    /** 用户车牌号 */
    [self.userPlnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userInfoView.mas_left).offset(16);
        make.top.equalTo(self.userInfoView.mas_top).offset(16);
        make.height.mas_equalTo(@14.5);
    }];
    /** 用户手机号 */
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userPlnLabel.mas_right).offset(16);
        make.top.equalTo(self.userInfoView.mas_top).offset(16);
    }];
    /** 订单时间 */
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userPlnLabel.mas_left);
        make.top.equalTo(self.userPlnLabel.mas_bottom).offset(10);
    }];
    /** 服务信息标题view */
    [self.serviceInfoTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.affirmOrderView.mas_left);
        make.right.equalTo(self.affirmOrderView.mas_right);
        make.top.equalTo(self.userInfoView.mas_bottom).offset(10);
        make.height.mas_equalTo(@40);
    }];
    /** 服务信息table */
    [self.serviceInfoTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.affirmOrderView.mas_left);
        make.right.equalTo(self.affirmOrderView.mas_right);
        make.top.equalTo(self.serviceInfoTitleView.mas_bottom);
        make.height.mas_equalTo(@(79 * self.serviceInfoArray.count));
    }];
    /** 价格确认标题view */
    [self.priceAffirmTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.affirmOrderView.mas_left);
        make.right.equalTo(self.affirmOrderView.mas_right);
        make.top.equalTo(self.serviceInfoTable.mas_bottom).offset(10);
        make.height.mas_equalTo(@40);
    }];
    /** 订单总价 */
    [self.orderTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.priceAffirmTitleView.mas_right).offset(-16);
        make.centerY.equalTo(self.priceAffirmTitleView.mas_centerY);
    }];
    /** 订单总价标题 */
    [self.orderTotalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.orderTotalLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.priceAffirmTitleView.mas_centerY);
    }];
    /** 销售价view */
    [self.pretiumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.affirmOrderView.mas_left);
        make.right.equalTo(self.affirmOrderView.mas_right);
        make.top.equalTo(self.priceAffirmTitleView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
}

#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.serviceInfoArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"affirmGoodsCell";
    AffirmGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AffirmGoodsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.shoppingCartModel = [self.serviceInfoArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
