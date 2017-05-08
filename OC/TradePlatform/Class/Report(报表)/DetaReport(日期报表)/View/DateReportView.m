
//
//  DateReportView.m
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DateReportView.h"


@interface DateReportView ()<GJTableViewDelegate>

/** 订单类型view */
@property (strong, nonatomic) OrderTypeTitleView *orderTypeTitleView;

@end

@implementation DateReportView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self dateReportLayoutView];
    }
    return self;
}

- (void)dateReportLayoutView {
    /** 报表头部view */
    self.reportHeaderView = [[ReportHeaderView alloc] init];
    [self addSubview:self.reportHeaderView];
    /** 订单类型view */
    self.orderTypeTitleView = [[OrderTypeTitleView alloc] init];
    [self addSubview:self.orderTypeTitleView];
    /** 订单列表 */
    self.orderListTable = [[GJBaseTabelView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.detaReportDataSource = [[DetaReportDataSource alloc] init];
    self.orderListTable.GJDataSource = self.detaReportDataSource;
    self.orderListTable.GJDelegate = self;
    self.orderListTable.backgroundColor = CLEARCOLOR;
    self.orderListTable.separatorStyle = UITableViewCellAccessoryNone;
    [self addSubview:self.orderListTable];
    // tableview高度随数据高度变化而变化
    [self.orderListTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 报表头部view */
    [self.reportHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 订单类型view */
    [self.orderTypeTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.reportHeaderView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@(60 * HScale));
    }];
    /** 订单列表 */
    [self.orderListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderTypeTitleView.mas_bottom).offset(0.5);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
