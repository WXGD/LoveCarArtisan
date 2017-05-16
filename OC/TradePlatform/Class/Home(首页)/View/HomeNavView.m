//
//  HomeNavView.m
//  TradePlatform
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeNavView.h"

@interface HomeNavView ()

/** 状态栏view */
@property (strong, nonatomic) UIView *stactView;
/** 导航栏view */
@property (strong, nonatomic) UIView *navView;

@end

@implementation HomeNavView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self homeNavLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)homeNavLayoutView {
    /** 状态栏view */
    self.stactView = [[UIView alloc] init];
    self.stactView.backgroundColor = ThemeColor;
    [self addSubview:self.stactView];
    /** 导航栏view */
    self.navView = [[UIView alloc] init];
    self.navView.backgroundColor = ThemeColor;
    [self addSubview:self.navView];
    /** 搜索框view */
    self.search = [[SearchView alloc] init];
    self.search.isSearch = YES;
    self.search.searchType = NavigationLayout;
    [self.navView addSubview:self.search];
    /** 快捷方式 */
    self.shortcutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shortcutBtn setImage:[UIImage imageNamed:@"nav_add"] forState:UIControlStateNormal];
    [self.navView addSubview:self.shortcutBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 状态栏view */
    [self.stactView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@20);
    }];
    /** 导航栏view */
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.stactView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@44);
    }];
    /** 搜索框view */
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.navView.mas_centerX);
        make.centerY.equalTo(self.navView.mas_centerY);
    }];
    /** 快捷方式 */
    [self.shortcutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.navView.mas_right).offset(-10);
        make.top.equalTo(self.navView.mas_top);
        make.bottom.equalTo(self.navView.mas_bottom);
        make.width.equalTo(self.shortcutBtn.mas_height);
    }];
    /** self高度 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.navView.mas_bottom);
    }];
}

@end
