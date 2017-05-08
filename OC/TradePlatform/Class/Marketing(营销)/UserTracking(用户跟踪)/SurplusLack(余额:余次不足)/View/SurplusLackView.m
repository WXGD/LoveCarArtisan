//
//  SurplusLackView.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import "SurplusLackView.h"

@interface SurplusLackView ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

/** 卡剩余选项卡view */
@property (strong, nonatomic) UIView *cardSurplusTabView;
/** 余额不足 */
@property (strong, nonatomic) UIButton *balanceNotEnoughBtn;
/** 余次不足 */
@property (strong, nonatomic) UIButton *numNotEnoughBtn;
/** 选中按钮 */
@property (strong, nonatomic) UIButton *checkBtn;
/** 卡剩余查询标记view */
@property (strong, nonatomic) UIView *cardSurplusQuirySignView;
/** 卡剩余选项卡ScrollView */
@property (strong, nonatomic) UIScrollView *benTabScorllView;
/** 卡剩余选项卡填充背景View */
@property (strong, nonatomic) UIView *benTabBackView;

@end

@implementation SurplusLackView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self surplusLackLayoutView];
    }
    return self;
}
#pragma mark - 按钮点击
// tab按钮选择
- (void)cardSurplusTabBtnAction:(UIButton *)button {
    // 回收键盘
    [self endEditing:YES];
    self.checkBtn.selected = !self.checkBtn.selected;
    self.checkBtn = button;
    self.checkBtn.selected = !self.checkBtn.selected;
    /** 选中标记 */
    // 告诉self约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.benTabScorllView.contentOffset = CGPointMake(ScreenW * (self.checkBtn.tag - 5010), 0);
        if (_delegate && [_delegate respondsToSelector:@selector(cardSurplusTabChoiceDelegate:)]) {//self.checkBtn.tag != 5010 && 
            [_delegate cardSurplusTabChoiceDelegate:self.checkBtn.tag];
        }
    }];
    
}
#pragma mark - scrollview滚动代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![NSStringFromClass([scrollView class]) isEqualToString:@"UITableView"]) {
        UIButton *checkBtn = (UIButton *)[self viewWithTag: scrollView.contentOffset.x / ScreenW + 5010];
        [self cardSurplusTabBtnAction:checkBtn];
    }
}

