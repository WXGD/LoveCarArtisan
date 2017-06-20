//
//  CouponContentViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponContentViewController.h"
// view
#import "CouponContentView.h"

@interface CouponContentViewController ()

/** 优惠劵内容 */
@property (strong, nonatomic) CouponContentView *couponContentView;

@end

@implementation CouponContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self couponContentLayoutView];
}

#pragma mark - 布局视图
- (void)couponContentLayoutView {
    /** 优惠劵内容 */
    self.couponContentView = [[CouponContentView alloc] init];
    [self.view addSubview:self.couponContentView];
    @weakify(self)
    [self.couponContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
