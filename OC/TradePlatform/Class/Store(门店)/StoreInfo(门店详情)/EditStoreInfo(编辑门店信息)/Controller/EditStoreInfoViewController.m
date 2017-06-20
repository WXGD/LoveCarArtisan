//
//  EditStoreInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditStoreInfoViewController.h"
// 网络请求
#import "EditStoreInfoNetwork.h"

@interface EditStoreInfoViewController ()

/** 编辑店面信息view */
@property (strong, nonatomic) CustomCell *editStoreInfoView;

@end

@implementation EditStoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self editStoreInfoLayoutView];
    // 布局nav
    [self editStoreInfoLayoutNAV];
    // 界面赋值
    [self editStoreInfoAssignment];
}

#pragma mark - 界面赋值
- (void)editStoreInfoAssignment {
    /** 编辑信息回显文字 */
    self.editStoreInfoView.viceTF.text = self.echoStr;
    // 编辑门店信息类型
    switch (self.editStoreInfoType) {
            /** 编辑店面名 */
        case EditStoreName: {
            // 编辑信息输入框限制（判断输入框不能为空）
            [self editStoreInfoTextFieldSignal];
            break;
        }
            /** 编辑店面客服电话 */
        case EditStoreServicePhone: {
            // 编辑信息输入框限制（判断输入框必须为手机号）
            [self editUserPhoneInfoTextFieldSignal];
            break;
        }
            /** 编辑店面短信通知电话 */
        case EditStoreNoticePhone: {
            // 编辑信息输入框限制（判断输入框必须为手机号）
            [self editUserPhoneInfoTextFieldSignal];
            break;
        }
            /** 编辑店面地址 */
        case EditStoreAddress: {
            // 编辑信息输入框限制（判断输入框不能为空）
            [self editStoreInfoTextFieldSignal];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 按钮点击方法
- (void)editStoreInfoRightBtnAction {
    /*/index.php?c=provider&a=edit&v=1
     provider_id 	int 	是 	服务商id
     data 	string 	是 	修改的信息： 数据格式： 数据库字段名=值(店名----name 地址--address 电话--service_tel)  */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
    // 编辑门店信息类型
    switch (self.editStoreInfoType) {
            /** 编辑店面名 */
        case EditStoreName: {
            // 确定修改过店面名
            if ([self.storeModel.name isEqualToString:self.editStoreInfoView.viceTF.text]) {
                [MBProgressHUD showError:@"请确认修改后在提交"];
                return;
            }
            params[@"data"] = [NSString stringWithFormat:@"name=%@", self.editStoreInfoView.viceTF.text]; // 需要修改的商户信息
            break;
        }
            /** 编辑店面客服电话 */
        case EditStoreServicePhone: {
            // 确定修改过客服电话
            if ([self.storeModel.service_tel isEqualToString:self.editStoreInfoView.viceTF.text]) {
                [MBProgressHUD showError:@"请确认修改后在提交"];
                return;
            }
            params[@"data"] = [NSString stringWithFormat:@"service_tel=%@", self.editStoreInfoView.viceTF.text]; // 需要修改的商户信息
            break;
        }
            /** 编辑店面短信通知电话 */
        case EditStoreNoticePhone: {
            // 确定修改过短信通知电话
            if ([self.storeModel.service_mobile isEqualToString:self.editStoreInfoView.viceTF.text]) {
                [MBProgressHUD showError:@"请确认修改后在提交"];
                return;
            }
            params[@"data"] = [NSString stringWithFormat:@"service_mobile=%@", self.editStoreInfoView.viceTF.text]; // 需要修改的商户信息
            break;
        }
            /** 编辑店面地址 */
        case EditStoreAddress: {
            // 确定修改过店面地址
            if ([self.storeModel.address isEqualToString:self.editStoreInfoView.viceTF.text]) {
                [MBProgressHUD showError:@"请确认修改后在提交"];
                return;
            }
            params[@"data"] = [NSString stringWithFormat:@"address=%@", self.editStoreInfoView.viceTF.text]; // 需要修改的商户信息
            break;
        }
        default:
            break;
    }
    [EditStoreInfoNetwork editMerchantInfoParams:params success:^{
        MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
        // 编辑门店信息类型
        switch (self.editStoreInfoType) {
                /** 编辑店面名 */
            case EditStoreName: {
                merchantInfo.name = self.editStoreInfoView.viceTF.text;
                self.storeModel.name = self.editStoreInfoView.viceTF.text;
                break;
            }
                /** 编辑店面客服电话 */
            case EditStoreServicePhone: {
                merchantInfo.service_tel = self.editStoreInfoView.viceTF.text;
                self.storeModel.service_tel = self.editStoreInfoView.viceTF.text;
                break;
            }
                /** 编辑店面短信通知电话 */
            case EditStoreNoticePhone: {
                self.storeModel.service_mobile = self.editStoreInfoView.viceTF.text;
                break;
            }
                /** 编辑店面地址 */
            case EditStoreAddress: {
                merchantInfo.address = self.editStoreInfoView.viceTF.text;
                self.storeModel.address = self.editStoreInfoView.viceTF.text;
                break;
            }
            default:
                break;
        }
        // 储存商家信息
        [NSKeyedArchiver archiveRootObject:merchantInfo toFile:AccountPath];
        if (_EditStoreInfoSuccess) {
            _EditStoreInfoSuccess(self.storeModel);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 布局nav
- (void)editStoreInfoLayoutNAV {
    self.navigationItem.title = self.navTitleStr;
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(editStoreInfoRightBtnAction)];
}
#pragma mark - 布局视图
- (void)editStoreInfoLayoutView {
    /** 编辑店面信息view */
    self.editStoreInfoView = [[CustomCell alloc] init];
    self.editStoreInfoView.lineStyle = NotLine;
    self.editStoreInfoView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.editStoreInfoView.mainLabel.text = self.typeTitleStr;
    self.editStoreInfoView.mainLabel.font = FifteenTypeface;
    self.editStoreInfoView.mainLabel.textColor = Black;
    self.editStoreInfoView.viceTF.placeholder = self.placeholderStr;
    self.editStoreInfoView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.editStoreInfoView];
    self.editStoreInfoView.vTFLeftBorder = 95;
    [self.editStoreInfoView.mainBtn setHidden:YES];
    @weakify(self)
    [self.editStoreInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@50);
    }];
}

#pragma mark - 输入框响应
// 编辑信息输入框限制（判断输入框不能为空）
- (void)editStoreInfoTextFieldSignal {
    // 获取编辑信息signal
    RACSignal *editInfoTFSignal = self.editStoreInfoView.viceTF.rac_textSignal;
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
    RACSignal *phoneTFSignal = self.editStoreInfoView.viceTF.rac_textSignal;
    // 判断手机号输入框最大输入位数
    RACSignal *phoneMaxNumber =
    [phoneTFSignal map:^id(NSString *text) {
        return @(text.length > 10);
    }];
    // 限制手机号输入框可输入位数
    RAC(self.editStoreInfoView.viceTF, text) =
    [phoneMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.editStoreInfoView.viceTF.text substringToIndex:11] : self.editStoreInfoView.viceTF.text;
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
