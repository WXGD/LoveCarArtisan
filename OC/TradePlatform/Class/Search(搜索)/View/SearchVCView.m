//
//  SearchVCView.m
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchVCView.h"

@interface SearchVCView ()<UIScrollViewDelegate>

/** 搜索头部选项卡view */
@property (strong, nonatomic) UIView *searchHeaderView;
/** 会员 */
@property (strong, nonatomic) UIButton *userBtn;
/** 会员卡 */
@property (strong, nonatomic) UIButton *userCardBtn;
/** 会员车辆 */
@property (strong, nonatomic) UIButton *userCarBtn;
/** 选中标记 */
@property (strong, nonatomic) UIView *checkMarkView;
/** 选中按钮 */
@property (strong, nonatomic) UIButton *checkBtn;

/** 背景View */
@property (strong, nonatomic) UIView *backView;

@end


@implementation SearchVCView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self searchHeaderViewLayoutView];
    }
    return self;
}


- (void)buttonAction:(UIButton *)button {
    // 回收键盘
    [self endEditing:YES];
    [self.checkBtn setTitleColor:RGBA(256, 256, 256, 0.6) forState:UIControlStateNormal];
    self.checkBtn.titleLabel.font = FourteenTypeface;
    self.checkBtn = button;
    [self.checkBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.checkBtn.titleLabel.font = FourteenTypefaceBold;
    /** 选中标记 */
    // 告诉self约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.backScrollView.contentOffset = CGPointMake(ScreenW * (self.checkBtn.tag - 2010), 0);
    }];
    if (_delegate && [_delegate respondsToSelector:@selector(searchVCbuttonAction:)]) {
        [_delegate searchVCbuttonAction:button];
    }
}




#pragma mark - scrollview滚动代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    UIButton *checkBtn = (UIButton *)[self viewWithTag: scrollView.contentOffset.x / ScreenW + 2010];
    [self buttonAction:checkBtn];
}

#pragma mark - view布局
- (void)searchHeaderViewLayoutView {
    /** 搜索头部选项卡view */
    self.searchHeaderView = [[UIView alloc] init];
    self.searchHeaderView.backgroundColor = ThemeColor;
    [self addSubview:self.searchHeaderView];
    /** 会员 */
    self.userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userBtn setTitle:@"用户" forState:UIControlStateNormal];
    [self.userBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.userBtn.titleLabel.font = FourteenTypefaceBold;
    [self.userBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.userBtn.tag = 2010;
    [self.searchHeaderView addSubview:self.userBtn];
    self.checkBtn = self.userBtn;
    /** 会员车辆 */
    self.userCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userCarBtn setTitle:@"用户车辆" forState:UIControlStateNormal];
    [self.userCarBtn setTitleColor:RGBA(256, 256, 256, 0.6) forState:UIControlStateNormal];
    self.userCarBtn.titleLabel.font = FourteenTypeface;
    [self.userCarBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.userCarBtn.tag = 2011;
    [self.searchHeaderView addSubview:self.userCarBtn];
    /** 会员卡 */
    self.userCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userCardBtn setTitle:@"会员卡" forState:UIControlStateNormal];
    [self.userCardBtn setTitleColor:RGBA(256, 256, 256, 0.6) forState:UIControlStateNormal];
    self.userCardBtn.titleLabel.font = FourteenTypeface;
    [self.userCardBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.userCardBtn.tag = 2012;
    [self.searchHeaderView addSubview:self.userCardBtn];
    /** 选中标记 */
    self.checkMarkView = [[UIView alloc] init];
    self.checkMarkView.backgroundColor = WhiteColor;
    [self.searchHeaderView addSubview:self.checkMarkView];
    /** 背景ScrollView */
    self.backScrollView = [[UIScrollView alloc] init];
    self.backScrollView.pagingEnabled = YES;
    self.backScrollView.showsHorizontalScrollIndicator = NO;
    self.backScrollView.delegate = self;
    [self addSubview:self.backScrollView];
    /** 背景View */
    self.backView = [[UIView alloc] init];
    [self.backScrollView addSubview:self.backView];
    /** 用户Tabel */
    self.userTableView = [[UserTableView alloc] init];
    [self.backView addSubview:self.userTableView];
    /** 用户车Tabel */
    self.userCarTableView = [[UserCarTableView alloc] init];
    [self.backView addSubview:self.userCarTableView];
    /** 用户卡Tabel */
    self.userCardTableView = [[UserCardTabelView alloc] init];
    [self.backView addSubview:self.userCardTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 搜索头部选项卡view */
    [self.searchHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 会员 */
    [self.userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.searchHeaderView.mas_left);
    }];
    /** 会员卡 */
    [self.userCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userBtn.mas_right);
    }];
    /** 会员车辆 */
    [self.userCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.userCarBtn.mas_right);
        make.right.equalTo(self.searchHeaderView.mas_right);
    }];
    /** 会员, 会员卡, 会员车辆 */
    [@[self.userBtn, self.userCarBtn, self.userCardBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.searchHeaderView.mas_bottom);
        make.top.equalTo(self.searchHeaderView.mas_top);
        make.width.equalTo(self.userBtn.mas_width);
    }];
    /** 选中标记 */
    [self.checkMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(18, 2));
        make.bottom.equalTo(self.searchHeaderView.mas_bottom).offset(-3);
    }];
    /** 背景scrollview */
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.searchHeaderView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backScrollView.mas_top);
        make.left.equalTo(self.backScrollView.mas_left);
        make.bottom.equalTo(self.backScrollView.mas_bottom);
        make.right.equalTo(self.backScrollView.mas_right);
        make.height.equalTo(self.backScrollView.mas_height);
        make.width.mas_equalTo(@(ScreenW * 3));
    }];
    /** 用户Tabel */
    [self.userTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView.mas_top);
        make.left.equalTo(self.backView.mas_left);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.width.mas_equalTo(@(ScreenW));
    }];
    /** 用户车Tabel */
    [self.userCarTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView.mas_top);
        make.left.equalTo(self.userTableView.mas_right);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.width.mas_equalTo(@(ScreenW));
    }];
    /** 用户卡Tabel */
    [self.userCardTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView.mas_top);
        make.left.equalTo(self.userCarTableView.mas_right);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.width.mas_equalTo(@(ScreenW));
    }];
}
- (void)updateConstraints {
    @weakify(self)
    /** 选中标记 */
    [self.checkMarkView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(18, 2));
        make.bottom.equalTo(self.searchHeaderView.mas_bottom).offset(-3);
    }];
    [super updateConstraints];
}

@end
