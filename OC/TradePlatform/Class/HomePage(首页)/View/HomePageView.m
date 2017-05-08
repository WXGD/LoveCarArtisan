//
//  HomePageView.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePageView.h"

@interface HomePageView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *homePageScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *homePageView;

@end

@implementation HomePageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self homePageViewLayout];
    }
    return self;
}
- (void)homePageViewLayout {
    /** 背景scrollview */
    self.homePageScrollView = [[UIScrollView alloc] init];
    self.homePageScrollView.backgroundColor = VCBackground;
    [self addSubview:self.homePageScrollView];
    /** 填充scrollview的view */
    self.homePageView = [[UIView alloc] init];
    self.homePageView.backgroundColor = VCBackground;
    [self.homePageScrollView addSubview:self.homePageView];

    /** 扫一扫 */
    self.scanBtn = [[TopBotBtn alloc] init];
    self.scanBtn.backgroundColor = WhiteColor;
    self.scanBtn.bomText.text = @"扫一扫";
    self.scanBtn.topImage.image = [UIImage imageNamed:@"home_page_scan"];
    self.scanBtn.topBotBtn.tag = ScanBtnAction;
    [self.homePageView addSubview:self.scanBtn];
    /** 收款 */
    self.receiptBtn = [[TopBotBtn alloc] init];
    self.receiptBtn.backgroundColor = WhiteColor;
    self.receiptBtn.bomText.text = @"收银";
    self.receiptBtn.topImage.image = [UIImage imageNamed:@"home_page_cashier"];
    self.receiptBtn.topBotBtn.tag = ReceiptBtnAction;
    [self.homePageView addSubview:self.receiptBtn];
    /** 店铺实时数据 */
    self.showDataView = [[ShowDataView alloc] init];
    self.showDataView.showDataView.usedCellBtn.tag = ShowDataBtnAction;
    [self.homePageView addSubview:self.showDataView];
    /** 服务管理 */
    self.serviceManageView = [[UsedCellView alloc] init];
    self.serviceManageView.cellImage.image = [UIImage imageNamed:@"home_page_car_wash"];
    self.serviceManageView.cellLabel.text = @"服务";
    self.serviceManageView.cellLabel.font = FifteenTypeface;
    self.serviceManageView.describeLabel.text = @"便捷管理供应服务";
    self.serviceManageView.isSplistLine = YES;
    self.serviceManageView.usedCellBtn.tag = ServiceManageBtnAction;
    [self.homePageView addSubview:self.serviceManageView];
    /** 会员卡 */
    self.userCardView = [[UsedCellView alloc] init];
    self.userCardView.cellImage.image = [UIImage imageNamed:@"home_page_user_card"];
    self.userCardView.cellLabel.text = @"会员卡";
    self.userCardView.cellLabel.font = FifteenTypeface;
    self.userCardView.describeLabel.text = @"会员卡开卡";
    self.userCardView.isSplistLine = YES;
    self.userCardView.usedCellBtn.tag = UserCardBtnAction;
    [self.homePageView addSubview:self.userCardView];
    /** 订单 */
    self.orderView = [[UsedCellView alloc] init];
    self.orderView.cellImage.image = [UIImage imageNamed:@"home_page_order"];
    self.orderView.cellLabel.text = @"订单";
    self.orderView.cellLabel.font = FifteenTypeface;
    self.orderView.describeLabel.text = @"查看实时订单";
    self.orderView.isSplistLine = YES;
    self.orderView.usedCellBtn.tag = OrderBtnAction;
    [self.homePageView addSubview:self.orderView];
    /** 客户 */
    self.userView = [[UsedCellView alloc] init];
    self.userView.cellImage.image = [UIImage imageNamed:@"home_page_user"];
    self.userView.cellLabel.text = @"用户";
    self.userView.cellLabel.font = FifteenTypeface;
    self.userView.describeLabel.text = @"管理用户信息";
    self.userView.isSplistLine = YES;
    self.userView.usedCellBtn.tag = UserBtnAction;
    [self.homePageView addSubview:self.userView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.homePageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.homePageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.homePageScrollView.mas_top);
        make.left.equalTo(self.homePageScrollView.mas_left);
        make.bottom.equalTo(self.homePageScrollView.mas_bottom);
        make.right.equalTo(self.homePageScrollView.mas_right);
        make.width.equalTo(self.homePageScrollView.mas_width);
    }];
    /** 扫一扫 */
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.homePageView.mas_left);
    }];
    /** 收款 */
    [self.receiptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.scanBtn.mas_right);
        make.right.equalTo(self.homePageView.mas_right);
    }];
    /** 扫一扫,收款,会员卡消费 */
    [@[self.scanBtn, self.receiptBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.homePageView.mas_top).offset(5);
        make.width.equalTo(self.scanBtn.mas_width);
        make.height.mas_equalTo(@(110 * HScale));
    }];
    /** 店铺实时数据 */
    [self.showDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.scanBtn.mas_bottom).offset(10);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
    }];
    /** 订单 */
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
        make.top.equalTo(self.showDataView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 会员卡 */
    [self.userCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
        make.top.equalTo(self.orderView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 服务管理 */
    [self.serviceManageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
        make.top.equalTo(self.userCardView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 客户 */
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
        make.top.equalTo(self.serviceManageView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 填充scrollview的view的高度 */
    [self.homePageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.userView.mas_bottom).offset(20);
    }];
}



@end
