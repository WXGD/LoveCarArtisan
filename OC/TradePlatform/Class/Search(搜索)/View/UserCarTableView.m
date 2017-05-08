//
//  UserCarTableView.m
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCarTableView.h"
#import "SearchUserCarViewCell.h"

@interface UserCarTableView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>


@end


@implementation UserCarTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self userCarTabelViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)userCarTabelViewLayoutView {
    /** 用户车辆列表View */
    self.userCarTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.userCarTable.backgroundColor = [UIColor clearColor];
    self.userCarTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.userCarTable.delegate = self;
    self.userCarTable.dataSource = self;
    [self addSubview:self.userCarTable];
    // tableview高度随数据高度变化而变化
    [self.userCarTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // 给客户信息table添加清扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
    swipeGesture.delegate = self;
    [self.userCarTable addGestureRecognizer:swipeGesture];
    // 给客户信息table添加轻拍手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
    tapGesture.delegate = self;
    [self.userCarTable addGestureRecognizer:tapGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 用户车辆列表View */
    [self.userCarTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
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

#pragma mark - 回收键盘
- (void)gestureAction {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}



#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userCarArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"searchUserCarViewCell";
    SearchUserCarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SearchUserCarViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.userCarModel = self.userCarArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(userCarTableDidSelectRowAtIndexPath:)]) {
        [_delegate userCarTableDidSelectRowAtIndexPath:indexPath];
    }
}



@end
