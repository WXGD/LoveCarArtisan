//
//  MyAccountView.m
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyAccountView.h"

@interface MyAccountView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyAccountView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self myAccountLayoutView];
    }
    return self;
}


#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recordArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"postalRecordCell";
    PostalRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PostalRecordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.withdrawRecordModel = self.recordArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(postalRecordCellDidSelect:)]) {
        [_delegate postalRecordCellDidSelect:(self.recordArray[indexPath.row])];
    }
}


#pragma mark - view布局
- (void)myAccountLayoutView {
    /** 头部view */
    self.headerView = [[MyAccountHeaderView alloc] init];
    [self addSubview:self.headerView];
    /** 提现记录table */
    self.postalRecordTable = [[UITableView alloc] init];
    self.postalRecordTable.delegate = self;
    self.postalRecordTable.dataSource = self;
    self.postalRecordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.postalRecordTable.backgroundColor = CLEARCOLOR;
    self.postalRecordTable.rowHeight = 76;
    [self addSubview:self.postalRecordTable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 头部view */
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 提现记录table */
    [self.postalRecordTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
