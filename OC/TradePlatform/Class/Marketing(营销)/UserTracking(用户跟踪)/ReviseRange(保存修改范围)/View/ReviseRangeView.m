//
//  ReviseRangeView.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import "ReviseRangeView.h"
// view
#import "RangeView.h"
#import "ReviseRangeCell.h"

@interface ReviseRangeView ()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation ReviseRangeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self reviseRangeLayoutView];
    }
    return self;
}
#pragma mark - 按钮点击方法
// 删除按钮点击
- (void)rangeHandleBtnAction:(UIButton *)button {
    // 获取当前选中cell模型
    ExpireModel *expireModel = [self.rangeArray objectAtIndex:button.tag];
    /*  接口地址： 	/index.php?c=user_track&a=del_section&v=1
     user_track_id 	int 	是 	区间id     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_track_id"] = [NSString stringWithFormat:@"%ld", expireModel.user_track_id]; // 区间id
    [ExpireModel delDataSection:params success:^{
        [self.rangeArray removeObject:expireModel];
        [self.rangeTableView reloadData];
        
        if (_delegate && [_delegate respondsToSelector:@selector(delReviseRangeDelegate)]) {
            [_delegate delReviseRangeDelegate];
        }
    }];
    
    
}


- (void)reviseRangeLayoutView {
    /** 背景table */
    self.rangeTableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.rangeTableView.delegate = self;
    self.rangeTableView.dataSource = self;
    self.rangeTableView.rowHeight = 65;
    self.rangeTableView.backgroundColor = [UIColor clearColor];
    self.rangeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.rangeTableView];
    self.reviseRangeFootView = [[ReviseRangeFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    self.rangeTableView.tableFooterView = self.reviseRangeFootView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [self.rangeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rangeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"quiryRecordCell";
    ReviseRangeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ReviseRangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.expireModel = [self.rangeArray objectAtIndex:indexPath.row];
    cell.rangeView.handleBtn.tag = indexPath.row;
    [cell.rangeView.handleBtn addTarget:self action:@selector(rangeHandleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
