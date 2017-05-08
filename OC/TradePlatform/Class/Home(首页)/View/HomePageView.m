//
//  HomePageView.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePageView.h"

@interface HomePageView ()

/** 填充scrollview的view */
@property (strong, nonatomic) UIView *homePageView;

@end

@implementation HomePageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self homePageViewLayout];
    }
    return self;
}
- (void)homePageViewLayout {
    /** 背景scrollview */
    self.homePageScrollView = [[UIScrollView alloc] init];
    self.homePageScrollView.backgroundColor = VCBackground;
    [self addSubview:self.homePageScrollView];
    /** 填充scrollview的view */
    self.homePageView = [[UIView alloc] init];
    self.homePageView.backgroundColor = VCBackground;
    [self.homePageScrollView addSubview:self.homePageView];
    /** 时时数据 */
    self.showDataView = [[ShowDataView alloc] init];
    self.showDataView.backgroundColor = WhiteColor;
    [self.homePageView addSubview:self.showDataView];
    /** 服务模块 */
    self.serviceModuleView = [[ServiceModuleView alloc] init];
    [self.homePageView addSubview:self.serviceModuleView];
    /** 工匠资讯 */
    self.bannerView = [[BannerView alloc] init];
    self.bannerView.backgroundColor = WhiteColor;
    [self.homePageView addSubview:self.bannerView];
    /** 底部提示 */
    self.bottomSignView = [[ScrollBottomView alloc] init];
    self.bottomSignView.backgroundColor = VCBackground;
    [self.homePageView addSubview:self.bottomSignView];
    /** 挂单入口按钮 */
    self.btnPendOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPendOrder.tag = PendOrderBtnActio;
    [self.btnPendOrder setImage:[UIImage imageNamed:@"pendorder_click"] forState:UIControlStateSelected];
    [self.btnPendOrder setImage:[UIImage imageNamed:@"pendorder_unclick"] forState:UIControlStateNormal];
    [self addSubview:self.btnPendOrder];
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
        make.bottom.equalTo(self.bottomSignView.mas_bottom);
    }];
    /** 时时数据 */
    [self.showDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.homePageView.mas_top);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
    }];
    /** 服务模块 */
    [self.serviceModuleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.showDataView.mas_bottom);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
    }];
    /** 工匠资讯 */
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serviceModuleView.mas_bottom).offset(10);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
    }];
    /** 底部提示 */
    [self.bottomSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.bannerView.mas_bottom);
        make.left.equalTo(self.homePageView.mas_left);
        make.right.equalTo(self.homePageView.mas_right);
    }];
    /** 挂单入口按钮 */
    [self.btnPendOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-16);
        make.bottom.equalTo(self.mas_bottom).offset(-16);
        make.height.mas_equalTo(@55);
        make.width.mas_equalTo(@55);
    }];
}



@end
