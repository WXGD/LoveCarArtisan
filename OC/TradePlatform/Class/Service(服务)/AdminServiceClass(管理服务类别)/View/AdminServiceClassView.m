//
//  AdminServiceClassView.m
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AdminServiceClassView.h"

@interface AdminServiceClassView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *homePageScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *homePageView;

@end

@implementation AdminServiceClassView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self adminServiceClassLayoutView];
    }
    return self;
}

#pragma mark - set方法
- (void)setHaveChosenArray:(NSMutableArray *)haveChosenArray {
    _haveChosenArray = haveChosenArray;
    self.haveChosenView.haveChosenArray = haveChosenArray;
    
    [self setNeedsLayout];
}
- (void)setNotChosenArray:(NSMutableArray *)notChosenArray {
    _notChosenArray = notChosenArray;
    self.notChosenView.notChosenArray = notChosenArray;
    
    [self setNeedsLayout];
}

#pragma mark - view布局
- (void)adminServiceClassLayoutView {
    /** 背景scrollview */
    self.homePageScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.homePageScrollView];
    /** 填充scrollview的view */
    self.homePageView = [[UIView alloc] init];
    [self.homePageScrollView addSubview:self.homePageView];
    /** 已添加服务类别 */
    self.haveChosenView = [[HaveChosenView alloc] init];
    [self.homePageView addSubview:self.haveChosenView];
    /** 未添加服务类别 */
    self.notChosenView = [[NotChosenView alloc] init];
    [self.homePageView addSubview:self.notChosenView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.homePageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.homePageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.homePageScrollView.mas_top);
        make.left.equalTo(self.homePageScrollView.mas_left);
        make.bottom.equalTo(self.homePageScrollView.mas_bottom);
        make.right.equalTo(self.homePageScrollView.mas_right);
        make.width.equalTo(self.homePageScrollView.mas_width);
        make.bottom.equalTo(self.notChosenView.mas_bottom);
    }];
    /** 已添加服务类别 */
    NSInteger haveCount = self.haveChosenArray.count%3 == 0 ? self.haveChosenArray.count/3 : self.haveChosenArray.count/3 + 1;
    [self.haveChosenView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.homePageView.mas_top);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
        make.height.mas_equalTo(@(43+56*haveCount));
    }];
    /** 未添加服务类别 */
    NSInteger notCount = self.notChosenArray.count%3 == 0 ? self.notChosenArray.count/3 : self.notChosenArray.count/3 + 1;
    [self.notChosenView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.haveChosenView.mas_bottom);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
        make.height.mas_equalTo(@(35+56*notCount));
    }];
}


#pragma mark - 更新尺寸
- (void)updateConstraints {
    @weakify(self)
    /** 已添加服务类别，高度 */
    NSInteger haveCount = self.haveChosenArray.count%3 == 0 ? self.haveChosenArray.count/3 : self.haveChosenArray.count/3 + 1;
    [self.haveChosenView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.homePageView.mas_top);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
        make.height.mas_equalTo(@(43+56*haveCount));
    }];
    
    /** 未添加服务类别，高度 */
    NSInteger notCount = self.notChosenArray.count%3 == 0 ? self.notChosenArray.count/3 : self.notChosenArray.count/3 + 1;
    [self.notChosenView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.haveChosenView.mas_bottom);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
        make.height.mas_equalTo(@(35+56*notCount));
    }];
    [super updateConstraints];
}



@end
