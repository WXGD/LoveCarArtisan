//
//  AccountViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountView.h"
// 下级控制器
#import "SetUpViewController.h"
#import "StoreInfoViewController.h"
#import "QRCodeViewController.h"
#import "AloneInfoViewController.h"
#import "MyAccountViewController.h"
#import "AboutUsViewController.h"

@interface AccountViewController ()

/** 账户view */
@property (strong, nonatomic) AccountView *accountView;

@end

@implementation AccountViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 界面赋值
    [self accountAssignment];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self accountLayoutNAV];
    // 布局视图
    [self accountLayoutView];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
//  账户页面按钮点击方法
- (void)accountBtnAction:(UIButton *)button {
    switch (button.tag) {
        /** 当前用户 */
        case CurrentUserBtnAction: {
            AloneInfoViewController *aloneInfoVC = [[AloneInfoViewController alloc] init];
            [self.navigationController pushViewController:aloneInfoVC animated:YES];
            break;
        }
        /** 商户信息 */
        case TenantsInfoBtnAction: {
            StoreInfoViewController *storeInfoVC = [[StoreInfoViewController alloc] init];
            [self.navigationController pushViewController:storeInfoVC animated:YES];
            break;
        }
        /** 二维码 */
        case QRCodeBtnAction: {
            QRCodeViewController *qrCodeVC = [[QRCodeViewController alloc] init];
            qrCodeVC.imageStr = self.merchantInfo.wxmp_qrcode;
            qrCodeVC.textStr = @"扫一扫上面的二维码图案,\n\n添加微信公众号";
            [self.navigationController pushViewController:qrCodeVC animated:YES];
            break;
        }
        /** 我的账户 */
        case MyAccountBtnAction: {
            MyAccountViewController *myAccountVC = [[MyAccountViewController alloc] init];
            [self.navigationController pushViewController:myAccountVC animated:YES];
            break;
        }
        /** 设置 */
        case SetUpBtnAction: {
            SetUpViewController *setUpVC = [[SetUpViewController alloc] init];
            [self.navigationController pushViewController:setUpVC animated:YES];
            break;
        }
            /** 关于我们 */
        case aboutUsBtnAction: {
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
            NSString *WEBURL = [NSString stringWithFormat:@"%@%@", WEBAPI, @"aboutUs/aboutUs.html"];
            aboutUsVC.webUrl = WEBURL;
            [self.navigationController pushViewController:aboutUsVC animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 界面赋值
- (void)accountAssignment {
    /** 当前用户 */
    self.accountView.currentUserView.mainLabel.text = self.merchantInfo.user_name;
//    /** 商户信息 */
//    self.accountView.tenantsInfoView.describeLabel.text = self.merchantInfo.name;
}
#pragma mark - 布局nav
- (void)accountLayoutNAV {
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)accountLayoutView {
    /** 账户view */
    self.accountView = [[AccountView alloc] init];
    /** 当前用户 */
    [self.accountView.currentUserView.mainBtn addTarget:self action:@selector(accountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    /** 商户信息 */
//    [self.accountView.tenantsInfoView.usedCellBtn addTarget:self action:@selector(accountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    /** 二维码 */
//    [self.accountView.QRCodeView.usedCellBtn addTarget:self action:@selector(accountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 我的账户 */
//    [self.accountView.myAccountView.usedCellBtn addTarget:self action:@selector(accountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 设置 */
    [self.accountView.setUpView.mainBtn addTarget:self action:@selector(accountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    /** 关于我们 */
//    [self.accountView.aboutUsView.usedCellBtn addTarget:self action:@selector(accountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.accountView];
    @weakify(self)
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
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
