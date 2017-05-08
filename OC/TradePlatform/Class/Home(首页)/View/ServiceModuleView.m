//
//  ServiceModuleView.m
//  TradePlatform
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServiceModuleView.h"
// view
#import "SMPageControl.h"

@interface ServiceModuleView ()<UIScrollViewDelegate>

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *serviceModuleScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *serviceModuleView;

/** 背景view */
@property (strong, nonatomic) UIView *moduleBackView;
/** 分割线 */
@property (strong, nonatomic) UIView *dividingLineView;

/** 2背景view */
@property (strong, nonatomic) UIView *twoModuleBackView;
/** 2分割线 */
@property (strong, nonatomic) UIView *twoDividingLineView;

@property (nonatomic, strong) SMPageControl *pageControl;

@end

@implementation ServiceModuleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self serviceModuleLayoutView];
    }
    return self;
}
#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.width + 0.5;
    self.pageControl.currentPage = page;
}

#pragma mark - view布局
- (void)serviceModuleLayoutView {
    /** 背景scrollview */
    self.serviceModuleScrollView = [[UIScrollView alloc] init];
    self.serviceModuleScrollView.delegate = self;
    self.serviceModuleScrollView.pagingEnabled = YES;
    self.serviceModuleScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.serviceModuleScrollView];
    /** 填充scrollview的view */
    self.serviceModuleView = [[UIView alloc] init];
    [self.serviceModuleScrollView addSubview:self.serviceModuleView];
    
    /** 背景view */
    self.moduleBackView = [[UIView alloc] init];
    self.moduleBackView.backgroundColor = WhiteColor;
    [self.serviceModuleView addSubview:self.moduleBackView];
    /** 服务 */
    self.serviceBtn = [[ModuleView alloc] init];
    self.serviceBtn.moduleImage.image = [UIImage imageNamed:@"home_page_service"];
    self.serviceBtn.moduleLabel.text = @"服务";
    self.serviceBtn.moduleBtn.tag = ServiceManageBtnAction;
    [self.moduleBackView addSubview:self.serviceBtn];
    /** 会员卡 */
    self.membershipCardBtn = [[ModuleView alloc] init];
    self.membershipCardBtn.moduleImage.image = [UIImage imageNamed:@"home_page_user_card"];
    self.membershipCardBtn.moduleLabel.text = @"会员卡";
    self.membershipCardBtn.moduleBtn.tag = UserCardBtnAction;
    [self.moduleBackView addSubview:self.membershipCardBtn];
    /** 客户 */
    self.customerBtn = [[ModuleView alloc] init];
    self.customerBtn.moduleImage.image = [UIImage imageNamed:@"home_page_customer"];
    self.customerBtn.moduleLabel.text = @"用户";
    self.customerBtn.moduleBtn.tag = CustomerBtnAction;
    [self.moduleBackView addSubview:self.customerBtn];
    /** 分割线 */
    self.dividingLineView = [[UIView alloc] init];
    self.dividingLineView.backgroundColor = DividingLine;
    [self.moduleBackView addSubview:self.dividingLineView];
    [self.dividingLineView setHidden:YES];
    /**  营销 */
    self.marketingBtn = [[ModuleView alloc] init];
    self.marketingBtn.moduleImage.image = [UIImage imageNamed:@"home_page_marketing"];
    self.marketingBtn.moduleLabel.text = @"营销";
    self.marketingBtn.moduleBtn.tag = MarketingBtnAction;
    [self.moduleBackView addSubview:self.marketingBtn];
    /** 订单 */
    self.orderBtn = [[ModuleView alloc] init];
    self.orderBtn.moduleImage.image = [UIImage imageNamed:@"home_page_order"];
    self.orderBtn.moduleLabel.text = @"订单";
    self.orderBtn.moduleBtn.tag = OrderBtnAction;
    [self.moduleBackView addSubview:self.orderBtn];
    /** 商城 */
    self.commercialCityBtn = [[ModuleView alloc] init];
    self.commercialCityBtn.moduleImage.image = [UIImage imageNamed:@"home_page_commercial_city"];
    self.commercialCityBtn.moduleLabel.text = @"批发商城";
    self.commercialCityBtn.moduleBtn.tag = CommercialCityBtnAction;
    [self.moduleBackView addSubview:self.commercialCityBtn];
    /** 2背景view */
    self.twoModuleBackView = [[UIView alloc] init];
    self.twoModuleBackView.backgroundColor = WhiteColor;
    [self.serviceModuleView addSubview:self.twoModuleBackView];
    /** 报表 */
    self.reportBtn = [[ModuleView alloc] init];
    self.reportBtn.moduleImage.image = [UIImage imageNamed:@"home_page_report"];
    self.reportBtn.moduleLabel.text = @"数据分析";
    self.reportBtn.moduleBtn.tag = ReportBtnAction;
    [self.twoModuleBackView addSubview:self.reportBtn];
    /** 2分割线 */
    self.twoDividingLineView = [[UIView alloc] init];
    self.twoDividingLineView.backgroundColor = DividingLine;
    [self.twoModuleBackView addSubview:self.twoDividingLineView];
    [self.twoDividingLineView setHidden:YES];

    // 添加pageControl
    self.pageControl = [[SMPageControl alloc] init];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.numberOfPages = 2;
    self.pageControl.indicatorMargin = 10.0f;
    self.pageControl.indicatorDiameter = 10.0f;
    self.pageControl.pageIndicatorImage = [UIImage imageNamed:@"home_page_service_unchecked"];
    self.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"home_page_service_checked"];
    [self addSubview:_pageControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.serviceModuleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.serviceModuleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serviceModuleScrollView.mas_top);
        make.left.equalTo(self.serviceModuleScrollView.mas_left);
        make.bottom.equalTo(self.serviceModuleScrollView.mas_bottom);
        make.right.equalTo(self.serviceModuleScrollView.mas_right);
        make.height.equalTo(self.serviceModuleScrollView.mas_height);
        make.width.mas_equalTo(@(ScreenW * 2));
    }];
    
    
    /** 背景view */
    [self.moduleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serviceModuleView.mas_top);
        make.left.equalTo(self.serviceModuleView.mas_left).offset(16);
        make.width.mas_equalTo(@(ScreenW - 36));
        make.bottom.equalTo(self.orderBtn.mas_bottom);
    }];
    /** 服务 */
    [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.moduleBackView.mas_top);
        make.left.equalTo(self.moduleBackView.mas_left);
    }];
    /** 会员卡 */
    [self.membershipCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.moduleBackView.mas_top);
        make.left.equalTo(self.serviceBtn.mas_right);
    }];
    /** 客户 */
    [self.customerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.moduleBackView.mas_top);
        make.left.equalTo(self.membershipCardBtn.mas_right);
        make.right.equalTo(self.moduleBackView.mas_right);
    }];
    /** 分割线 */
    [self.dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.customerBtn.mas_bottom);
        make.left.equalTo(self.moduleBackView.mas_left);
        make.right.equalTo(self.moduleBackView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    
    /** 订单 */
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineView.mas_bottom);
        make.left.equalTo(self.moduleBackView.mas_left);
    }];
    /**  营销 */
    [self.marketingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineView.mas_bottom);
        make.left.equalTo(self.orderBtn.mas_right);
    }];
    /** 商城 */
    [self.commercialCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineView.mas_bottom);
        make.left.equalTo(self.marketingBtn.mas_right);
        make.right.equalTo(self.moduleBackView.mas_right);
    }];
    /** 2背景view */
    [self.twoModuleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.moduleBackView.mas_top);
        make.left.equalTo(self.moduleBackView.mas_right).offset(32);
        make.width.equalTo(self.moduleBackView.mas_width);
        make.height.equalTo(self.moduleBackView.mas_height);
    }];
    /** 报表 */
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.twoModuleBackView.mas_top);
        make.left.equalTo(self.twoModuleBackView.mas_left);
    }];
    /** 2分割线 */
    [self.twoDividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.commercialCityBtn.mas_bottom);
        make.left.equalTo(self.twoModuleBackView.mas_left);
        make.right.equalTo(self.twoModuleBackView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    
    /** 服务,会员卡,客户,营销,报表,订单，商城 */
    [@[self.serviceBtn, self.membershipCardBtn , self.customerBtn , self.marketingBtn , self.reportBtn , self.orderBtn, self.commercialCityBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.serviceBtn.mas_width);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moduleBackView.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@100);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pageControl.mas_bottom);
    }];
}

@end
