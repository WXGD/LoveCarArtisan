//
//  CouponGoverViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponGoverViewController.h"
// 下级控制去
#import "CouponContentViewController.h"

@interface CouponGoverViewController ()

/** 优惠卷状态 */
@property (strong, nonatomic) NSArray *couponStateArray;
/** 优惠卷状态名 */
@property (strong, nonatomic) NSArray *couponStateNameArray;

@end

@implementation CouponGoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局nav
    [self couponGoverLayoutNAV];
    // 布局视图
    [self couponGoverLayoutView];
    // 网络请求
    self.couponStateArray = @[@{@"name":@"启用"}, @{@"name":@"禁用"}, @{@"name":@"过期"}];
    self.couponStateNameArray = @[@"启用", @"禁用", @"过期"];
    [self.magicView reloadData];
}
#pragma mark - 网络请求

#pragma mark - 布局nav
- (void)couponGoverLayoutNAV {
    self.navigationItem.title = @"优惠劵";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_account_account_bank"] style:UIBarButtonItemStyleDone target:self action:@selector(bankCardManagement)];
}
#pragma mark - 布局视图
- (void)couponGoverLayoutView {
    self.magicView.navigationColor = WhiteColor;
    self.magicView.sliderColor = ThemeColor;
    self.magicView.sliderWidth = ScreenW / 3 - 32;
    self.magicView.separatorHidden = YES;
    self.magicView.layoutStyle = VTLayoutStyleDivide;
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return self.couponStateNameArray;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:Black forState:UIControlStateNormal];
        menuItem.titleLabel.font = FourteenTypeface;
        [menuItem setTitleColor:ThemeColor forState:UIControlStateSelected];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *recomId = @"serviceVC";
    CouponContentViewController *couponContentVC = [magicView dequeueReusablePageWithIdentifier:recomId];
    if (!couponContentVC) {
        couponContentVC = [[CouponContentViewController alloc] init];
    }
    switch (pageIndex) {
        case 0: {
            couponContentVC.couponState = 1; // 启用
            break;
        }
        case 1: {
            couponContentVC.couponState = 0; // 禁用
            break;
        }
        case 2: {
            couponContentVC.couponState = 2; // 过期
            break;
        }
        default:
            break;
    }
    return couponContentVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
