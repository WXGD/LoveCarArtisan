//
//  EditPasswordViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditPasswordViewController.h"
// view
#import "EditPasswordView.h"
// 网络请求
#import "EditPasswordNetwork.h"

@interface EditPasswordViewController ()

/** 修改密码view */
@property (strong, nonatomic) EditPasswordView *editPasswordView;

@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self ecditPasswordLayoutView];
    // 布局nav
    [self ecditPasswordLayoutNAV];
}
#pragma mark - 保存按钮
- (void)ecditPasswordRightBtnAction {
    // 判断新密码和确认密码是否相同
    if (![self.editPasswordView.novelPasswordView.viceTF.text isEqualToString:self.editPasswordView.confirmPasswordView.viceTF.text]) {
        [MBProgressHUD showError:@"两次输入密码不相同"];
        return;
    }
    /*/index.php?c=provider&a=reset_password&v=1
     staff_user_id 	int 	是 	登录者id
     old_password 	string 	是 	旧密码
     new_password 	string 	是 	新密码      */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
    params[@"old_password"] = self.editPasswordView.oldPasswordView.viceTF.text; // 旧密码
    params[@"new_password"] = self.editPasswordView.novelPasswordView.viceTF.text; // 新密码
    [EditPasswordNetwork editAccountPasswordParams:params success:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 布局nav
- (void)ecditPasswordLayoutNAV {
    self.navigationItem.title = @"修改密码";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(ecditPasswordRightBtnAction)];
    // 根据账户输入框，修改保存按钮是否可点击属性
    RAC(self.navigationItem.rightBarButtonItem, enabled) =
    [self.editPasswordView.aggregationInfo map:^id(NSNumber *nameTF){
        return@([nameTF boolValue]);
    }];
}
#pragma mark - 布局视图
- (void)ecditPasswordLayoutView {
    /** 修改密码view */
    self.editPasswordView = [[EditPasswordView alloc] init];
    [self.view addSubview:self.editPasswordView];
    @weakify(self)
    [self.editPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
