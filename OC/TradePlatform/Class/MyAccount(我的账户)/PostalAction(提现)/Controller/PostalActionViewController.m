//
//  PostalActionViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PostalActionViewController.h"
#import "PostalActionView.h"
//下级
#import "AccountBankViewController.h"
#import "AccountBankAddViewController.h"

@interface PostalActionViewController ()
/** 银行view **/
@property (strong, nonatomic) PostalActionView *postalActionView;
/** 金额view **/
@property (strong, nonatomic) UsedCellView *moneyView;
/** 提交btn **/
@property (strong, nonatomic) UIButton *submitBtn;
/** 银行卡信息 **/
@property (strong, nonatomic) BankCommonModel *bankCommonModel;
@end

@implementation PostalActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self postalLayoutNAV];
    // 布局视图
    [self postalLayoutView];
    // 获取银行卡数据
    [self getDefaulBankCard];
}
#pragma mark - 布局nav
- (void)postalLayoutNAV {
    self.navigationItem.title = @"账户";
    // 左边
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
}
#pragma mark - 布局视图
- (void)postalLayoutView{
    self.postalActionView = [[PostalActionView alloc] init];
    [self.view addSubview:self.postalActionView];
    @weakify(self)
    [self.postalActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(73);
    }];
    /** 提现金额view */
    self.moneyView = [[UsedCellView alloc] init];
    self.moneyView.cellLabel.text = @"提现金额";
    self.moneyView.cellLabel.font = FourteenTypeface;
    self.moneyView.cellLabel.textColor = GrayH1;
    self.moneyView.describeLabel.text = [NSString stringWithFormat:@"%.2f元",self.amount];
    self.moneyView.describeLabel.font = FourteenTypeface;
    self.moneyView.describeLabel.textColor = HEXSTR_RGB(@"ef5350");
    self.moneyView.isCellImage = YES;
    self.moneyView.isArrow = YES;
    self.moneyView.isSplistLine = YES;
    [self.view addSubview:self.moneyView];
    [self.moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.postalActionView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(48);
    }];
    /** 提现btn */
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.backgroundColor = ThemeColor;
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = SixteenTypeface;
    self.submitBtn.layer.cornerRadius = 2;
    self.submitBtn.clipsToBounds = YES;
    [self.view addSubview:self.submitBtn];
    [self.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(40);
    }];
    
    [self.postalActionView.postalBackView.usedCellBtn addTarget:self action:@selector(selectBank) forControlEvents:UIControlEventTouchUpInside];
}
// 提交申请
- (void)submitAction{
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider", @"withdraw", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"provider_id"] = self.merchantInfo.provider_id;
    parameters[@"staff_user_id"] = self.merchantInfo.staff_user_id;
    parameters[@"provider_bank_account_id"] = self.bankCommonModel.provider_bank_account_id;
    
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"提现申请中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}
// 选择银行卡
- (void)selectBank{
    AccountBankViewController *accountBankVC = [[AccountBankViewController alloc] init];
    accountBankVC.bankViewFrom = BankSelect;
    accountBankVC.selextBankClick = ^(BankCommonModel *bankCommonModel) {
        self.bankCommonModel = bankCommonModel;
        self.postalActionView.postalMoneyTitle.text = bankCommonModel.bank;
        self.postalActionView.postalMoneyLabel.text = bankCommonModel.card_no;
    };
    [self.navigationController pushViewController:accountBankVC animated:YES];
}
-(void)getDefaulBankCard{
    AccountBankModel *accountBankModel = [[AccountBankModel alloc] init];
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    // 网络请求
    
    [accountBankModel AccountBankRefreshRequestData:nil params:params viewController:self success:^(AccountBankModel *accountBankModel) {

        // 判断是否有数据
        if (!accountBankModel.DefaultModel) {
            AccountBankAddViewController *bankAddVC = [[AccountBankAddViewController alloc] init];
            bankAddVC.saveUseBtnClick = ^(BankCommonModel *bankCommonModel) {
                if (bankCommonModel) {
                    self.bankCommonModel = bankCommonModel;
                    self.postalActionView.postalMoneyTitle.text = bankCommonModel.bank;
                    self.postalActionView.postalMoneyLabel.text = bankCommonModel.card_no;
                }else{
                }
                
            };
            [self.navigationController pushViewController:bankAddVC animated:NO];
            [MBProgressHUD showError:@"请先添加银行卡再提现"];
        } else {
            self.bankCommonModel = accountBankModel.DefaultModel;
            self.postalActionView.postalMoneyTitle.text = accountBankModel.DefaultModel.bank;
            self.postalActionView.postalMoneyLabel.text = accountBankModel.DefaultModel.card_no;
        }
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
