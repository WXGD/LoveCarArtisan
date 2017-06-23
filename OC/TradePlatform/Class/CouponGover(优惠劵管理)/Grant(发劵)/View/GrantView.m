//
//  GrantView.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GrantView.h"
// view
#import "GrantUserCell.h"

@interface GrantView ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/** 按钮背景 */
@property (strong, nonatomic) UIView *buttonBackView;

@end

@implementation GrantView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self grantLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)grantLayoutView {
    /** 发劵用户view */
    self.grantUserSearchView = [[SearchView alloc] init];
    self.grantUserSearchView.searchTF.delegate = self;
    self.grantUserSearchView.isSearch = YES;
    self.grantUserSearchView.isViewBtn = YES;
    self.grantUserSearchView.searchType = OrdinaryViewLayout;
    self.grantUserSearchView.searchTF.textColor = Black;
    self.grantUserSearchView.searchTF.placeholder = @"手机号 车牌号";
    [self.grantUserSearchView.searchTF setValue:NotClick  forKeyPath:@"_placeholderLabel.textColor"];
    self.grantUserSearchView.searchTF.tintColor = ThemeColor;
    self.grantUserSearchView.searchView.backgroundColor = WhiteColor;
    self.grantUserSearchView.searchMagnifierImage.image = [UIImage imageNamed:@"nav_search_gray"];
    [self addSubview:self.grantUserSearchView];
    /** 用户table */
    self.userTable = [[UITableView alloc] init];
    self.userTable.delegate = self;
    self.userTable.dataSource = self;
    self.userTable.backgroundColor = CLEARCOLOR;
    self.userTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTable.rowHeight = 72;
    [self addSubview:self.userTable];
    UITapGestureRecognizer *userTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapAction)];
    userTap.delegate = self;
    [self.userTable addGestureRecognizer:userTap];
    /** 按钮背景 */
    self.buttonBackView = [[UIView alloc] init];
    self.buttonBackView.backgroundColor = WhiteColor;
    [self addSubview:self.buttonBackView];
    /** 确认发劵 */
    self.grantBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.grantBtn.backgroundColor = ThemeColor;
    self.grantBtn.layer.cornerRadius = 2;
    self.grantBtn.clipsToBounds = YES;
    [self.grantBtn setTitle:@"确定发放优惠卷" forState:UIControlStateNormal];
    [self.grantBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.grantBtn.titleLabel.font = SixteenTypeface;
    self.grantBtn.layer.masksToBounds = YES;
    self.grantBtn.layer.cornerRadius = 2;
    [self.buttonBackView addSubview:self.grantBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 优惠劵搜索view */
    [self.grantUserSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@30);
    }];
    /** 用户table */
    [self.userTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.grantUserSearchView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.buttonBackView.mas_top);
    }];
    /** 按钮背景 */
    [self.buttonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 按钮 */
    [self.grantBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.buttonBackView.mas_top).offset(5);
        make.left.equalTo(self.buttonBackView.mas_left).offset(16);
        make.bottom.equalTo(self.buttonBackView.mas_bottom).offset(-5);
        make.right.equalTo(self.buttonBackView.mas_right).offset(-16);
    }];
}

#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"grantUserCell";
    GrantUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GrantUserCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.userModel = [self.userArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self endEditing:YES];
    UserModel *userModel = [self.userArray objectAtIndex:indexPath.row];
    userModel.checkMark = !userModel.checkMark;
    [self.userTable reloadData];
}
#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self endEditing:YES];
}
// 轻拍手势
- (void)userTapAction {
    [self endEditing:YES];
}
#pragma mark - 手势代理，解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 判断是不是tableview触发的手势
    PDLog(@"%@", touch.view);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"CustomCell"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}

@end
