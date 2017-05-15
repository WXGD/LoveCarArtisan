//
//  MyAccountViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyAccountViewController.h"
// view
#import "MyAccountView.h"
#import "MyAccountHeaderView.h"
#import "MyAccountBalanceModel.h"
#import "WithdrawRecordModel.h"
// 下级控制器
#import "PostalInfoViewController.h"
#import "PostalActionViewController.h"
#import "AccountBankViewController.h"

@interface MyAccountViewController ()<MyAccountDelegate>

/** 我的账户 */
@property (strong, nonatomic) MyAccountView *myAccountView;

/** 我的账户 */
@property (strong, nonatomic) MyAccountBalanceModel *myAccountBalanceModel;

@end

@implementation MyAccountViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
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
    // 网络请求
    [self myAccountRequestData];
}
#pragma mark - 网络请求
- (void)myAccountRequestData{
    /** 请求账户余额和已经提现余额 */
        /*/index.php?c=provider&a=amount&v=1
         provider_id 	int 	是 	服务商id   */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        [MyAccountBalanceModel requestAccountBalance:params success:^(MyAccountBalanceModel *accountBalance) {
            // 界面赋值
            [self myAccountAssignment:accountBalance];
            self.myAccountBalanceModel = accountBalance;
        }];
}
#pragma mark - 按钮点击方法
- (void)myAccountBtnAvtion:(UIButton *)button {
    
}
// 提现记录cell点击
- (void)postalRecordCellDidSelect:(WithdrawRecordModel *)model {
    PostalInfoViewController *postalInfoVC = [[PostalInfoViewController alloc] init];
    postalInfoVC.postalInfoModel = model;
    [self.navigationController pushViewController:postalInfoVC animated:YES];
}

#pragma mark - 界面赋值
- (void)myAccountAssignment:(MyAccountBalanceModel *)accountBalance {
    /** 我的余额 */
    self.myAccountView.headerView.balanceLabel.text = [NSString stringWithFormat:@"%.2f", accountBalance.all_amount];
    /** 已提现余额 */
    self.myAccountView.headerView.historyPostalLabel.text = [NSString stringWithFormat:@"%.2f元", accountBalance.withdraw];
    /** 最多提现余额 */
    self.myAccountView.headerView.mostPostalLabel.text = [NSString stringWithFormat:@"%.2f元", accountBalance.amount];
    /** 提现数据 */
    self.myAccountView.recordArray = accountBalance.withdraw_record;
    [self.myAccountView.postalRecordTable reloadData];
    
}
#pragma mark - 布局nav
- (void)myAccountLayoutNAV {
    self.navigationItem.title = @"账户";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_account_account_bank"] style:UIBarButtonItemStyleDone target:self action:@selector(bankCardManagement)];
}
#pragma mark - 布局视图
- (void)myAccountLayoutView {
    /** 我的账户 */
    self.myAccountView = [[MyAccountView alloc] init];
    self.myAccountView.delegate = self;
    [self.view addSubview:self.myAccountView];
    @weakify(self)
    [self.myAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.myAccountView.headerView.postalBtn addTarget:self action:@selector(cashWithdrawal) forControlEvents:UIControlEventTouchUpInside];
}
// 银行卡管理
- (void)bankCardManagement{
    AccountBankViewController *accountBankVC = [[AccountBankViewController alloc] init];
    accountBankVC.bankViewFrom = management;
    [self.navigationController pushViewController:accountBankVC animated:YES];
}
// 提现
-(void)cashWithdrawal{
    if (_myAccountBalanceModel.amount<=0) {
        [MBProgressHUD showError:@"暂无可提现金额"];
        return;
    }
    PostalActionViewController *postalVC = [[PostalActionViewController alloc] init];
    postalVC.amount = self.myAccountBalanceModel.amount;
    [self.navigationController pushViewController:postalVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
