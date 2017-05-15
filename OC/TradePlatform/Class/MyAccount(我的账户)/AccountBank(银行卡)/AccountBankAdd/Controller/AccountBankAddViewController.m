//
//  AccountBankAddViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AccountBankAddViewController.h"
#import "AccountBankAddView.h"
#import "MyAccountViewController.h"

@interface AccountBankAddViewController ()
@property (nonatomic, strong) AccountBankAddView *accountBankAddView;

/** 完成btn **/
@property (strong, nonatomic) UIButton *submitBtn;
@end

@implementation AccountBankAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self bankAddLayoutNAV];
    // 布局视图
    [self bankAddLayoutView];
}
#pragma mark - 布局nav
- (void)bankAddLayoutNAV {
        self.navigationItem.title = @"添加银行卡";
    // 左边
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}
-(void)back {
    if (_saveUseBtnClick) {
        [CustomObject returnAppointController:[MyAccountViewController class] currentVC:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 布局视图
-(void)bankAddLayoutView{
    self.accountBankAddView = [[AccountBankAddView alloc] init];
    [self.view addSubview:self.accountBankAddView];
    @weakify(self)
    /** 出险记录 */
    [self.accountBankAddView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    /** 提现btn */
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.backgroundColor = ThemeColor;
    if (_saveUseBtnClick) {
        [self.submitBtn setTitle:@"保存并使用" forState:UIControlStateNormal];
    }else{
        [self.submitBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    
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
}
// 完成添加储蓄卡
- (void)submitAction{
    if (self.accountBankAddView.bankAddNameView.viceTextFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请输入持卡人姓名"];
        return;
    }
    if (self.accountBankAddView.bankAddBankNameView.viceTextFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请输入银行名称"];
        return;
    }
    if (self.accountBankAddView.bankAddCardView.viceTextFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请输入银行卡卡号"];
        return;
    }

    
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_bank_account", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"provider_id"] = self.merchantInfo.provider_id;
    parameters[@"staff_user_id"] = self.merchantInfo.staff_user_id;
    parameters[@"name"] = self.accountBankAddView.bankAddNameView.viceTextFiled.text;
    parameters[@"card_no"] = self.accountBankAddView.bankAddCardView.viceTextFiled.text;
    parameters[@"bank"] = self.accountBankAddView.bankAddBankNameView.viceTextFiled.text;
    parameters[@"account_bank"] = self.accountBankAddView.bankAddbranchView.viceTextFiled.text;

    
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"添加银行卡中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            if (_saveUseBtnClick) {
                BankCommonModel *bankmodel = [[BankCommonModel alloc] init];
                bankmodel.card_no = parameters[@"card_no"];
                bankmodel.bank = parameters[@"bank"];
                bankmodel.name = parameters[@"name"];
                bankmodel.provider_bank_account_id = [responseObject[@"data"] objectForKey:@"provider_bank_account_id"];
                _saveUseBtnClick(bankmodel);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
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
