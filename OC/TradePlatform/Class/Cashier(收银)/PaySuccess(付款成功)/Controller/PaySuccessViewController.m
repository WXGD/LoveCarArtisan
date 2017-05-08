//
//  PaySuccessViewController.m
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PaySuccessViewController.h"
// view
#import "PaySuccessView.h"
// 下级控制器
#import "UserInfoViewController.h"
#import "CashierViewController.h"

@interface PaySuccessViewController ()

/** 付款成功view */
@property (strong, nonatomic) PaySuccessView *paySuccessView;

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self paySuccessLayoutNAV];
    // 布局视图
    [self paySuccessLayoutView];
    // 界面赋值
    [self paySuccessAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
// nav右边按钮
- (void)paySuccessRightBarBtnAction {
    
}
#pragma mark - 首页功能选择按钮
- (void)paySuccessBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 完善信息按钮 */
        case PerfectInfoBtnAction: {
            UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
            userInfoVC.providerUserId = [NSString stringWithFormat:@"%ld", self.userInfo.provider_user_id];
            [self.navigationController pushViewController:userInfoVC animated:YES];
            // 删除支付成功界面
            NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [navViews removeObject:self];
            [self.navigationController setViewControllers:navViews animated:YES];
            break;
        }
            /** 继续收款 */
        case ContinueCashierBtnAction: {
            // 判断页面来源
            if (self.paySuccessVCSource == CashierPaySuccessVCSource) { // 收银页
                [self.navigationController popViewControllerAnimated:YES];
            }else { // 挂单页
                CashierViewController *cashierVC = [[CashierViewController alloc] init];
                [self.navigationController pushViewController:cashierVC animated:YES];
                NSMutableArray *navViews = [NSMutableArray arrayWithObject:[self.navigationController.viewControllers firstObject]];
                [navViews addObject:[self.navigationController.viewControllers lastObject]];
                [self.navigationController setViewControllers:navViews animated:YES];
            }
            break;
        }
            /** 返回首页 */
        case ReturnHomeBtnAction: {
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 界面赋值
- (void)paySuccessAssignment {
    // 判断会员卡信息是否完善
    if (self.userInfo.is_completed != 0) { // 不完善
        [self.paySuccessView.perfectInfoView removeFromSuperview];
        [self.paySuccessView.orderInfoBackView removeArrangedSubview:self.paySuccessView.perfectInfoView];
    }
}


#pragma mark - 布局nav
- (void)paySuccessLayoutNAV {
    self.navigationController.title = @"付款成功";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(paySuccessRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(paySuccessRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)paySuccessLayoutView {
    /** 付款成功view */
    self.paySuccessView = [[PaySuccessView alloc] init];
    /** 完善信息按钮 */
    [self.paySuccessView.perfectInfoBtn addTarget:self action:@selector(paySuccessBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 继续收款 */
    [self.paySuccessView.continueCashierBtn addTarget:self action:@selector(paySuccessBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 返回首页 */
    [self.paySuccessView.returnHomeBtn addTarget:self action:@selector(paySuccessBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.paySuccessView];
    @weakify(self)
    [self.paySuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
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
