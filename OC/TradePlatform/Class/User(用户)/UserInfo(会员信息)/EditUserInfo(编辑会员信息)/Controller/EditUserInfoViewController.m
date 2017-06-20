//
//  EditUserInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditUserInfoViewController.h"
// 网络请求
#import "EditUserInfoNetwork.h"
// 下级控制器
#import "UserInfoViewController.h"

@interface EditUserInfoViewController ()

/** 编辑信息view */
@property (strong, nonatomic) CustomCell *editUserInfoView;

@end

@implementation EditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self editUserInfoLayoutView];
    // 布局nav
    [self editUserInfoLayoutNAV];
    // 界面赋值
    [self editUserInfoAssignment];
}

#pragma mark - 界面赋值
- (void)editUserInfoAssignment {
    /** 编辑信息回显文字 */
    self.editUserInfoView.viceTF.text = self.echoStr;
    // 编辑用户信息类型
    switch (self.editUserInfoType) {
            /** 编辑用户姓名 */
        case EditUserName: {
            // 编辑信息输入框限制（判断输入框不能为空）
            [self editUserInfoTextFieldSignal];
            break;
        }
            /** 编辑用户手机号 */
        case EditUserPhone: {
            // 编辑信息输入框限制（判断输入框必须为手机号）
            [self editUserPhoneInfoTextFieldSignal];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 按钮点击方法
- (void)editUserInfoRightBtnAction {
    // 编辑用户信息类型
    switch (self.editUserInfoType) {
            /** 编辑用户姓名 */
        case EditUserName: {
            // 判断输入框内容和保存内容一致
            if ([self.editUserInfoView.viceTF.text isEqualToString:self.userModel.name]) {
                [MBProgressHUD showError:@"请确认修改后在提交"];
                return;
            }
            /*/index.php?c=provider_user&a=edit&v=1
             provider_user_id 	int 	是 	用户id
             data 	string 	是 	需要修改的用户信息; 数据格式：字段=值,字段1=值1 (修改信息对应字段参考下面的备注)     */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userModel.provider_user_id]; // 用户编号
            params[@"data"] = [NSString stringWithFormat:@"name=%@", self.editUserInfoView.viceTF.text]; // 需要修改的用户信息
            [EditUserInfoNetwork editUserInfoParams:params success:^(EditUserInfoNetwork *editUserInfo) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 编辑用户手机号 */
        case EditUserPhone: {
            // 判断输入框内容和保存内容一致
            if ([self.editUserInfoView.viceTF.text isEqualToString:self.userModel.mobile]) {
                [MBProgressHUD showError:@"请确认修改后在提交"];
                return;
            }
            /*/index.php?c=provider_user&a=edit&v=1
             provider_user_id 	int 	是 	用户id
             data 	string 	是 	需要修改的用户信息; 数据格式：字段=值,字段1=值1 (修改信息对应字段参考下面的备注)     */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userModel.provider_user_id]; // 用户编号
            params[@"data"] = [NSString stringWithFormat:@"mobile=%@", self.editUserInfoView.viceTF.text]; // 需要修改的用户信息
            [EditUserInfoNetwork editUserInfoParams:params success:^(EditUserInfoNetwork *editUserInfo) {
                // 判断手机号是否存在
                if (editUserInfo.exist_user == 1) { // 手机号存在
                    [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"手机号已经存在，是否编辑已存在的用户?" admitBlock:nil noadmitBlock:^{
                        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                        userInfoVC.providerUserId = editUserInfo.provider_user_id;
                        [self.navigationController pushViewController:userInfoVC animated:YES];
                        // 删除当前页面
                        NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                        [navViews removeObject:self];
                        [self.navigationController setViewControllers:navViews animated:YES];
                    }];
                }else {
                    [MBProgressHUD showSuccess:@"修改成功"];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 布局nav
- (void)editUserInfoLayoutNAV {
    self.navigationItem.title = self.navTitleStr;
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(editUserInfoRightBtnAction)];
}
#pragma mark - 布局视图
- (void)editUserInfoLayoutView {
    /** 编辑信息view */
    self.editUserInfoView = [[CustomCell alloc] init];
    self.editUserInfoView.lineStyle = NotLine;
    self.editUserInfoView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.editUserInfoView.mainLabel.text = self.typeTitleStr;
    self.editUserInfoView.mainLabel.font = FifteenTypeface;
    self.editUserInfoView.mainLabel.textColor = Black;
    self.editUserInfoView.viceTF.placeholder = self.placeholderStr;
    self.editUserInfoView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.editUserInfoView];
    self.editUserInfoView.vTFLeftBorder = 95;
    [self.editUserInfoView.mainBtn setHidden:YES];
    @weakify(self)
    [self.editUserInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@50);
    }];
}

#pragma mark - 输入框响应
// 编辑信息输入框限制（判断输入框不能为空）
- (void)editUserInfoTextFieldSignal {
    // 获取编辑信息signal
    RACSignal *editInfoTFSignal = self.editUserInfoView.viceTF.rac_textSignal;
    // 判断编辑信息输入框最小输入位数
    RACSignal *editInfoMinNumber =
    [editInfoTFSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    // 根据账户输入框，修改保存按钮是否可点击属性
    RAC(self.navigationItem.rightBarButtonItem, enabled) =
    [editInfoMinNumber map:^id(NSNumber *nameTF){
        return@([nameTF boolValue]);
    }];
}
// 编辑信息输入框限制（判断输入框必须为手机号）
- (void)editUserPhoneInfoTextFieldSignal {
    // 获取手机号signal
    RACSignal *phoneTFSignal = self.editUserInfoView.viceTF.rac_textSignal;
    // 判断手机号输入框最大输入位数
    RACSignal *phoneMaxNumber =
    [phoneTFSignal map:^id(NSString *text) {
        return @(text.length > 10);
    }];
    // 限制手机号输入框可输入位数
    RAC(self.editUserInfoView.viceTF, text) =
    [phoneMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.editUserInfoView.viceTF.text substringToIndex:11] : self.editUserInfoView.viceTF.text;
    }];
    // 判断账户输入框输入内容，是否为手机号
    RACSignal *phoneSignal =
    [phoneTFSignal map:^id(NSString *text) {
        return @([CustomObject checkTel:text]);
    }];
    // 聚合以上信息
    RACSignal *aggregationInfo = [RACSignal combineLatest:@[phoneMaxNumber, phoneSignal]
                                             reduce:^id(NSNumber *phoneMaxNumber, NSNumber *phoneSignal){
                                                 return @([phoneMaxNumber boolValue]&&[phoneSignal boolValue]);
                                             }];
    // 根据账户输入框，修改保存按钮是否可点击属性
    RAC(self.navigationItem.rightBarButtonItem, enabled) =
    [aggregationInfo map:^id(NSNumber *nameTF){
        return@([nameTF boolValue]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