- (void)surplusLackLayoutView {
    /** 卡剩余选项卡view */
    self.cardSurplusTabView = [[UIView alloc] init];
    self.cardSurplusTabView.backgroundColor = WhiteColor;
    [self addSubview:self.cardSurplusTabView];
    /** 余额不足 */
    self.balanceNotEnoughBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.balanceNotEnoughBtn setTitle:@"余额不足" forState:UIControlStateNormal];
    self.balanceNotEnoughBtn.titleLabel.font = FourteenTypeface;
    [self.balanceNotEnoughBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.balanceNotEnoughBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [self.balanceNotEnoughBtn addTarget:self action:@selector(cardSurplusTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.balanceNotEnoughBtn.tag = 5010;
    [self.cardSurplusTabView addSubview:self.balanceNotEnoughBtn];
    self.checkBtn = self.balanceNotEnoughBtn;
    self.balanceNotEnoughBtn.selected = YES;
    /** 余次不足 */
    self.numNotEnoughBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.numNotEnoughBtn setTitle:@"余次不足" forState:UIControlStateNormal];
    self.numNotEnoughBtn.titleLabel.font = FourteenTypeface;
    [self.numNotEnoughBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.numNotEnoughBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [self.numNotEnoughBtn addTarget:self action:@selector(cardSurplusTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.numNotEnoughBtn.tag = 5011;
    [self.cardSurplusTabView addSubview:self.numNotEnoughBtn];
    /** 卡剩余查询标记view */
    self.cardSurplusQuirySignView = [[UIView alloc] init];
    self.cardSurplusQuirySignView.backgroundColor = ThemeColor;
    [self.cardSurplusTabView addSubview:self.cardSurplusQuirySignView];
    /** 卡剩余选项卡ScrollView */
    self.benTabScorllView = [[UIScrollView alloc] init];
    self.benTabScorllView.pagingEnabled = YES;
    self.benTabScorllView.showsHorizontalScrollIndicator = NO;
    self.benTabScorllView.delegate = self;
    [self addSubview:self.benTabScorllView];
    // 添加回收键盘的手势
    UITapGestureRecognizer *benTabTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(benTabTapAction:)];
    benTabTap.delegate = self;
    [self.benTabScorllView addGestureRecognizer:benTabTap];
    /** 卡剩余选项卡填充背景View */
    self.benTabBackView = [[UIView alloc] init];
    [self.benTabScorllView addSubview:self.benTabBackView];
    /** 余额View */
    self.balanceView = [[ExpireTableView alloc] init];
    self.balanceView.expireHeaderView.seleAreaBtn.tag = BalanceNotEnoughBtnAction;
    self.balanceView.expireCellType = BalanceExpireCellShowType;
    [self.benTabBackView addSubview:self.balanceView];
    /** 余次View */
    self.leaveSecondView = [[ExpireTableView alloc] init];
    self.leaveSecondView.expireHeaderView.seleAreaBtn.tag = NumNotEnoughBtnAction;
    self.leaveSecondView.expireCellType = LeaveSecondExpireCellShowType;
    [self.benTabBackView addSubview:self.leaveSecondView];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡剩余选项卡view */
    [self.cardSurplusTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@44);
    }];
    /** 余额不足 */
    [self.balanceNotEnoughBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardSurplusTabView.mas_top);
        make.bottom.equalTo(self.cardSurplusTabView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_centerX);
    }];
    /** 余次不足 */
    [self.numNotEnoughBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardSurplusTabView.mas_top);
        make.bottom.equalTo(self.cardSurplusTabView.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_centerX);
    }];
    /** 卡剩余查询标记view */
    [self.cardSurplusQuirySignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.cardSurplusTabView.mas_bottom);
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake((ScreenW / 2 - 32), 2));
    }];
    /** 卡剩余选项卡ScrollView */
    [self.benTabScorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardSurplusTabView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 卡剩余选项卡填充背景View */
    [self.benTabBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benTabScorllView.mas_top);
        make.left.equalTo(self.benTabScorllView.mas_left);
        make.bottom.equalTo(self.benTabScorllView.mas_bottom);
        make.right.equalTo(self.benTabScorllView.mas_right);
        make.height.equalTo(self.benTabScorllView.mas_height);
        make.width.mas_equalTo(@(ScreenW * 2));
    }];
    /** 余额View */
    [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benTabBackView.mas_top);
        make.left.equalTo(self.benTabBackView.mas_left);
        make.bottom.equalTo(self.benTabBackView.mas_bottom);
        make.right.equalTo(self.benTabBackView.mas_centerX);
    }];
    /** 余次View */
    [self.leaveSecondView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benTabBackView.mas_top);
        make.left.equalTo(self.benTabBackView.mas_centerX);
        make.bottom.equalTo(self.benTabBackView.mas_bottom);
        make.right.equalTo(self.benTabBackView.mas_right);
    }];
}

- (void)updateConstraints {
    @weakify(self)
    /** 卡剩余查询标记view */
    [self.cardSurplusQuirySignView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake((ScreenW / 2 - 32), 2));
        make.bottom.equalTo(self.cardSurplusTabView.mas_bottom);
    }];
    [super updateConstraints];
}


#pragma mark - 手势代理，解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 判断是不是tableview触发的手势
    PDLog(@"%@", [touch.view class]);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIImageView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}

#pragma mark - 回收键盘的方法
- (void)benTabTapAction:(UIButton *)button {
    [self endEditing:YES];
}



@end
