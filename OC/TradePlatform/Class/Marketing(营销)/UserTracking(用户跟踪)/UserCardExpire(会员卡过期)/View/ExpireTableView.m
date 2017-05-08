//
//  ExpireTableView.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import "ExpireTableView.h"

@interface ExpireTableView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation ExpireTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self expireTableLayoutView];
    }
    return self;
}

#pragma mark - 头部按钮点击代理
- (void)seleAreaBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(seleAreaBtnAction)]) {
        [_delegate seleAreaBtnAction];
    }
}

- (void)expireTableLayoutView {
    /** 过期table */
    self.expireTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.expireTable.delegate = self;
    self.expireTable.dataSource = self;
    self.expireTable.rowHeight = 93;
    self.expireTable.backgroundColor = [UIColor clearColor];
    self.expireTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.expireTable];
    /** tabl头部view */
    self.expireHeaderView = [[ExpireHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    [self.expireHeaderView.seleAreaBtn addTarget:self action:@selector(seleAreaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.expireTable.tableHeaderView = self.expireHeaderView;    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 过期table */
    [self.expireTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.expireArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"quiryRecordCell";
    ExpireCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ExpireCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.expireCellType = self.expireCellType;
    cell.expircUserModel = [self.expireArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ExpircUserModel *expircUserModel = [self.expireArray objectAtIndex:indexPath.row];
    if (expircUserModel.mobile.length > 0) {
        //拨打电话
        [AlertAction determineStayRight:[self viewController] title:@"提示" message:[NSString stringWithFormat:@"是否拨打电话到%@", expircUserModel.mobile] determineBlock:^{
            /** 调用系统电话 */
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",expircUserModel.mobile]]];
        }];
    }else{
        [MBProgressHUD showSuccess:@"没有用户电话号码"];
    }
    
}

@end
