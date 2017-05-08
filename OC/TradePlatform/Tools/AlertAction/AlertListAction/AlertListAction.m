//
//  AlertListAction.m
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AlertListAction.h"
#import "AlertListCell.h"

@interface AlertListAction ()<UITableViewDelegate, UITableViewDataSource>

/** 订单类型 */
@property (strong, nonatomic) UITableView *typeTable;

@end

@implementation AlertListAction

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.closeBtn setHidden:YES];
        [self orderTypeLayoutView];
    }
    return self;
}

- (void)orderTypeLayoutView {
    /** 订单类型选择标题 */
    self.typeChooseTi = [[UILabel alloc] init];
    self.typeChooseTi.textColor = WhiteColor;
    self.typeChooseTi.text = @"请选择";
    self.typeChooseTi.font = FifteenTypeface;
    self.typeChooseTi.backgroundColor = ThemeColor;
    self.typeChooseTi.textAlignment = NSTextAlignmentCenter;
    [self.boxAlert addSubview:self.typeChooseTi];
    /** 订单类型 */
    self.typeTable = [[UITableView alloc] init];
    self.typeTable.delegate = self;
    self.typeTable.dataSource = self;
    self.typeTable.bounces = NO;
    self.typeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.boxAlert addSubview:self.typeTable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 订单类型选择标题 */
    [self.typeChooseTi mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.boxAlert.mas_centerX);
        make.top.equalTo(self.boxAlert.mas_top);
        make.left.equalTo(self.boxAlert.mas_left);
        make.right.equalTo(self.boxAlert.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 订单类型 */
    [self.typeTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.typeChooseTi.mas_bottom).offset(10);
        make.left.equalTo(self.boxAlert.mas_left);
        make.right.equalTo(self.boxAlert.mas_right);
        make.height.mas_equalTo(@(44 * self.alertListArray.count));
    }];
    /** self高度 */
    [self.boxAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.typeTable.mas_bottom);
    }];
}

#pragma mark - talbe代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.alertListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"orderTypeCell";
    AlertListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AlertListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    AlertListModel *alertModel = self.alertListArray[indexPath.row];
    cell.alertListModel = alertModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 便利所有订单类型,取消所有选中状态
    for (AlertListModel *alertModel in self.alertListArray) {
        alertModel.currentTitle = NO;
    }
    // 获取选中模型
    if (_delegate && [_delegate respondsToSelector:@selector(alertModelChooseActionBoxView:alertRow:)]) {
        [_delegate alertModelChooseActionBoxView:self alertRow:indexPath.row];
    }
}

@end

