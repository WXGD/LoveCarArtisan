//
//  LoginViewController.m
//  LoveCarMerchant
//
//  Created by apple on 16/11/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "LogInView.h"


@interface LoginViewController ()

/** 登录界面 */
@property (strong, nonatomic) LogInView *loginView;

@end

@implementation LoginViewController

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
    // 布局视图
    [self loginlayoutView];
    // 布局NAV
    [self layoutNav];
}

#pragma mark - 点击方法
- (void)loginBtnAction:(UIButton *)button {
    switch (button.tag) {
            /** 获取验证码 */
        case VerificationBtnAction: {
            // 判断是手机号输入框内容
            if (![CustomObject checkTel:self.loginView.verificationUserName.contentField.text]) {
                [MBProgressHUD showError:@"手机号格式不对"];
                return;
            }
            /*/index.php?c=user&a=sendcode&v=1
            mobile 	string 	是 	登录手机号 */
            NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
            parame[@"mobile"] = self.loginView.verificationUserName.contentField.text;
            // 获取验证码
            [MerchantInfoModel requestVerificationParame:parame success:^{
                // 按钮倒计时
                [CustomObject buttonCountdown:button];
            }];
            break;
        }
            /** 登陆 */
        case LoginBtnAction: {
            /*/index.php?c=auth&a=login&v=1
             login_name 	string 	是 	用户名或手机号
             smscode 	string 	否 	验证码登录必传，密码登录不传
             login_password 	string 	否 	验证码登录不传，密码登录必传
             os 	int 	是 	登录设备 0：未知，1：ios，2：Android
             os_version 	string 	是 	app操作系统版本号
             device_id 	string 	是 	设备id  */
            NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
            parame[@"login_password"] = self.loginView.userPassword.contentField.text; // 验证码登录不传，密码登录必传
            parame[@"smscode"] = self.loginView.verification.contentField.text; // 验证码登录必传，密码登录不传
            // 判断是验证码登陆还是密码登陆
            if (self.loginView.loginMode.selected) { // 验证码登陆
                // 判断是手机号输入框内容
                if (![CustomObject checkTel:self.loginView.verificationUserName.contentField.text]) {
                    [MBProgressHUD showError:@"手机号格式不对"];
                    return;
                }
                // 判断是验证码输入框内容
                if (self.loginView.verification.contentField.text.length == 0) {
                    [MBProgressHUD showError:@"验证码不能为空"];
                    return;
                }
                parame[@"login_name"] = self.loginView.verificationUserName.contentField.text; // 用户名或手机号
                // 登录网络请求
                [MerchantInfoModel loginParame:parame viewController:self success:^{
                    
                }];
            }else { // 密码登陆
                // 判断是用户名输入框内容
                if (self.loginView.passwordUserName.contentField.text.length == 0) {
                    [MBProgressHUD showError:@"用户名不能为空"];
                    return;
                }
                // 判断是用户名输入框内容
                if (self.loginView.userPassword.contentField.text.length == 0) {
                    [MBProgressHUD showError:@"密码不能为空"];
                    return;
                }
                parame[@"login_name"] = self.loginView.passwordUserName.contentField.text; // 用户名或手机号
                // 登录网络请求
                [MerchantInfoModel loginParame:parame viewController:self success:^{
                    
                }];
            }
            break;
        }
        default:
            break;
    }

}

#pragma mark - 布局nav
- (void)layoutNav {
//    self.navigationItem.title = @"登录";
}
#pragma mark - 布局视图
- (void)loginlayoutView {
    /** 登录界面 */
    self.loginView = [[LogInView alloc] init];
    /** 登录按钮 */
    [self.loginView.passwordLoginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.verificationLoginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 验证码 */
    [self.loginView.verificationUserName.tfBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginView];
    @weakify(self)
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
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
