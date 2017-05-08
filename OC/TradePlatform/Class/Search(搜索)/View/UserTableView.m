//
//  UserTableView.m
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserTableView.h"
#import "SearchUserViewCell.h"

@interface UserTableView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>


@end

@implementation UserTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 布局
        [self userTabelViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)userTabelViewLayoutView {
    /** 用户车辆列表View */
    self.userTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.userTable.backgroundColor = [UIColor clearColor];
    self.userTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.userTable.delegate = self;
    self.userTable.dataSource = self;
    [self addSubview:self.userTable];
    // tableview高度随数据高度变化而变化
    [self.userTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // 给客户信息table添加清扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
    swipeGesture.delegate = self;
    [self.userTable addGestureRecognizer:swipeGesture];
    // 给客户信息table添加轻拍手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
    tapGesture.delegate = self;
    [self.userTable addGestureRecognizer:tapGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /** 用户车辆列表View */
    @weakify(self)
    [self.userTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"searchUserViewCell";
    SearchUserViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SearchUserViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.userModel = [self.userArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(userTableDidSelectRowAtIndexPath:)]) {
        [_delegate userTableDidSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - 手势代理，解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 判断是不是tableview触发的手势
    PDLog(@"%@", touch.view);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UsedCellView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}
- (void)gestureAction {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


@end
