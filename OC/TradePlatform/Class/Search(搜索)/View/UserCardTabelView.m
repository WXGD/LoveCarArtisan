//
//  UserCardTabelView.m
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardTabelView.h"
#import "SearchUserCardViewCell.h"

@interface UserCardTabelView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>



@end

@implementation UserCardTabelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 布局
        [self userCardTabelViewLayoutView];
        // 网络请求
    }
    return self;
}

#pragma mark - 按钮点击方法
/** 编辑 */
- (void)userCardCellEditBtnAction:(UIButton *)button {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(userCardCellEditBtnAction:)]) {
        [_delegate userCardCellEditBtnAction:button];
    }
}
/** 充值 */
- (void)userCardCellRechargeBtnAction:(UIButton *)button {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(userCardCellRechargeBtnAction:)]) {
        [_delegate userCardCellRechargeBtnAction:button];
    }
}


#pragma mark - view布局
- (void)userCardTabelViewLayoutView {
    /** 客户卡table */
    self.userCardTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.userCardTable.backgroundColor = [UIColor clearColor];
    self.userCardTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.userCardTable.delegate = self;
    self.userCardTable.dataSource = self;
    [self addSubview:self.userCardTable];
    // 给客户信息table添加清扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
    swipeGesture.delegate = self;
    [self.userCardTable addGestureRecognizer:swipeGesture];
    // 给客户信息table添加轻拍手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
    tapGesture.delegate = self;
    [self.userCardTable addGestureRecognizer:tapGesture];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 客户卡table */
    [self.userCardTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
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
    return self.userCardArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"searchUserCardViewCell";
    SearchUserCardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SearchUserCardViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.userCardModel = [self.userCardArray objectAtIndex:indexPath.row];
    /** 编辑 */
    cell.editBtn.tag = indexPath.row;
    /** 充值 */
    cell.rechargeBtn.tag = indexPath.row;
    /** 编辑 */
    [cell.editBtn addTarget:self action:@selector(userCardCellEditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 充值 */
    [cell.rechargeBtn addTarget:self action:@selector(userCardCellRechargeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 126;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
