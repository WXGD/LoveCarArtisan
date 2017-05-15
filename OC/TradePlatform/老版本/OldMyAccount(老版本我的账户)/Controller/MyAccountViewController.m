//
//  MyAccountViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MyAccountView.h"
#import "MyAccountBalanceModel.h"

@interface MyAccountViewController ()

/** 我的账户view */
@property (strong, nonatomic) MyAccountView *myAccountView;

@end

@implementation MyAccountViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
    [self myAccountLayoutNAV];
    // 布局视图
    [self myAccountLayoutView];
    /** 请求账户余额和已经提现余额 */
    [self myAccountrequestAccountBalance];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
/** 请求账户余额和已经提现余额 */
- (void)myAccountrequestAccountBalance {
    /*/index.php?c=provider&a=amount&v=1
     provider_id 	int 	是 	服务商id   */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    [MyAccountBalanceModel requestAccountBalance:params success:^(MyAccountBalanceModel *accountBalance) {
        // 界面赋值
        [self myAccountAssignment:accountBalance];
    }];
}
/** 申请提现 */
- (void)applyBtnAction:(UIButton *)button {
    /*/index.php?c=provider&a=withdraw&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录用户id  */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 服务商编号
    [MyAccountBalanceModel providerWithdrawParams:params success:^{
        
    }];
}
#pragma mark - 界面赋值
- (void)myAccountAssignment:(MyAccountBalanceModel *)accountBalance {
    /** 我的余额 */
    self.myAccountView.myBalanceLabel.text = [NSString stringWithFormat:@"%.2f", accountBalance.amount];
    /** 已提现余额 */
    self.myAccountView.userBalanceLabel.viceLabel.text = [NSString stringWithFormat:@"%.2f元", accountBalance.withdraw];
    /** 提现数据 */
    self.myAccountView.recordArray = accountBalance.withdraw_record;
    [self.myAccountView.recordTableView reloadData];
}
#pragma mark - 布局nav
- (void)myAccountLayoutNAV {
    self.navigationItem.title = @"我的账户";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)myAccountLayoutView {
    @weakify(self)
    /** 二维码 */
    self.myAccountView = [[MyAccountView alloc] init];
    /** 申请提现 */
    [self.myAccountView.applyBtn addTarget:self action:@selector(applyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myAccountView];
    [self.myAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
