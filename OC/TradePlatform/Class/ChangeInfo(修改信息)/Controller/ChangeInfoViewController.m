//
//  ChangeInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChangeInfoViewController.h"
#import "ChangeInfoView.h"
#import "ChangeSexView.h"
#import "ChangePassworkView.h"
#import "ChangeCarInfoView.h"

// 网络请求
#import "ChangeInfoNetWork.h"
// 下级控制器
#import "CarBrandListViewController.h"
#import "UserInfoViewController.h"

@interface ChangeInfoViewController ()

/** 修改信息view */
@property (strong, nonatomic) ChangeInfoView *changeInfoView;
/** 修改性别view */
@property (strong, nonatomic) ChangeSexView *changeSexView;
/** 修改生日view */
@property (strong, nonatomic) UsedCellView *changebirthdayView;
/** 修改密码view */
@property (strong, nonatomic) ChangePassworkView *changePassworkView;
/** 修改车辆信息View */
@property (strong, nonatomic) ChangeCarInfoView *changeCarInfoView;
/** 会员修改车辆 */
@property (strong, nonatomic) CWFUserCarModel *carModel;

@end

@implementation ChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self changeInfoLayoutNAV];
    // 布局视图
    [self changeInfoLayoutView];
    // 界面赋值
    [self changeInfoAssignment];
}
#pragma mark - 网络请求
// 修改用户信息请求
- (void)editUserInfoParams:(NSMutableDictionary *)params {
    [ChangeInfoNetWork editUserInfoParams:params success:^(ChangeInfoNetWork *changeUserInfo) {
        switch (_changeInfoExhibitionType) {
                /** 名称 */
            case ChangeNameAssignment:{
                self.userInfo.name = self.changeInfoView.changeTextField.text;
                break;
            }
                /** 性别 */
            case ChangeSexAssignment:{
                self.userInfo.gender = [self.changeSexView.selectedSex isEqualToString:@"0"] ? @"男" : @"女";
                break;
            }
                /** 电话 */
            case ChangePhoneAssignment:{
                
                break;
            }
                /** 地址 */
            case ChangeAddressAssignment:{
                
                
                break;
            }
                /** 生日 */
            case ChangeUserBirthdayAssignment:{
//                self.userInfo.birthday = self.changebirthdayView.viceLabel.text;
                break;
            }
                /** 会员车辆 */
            case ChangeUserCarAssignment:{
                
                break;
            }
                /** 会员卡 */
            case ChangeUserCodeAssignment:{
                
                
                break;
            }
                /** 会员电话 */
            case ChangeUserPhoneAssignment:{
                // 判断手机号是否存在
                if (changeUserInfo.exist_user == 1) { // 手机号存在
                    [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"手机号已经存在，是否编辑已存在的用户?" admitBlock:nil noadmitBlock:^{
                        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                        userInfoVC.providerUserId = changeUserInfo.provider_user_id;
                        [self.navigationController pushViewController:userInfoVC animated:YES];
                        // 删除当前页面
                        NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                        [navViews removeObject:self];
                        [self.navigationController setViewControllers:navViews animated:YES];
                    }];
                }else {
                    [MBProgressHUD showSuccess:@"修改成功"];
                    self.userInfo.mobile = self.changeInfoView.changeTextField.text;
                }
                break;
            }
                /** 修改密码 */
            case ChangeUserDelPasswordAssignment:{
                
                
                break;
            }
            default:
                break;
        }
        if (_editSuccessBlock) {
            _editSuccessBlock(self.userInfo);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
// 修改商户信息请求
- (void)editMerchantInfoParams:(NSMutableDictionary *)params {
    [ChangeInfoNetWork editMerchantInfoParams:params success:^{
        MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
        switch (_changeInfoExhibitionType) {
                /** 商户名称 */
            case ChangeMerchantNameAssignment:{
                merchantInfo.name = self.changeInfoView.changeTextField.text;
                break;
            }
                /** 电话 */
            case ChangePhoneAssignment:{
                merchantInfo.service_tel = self.changeInfoView.changeTextField.text;
                break;
            }
                /** 地址 */
            case ChangeAddressAssignment:{
                merchantInfo.address = self.changeInfoView.changeTextField.text;
                break;
            }
            default:
                break;
        }
        // 储存商家信息
        [NSKeyedArchiver archiveRootObject:merchantInfo toFile:AccountPath];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
#pragma mark - 按钮点击方法
// nav右边
- (void)changeInfoRightBarButtonItmeAction {
    [self.view endEditing:YES];
    switch (_changeInfoExhibitionType) {
            /** 名称 */
        case ChangeNameAssignment:{
            // 判断输入框内容和保存内容一致
            if ([self.changeInfoView.changeTextField.text isEqualToString:self.userInfo.name]) {
                [MBProgressHUD showError:@"请确认修改后在提交"];
                return;
            }
            /*/index.php?c=provider_user&a=edit&v=1
             provider_user_id 	int 	是 	用户id
             data 	string 	是 	需要修改的用户信息; 数据格式：字段=值,字段1=值1 (修改信息对应字段参考下面的备注)     */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfo.provider_user_id]; // 用户编号
            params[@"data"] = [NSString stringWithFormat:@"name=%@", self.changeInfoView.changeTextField.text]; // 需要修改的用户信息
            [self editUserInfoParams:params];
            break;
        }
            /** 商户名称 */
        case ChangeMerchantNameAssignment: {
            /*/index.php?c=provider&a=edit&v=1
             provider_id 	int 	是 	服务商id
             data 	string 	是 	修改的信息： 数据格式： 数据库字段名=值(店名----name 地址--address 电话--service_tel)  */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
            params[@"data"] = [NSString stringWithFormat:@"name=%@", self.changeInfoView.changeTextField.text]; // 需要修改的商户信息
            [self editMerchantInfoParams:params];
            break;
        }
            /** 性别 */
        case ChangeSexAssignment:{
            // 获取当前选中的性别
            NSString *sex = [self.changeSexView.selectedSex isEqualToString:@"0"] ? @"男" : @"女";
            // 判断是否修改了性别
            if ([self.userInfo.gender isEqualToString:sex]) {
                [MBProgressHUD showError:@"没有修改信息"];
                return;
            }
            /*/index.php?c=provider_user&a=edit&v=1
             provider_user_id 	int 	是 	用户id
             data 	string 	是 	需要修改的用户信息; 数据格式：字段=值,字段1=值1 (修改信息对应字段参考下面的备注)     */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfo.provider_user_id]; // 用户编号
            params[@"data"] = [NSString stringWithFormat:@"gender=%@", self.changeSexView.selectedSex]; // 需要修改的用户信息
            [self editUserInfoParams:params];
            break;
        }
            /** 电话 */
        case ChangePhoneAssignment:{
            /*/index.php?c=provider&a=edit&v=1
             provider_id 	int 	是 	服务商id
             data 	string 	是 	修改的信息： 数据格式： 数据库字段名=值(店名----name 地址--address 电话--service_tel)  */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
            params[@"data"] = [NSString stringWithFormat:@"service_tel=%@", self.changeInfoView.changeTextField.text]; // 需要修改的商户信息
            [self editMerchantInfoParams:params];
            break;
        }
            /** 地址 */
        case ChangeAddressAssignment:{
            /*/index.php?c=provider&a=edit&v=1
             provider_id 	int 	是 	服务商id
             data 	string 	是 	修改的信息： 数据格式： 数据库字段名=值(多个用逗号分开,数据库字段见备注)   */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
            params[@"data"] = [NSString stringWithFormat:@"address=%@", self.changeInfoView.changeTextField.text]; // 需要修改的商户信息
            [self editMerchantInfoParams:params];
            break;
        }
            /** 生日 */
        case ChangeUserBirthdayAssignment:{
            // 判断是否修改了生日
//            if ([self.userInfo.b isEqualToString:self.changebirthdayView.viceLabel.text]) {
//                [MBProgressHUD showError:@"没有修改信息"];
//                return;
//            }
//            /*/index.php?c=user&a=edit&v=1
//             cwf_no 	string 	是 	用户编号
//             data 	string 	是 	需要修改的用户信息; 数据格式：字段=值,字段1=值1 (修改信息对应字段参考下面的备注)    */
//            // 网络请求参数
//            NSMutableDictionary *params = [NSMutableDictionary dictionary];
//            params[@"cwf_no"] = self.userInfo.provider_user_id; // 用户编号
//            params[@"data"] = [NSString stringWithFormat:@"birthday=%@", self.changebirthdayView.viceLabel.text]; // 需要修改的用户信息
//            [self editUserInfoParams:params];
            break;
        }
            /** 会员车辆 */
        case ChangeUserCarAssignment:{
            
            
            break;
        }
            /** 会员卡 */
        case ChangeUserCodeAssignment:{
            
            
            break;
        }
            /** 会员电话 */
        case ChangeUserPhoneAssignment:{
            // 判断输入框内容和保存内容一致
            if ([self.changeInfoView.changeTextField.text isEqualToString:self.userInfo.mobile]) {
                [MBProgressHUD showError:@"请确认修改后在提交"];
                return;
            }
            /*/index.php?c=provider_user&a=edit&v=1
             provider_user_id 	int 	是 	用户id
             data 	string 	是 	需要修改的用户信息; 数据格式：字段=值,字段1=值1 (修改信息对应字段参考下面的备注)     */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfo.provider_user_id]; // 用户编号
            params[@"data"] = [NSString stringWithFormat:@"mobile=%@", self.changeInfoView.changeTextField.text]; // 需要修改的用户信息
            [self editUserInfoParams:params];
            break;
        }
            /** 修改密码 */
        case ChangeUserDelPasswordAssignment:{
            // 判断新密码和确认密码是否相同
            if (![self.changePassworkView.PWNewTF.text isEqualToString:self.changePassworkView.PWConfirmTF.text]) {
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
            params[@"old_password"] = self.changePassworkView.PWOldTF.text; // 旧密码
            params[@"new_password"] = self.changePassworkView.PWNewTF.text; // 旧密码
            [ChangeInfoNetWork editAccountPasswordParams:params success:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 修改车辆信息 */
        case ChangeCarInfoAssignment:{
            /*/index.php?c=provider_user_car&a=edit&v=1
             provider_user_id 	int 	否 	编辑和删除车辆时必传，设置默认非必传
             provider_user_car_id 	int 	是 	用户车辆id
             car_plate_no 	string 	是 	车牌号
             car_brand_id 	int 	否 	品牌id, 编辑车辆必传
             car_brand_series_id 	int 	否 	车系id, 编辑车辆必传
             type 	string 	是 	操作类型： edit-更新 del-删除 set-设为默认
             is_default 	int 	否 	删除车辆时必传   */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_user_id"] = self.provider_user_id; // 编辑和删除车辆时必传，设置默认非必传
            params[@"provider_user_car_id"] = self.userCar.provider_user_car_id; // 用户车辆id
            params[@"car_plate_no"] = self.changeCarInfoView.editPln.viceTextFiled.text; // 车牌号
            params[@"car_brand_id"] = self.carModel.car_brand_id; // 品牌id
            params[@"car_brand_series_id"] = self.carModel.car_series_id; // 车系id
            params[@"type"] = @"edit"; // 操作类型
            [ChangeInfoNetWork editUserCarInfoParams:params success:^(ChangeInfoNetWork *changeUserCar) {
                // 判断车牌号是否存在
                if (changeUserCar.exist_user == 2) { // 车牌号存在
                    [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"车牌号已经存在，是否编辑已存在的用户?" admitBlock:nil noadmitBlock:^{
                        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                        userInfoVC.providerUserId = changeUserCar.provider_user_id;
                        [self.navigationController pushViewController:userInfoVC animated:YES];
                        // 删除当前页面
                        NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                        [navViews removeObject:self];
                        [navViews removeObjectAtIndex:navViews.count - 2];
                        [self.navigationController setViewControllers:navViews animated:YES];
                    }];
                }else {
                    [MBProgressHUD showSuccess:@"修改成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            break;
        }
        default:
            break;
    }
}
/** 修改生日view */
- (void)changebirthdayBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        self.changebirthdayView.viceLabel.text = timestamp;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}
/** 修改车辆 */
- (void)editCarBtnAction:(UIButton *)button {
    CarBrandListViewController *carBrandListVC = [[CarBrandListViewController alloc] init];
    carBrandListVC.carSystemBlack = ^(CWFUserCarModel *selectCarSystem) {
        // 保存用户选中的车辆
        self.carModel = selectCarSystem;
        self.changeCarInfoView.editCar.describeLabel.text = selectCarSystem.car_series_name;
        [self.changeCarInfoView.editCar.describeImage setImageWithImageUrl:selectCarSystem.image perchImage:@"placeholder_car"];
        self.changeCarInfoView.editCar.viceLabel.text = @"";
    };
    [self.navigationController pushViewController:carBrandListVC animated:YES];
}
#pragma mark - 界面赋值
- (void)changeInfoAssignment {
    switch (_changeInfoExhibitionType) {
        /** 名称 */
        case ChangeNameAssignment:{
            self.changeInfoView.changeTextField.placeholder = @"请输入姓名";
            self.changeInfoView.changeTextField.text = self.userInfo.name;
            self.navigationItem.title = @"姓名";
            //  修改姓名的输入框限制
            RACSignal *nameSig = [self.changeInfoView changeNameTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [nameSig map:^id(NSNumber *nameTF){
                return@([nameTF boolValue]);
            }];
            break;
        }
            /** 商户名称 */
        case ChangeMerchantNameAssignment:{
            self.changeInfoView.changeTextField.placeholder = @"请输入商户名";
            self.navigationItem.title = @"商户名";
            //  修改姓名的输入框限制
            RACSignal *nameSig = [self.changeInfoView changeNameTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [nameSig map:^id(NSNumber *nameTF){
                return@([nameTF boolValue]);
            }];
            break;
        }
        /** 性别 */
        case ChangeSexAssignment:{
            self.navigationItem.title = @"修改性别";
            break;
        }
        /** 商户电话 */
        case ChangePhoneAssignment:{
            self.changeInfoView.changeTextField.placeholder = @"请输入手机号";
            self.changeInfoView.changeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.navigationItem.title = @"手机号";
            // 修改手机号的输入框限制
            RACSignal *phoneSig = [self.changeInfoView changePhoneTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
        /** 地址 */
        case ChangeAddressAssignment:{
            self.changeInfoView.changeTextField.placeholder = @"请输入地址";
            self.navigationItem.title = @"修改地址";
            //  修改姓名的输入框限制
            RACSignal *nameSig = [self.changeInfoView changeNameTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [nameSig map:^id(NSNumber *nameTF){
                return@([nameTF boolValue]);
            }];
            break;
        }
        /** 生日 */
        case ChangeUserBirthdayAssignment:{
            self.changeInfoView.changeTextField.placeholder = @"请输入生日";
            self.navigationItem.title = @"修改生日";
            break;
        }
        /** 会员车辆 */
        case ChangeUserCarAssignment:{
            self.changeInfoView.changeTextField.placeholder = @"请输入用户车辆";
            self.navigationItem.title = @"修改用户车辆";
            break;
        }
        /** 会员卡 */
        case ChangeUserCodeAssignment:{
            self.changeInfoView.changeTextField.placeholder = @"请输入会员卡";
            self.navigationItem.title = @"修改会员卡";
            break;
        }
        /** 会员电话 */
        case ChangeUserPhoneAssignment:{
            self.changeInfoView.changeTextField.placeholder = @"请输入手机号";
            self.changeInfoView.changeTextField.text = self.userInfo.mobile;
            self.changeInfoView.changeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.navigationItem.title = @"手机号";
            // 修改手机号的输入框限制
            RACSignal *phoneSig = [self.changeInfoView changePhoneTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
        /** 修改密码 */
        case ChangeUserDelPasswordAssignment:{
            self.navigationItem.title = @"修改密码";
            //  修改密码的输入框限制
            RACSignal *passwordSig = [self.changePassworkView changePassworkTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [passwordSig map:^id(NSNumber *nameTF){
                return@([nameTF boolValue]);
            }];
            break;
        }
        /** 修改车辆信息 */
        case ChangeCarInfoAssignment:{
            self.navigationItem.title = @"车辆详情";
            /** 车辆车牌号 */
            self.changeCarInfoView.editPln.viceTextFiled.text = self.userCar.car_plate_no;
            /** 车车系名称 */
            self.changeCarInfoView.editCar.describeLabel.text = self.userCar.car_brand_series;
            self.changeCarInfoView.editCar.viceLabel.text = @"";
            /** 车辆品牌图片 */
            [self.changeCarInfoView.editCar.describeImage setImageWithImageUrl:self.userCar.image perchImage:@"placeholder_car"];
            // 保存修改的车辆
            self.carModel = [[CWFUserCarModel alloc] init];
            self.carModel.car_brand_id = self.userCar.car_brand_id;
            self.carModel.car_series_id = self.userCar.car_brand_series_id;
//            //  修改车牌号的输入框限制
//            RACSignal *passwordSig = [self.changeCarInfoView changePlnTextFieldSignal];
//            // 根据账户输入框，修改保存按钮是否可点击属性
//            RAC(self.navigationItem.rightBarButtonItem, enabled) =
//            [passwordSig map:^id(NSNumber *nameTF){
//                return@([nameTF boolValue]);
//            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 布局nav
- (void)changeInfoLayoutNAV {
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(changeInfoRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)changeInfoLayoutView {
    // 判断是不是修改性别
    if (self.changeInfoExhibitionType == ChangeSexAssignment) {
        /** 修改性别view */
        self.changeSexView = [[ChangeSexView alloc] init];
        self.changeSexView.defaultSex = self.userInfo.gender;
        [self.view addSubview:self.changeSexView];
        @weakify(self)
        [self.changeSexView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.view.mas_top).offset(10);
            make.left.equalTo(self.view.mas_left).offset(15);
            make.width.mas_equalTo(@150);
        }];
    }else if (self.changeInfoExhibitionType == ChangeUserBirthdayAssignment) {
//        /** 修改生日view */
//        self.changebirthdayView = [[UsedCellView alloc] init];
//        self.changebirthdayView.cellLabel.text = @"用户生日:";
//        [self.changebirthdayView.usedCellBtn addTarget:self action:@selector(changebirthdayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.changebirthdayView.viceLabel.text = self.userInfo.birthday;
//        self.changebirthdayView.isArrow = YES;
//        self.changebirthdayView.isCellImage = YES;
//        self.changebirthdayView.isSplistLine = YES;
//        [self.view addSubview:self.changebirthdayView];
//        @weakify(self)
//        [self.changebirthdayView mas_makeConstraints:^(MASConstraintMaker *make) {
//            @strongify(self)
//            make.top.equalTo(self.view.mas_top).offset(10);
//            make.left.equalTo(self.view.mas_left);
//            make.right.equalTo(self.view.mas_right);
//            make.height.mas_equalTo(@50);
//        }];
    }else if (self.changeInfoExhibitionType == ChangeUserDelPasswordAssignment) {
        /** 修改密码view */
        self.changePassworkView = [[ChangePassworkView alloc] init];
        [self.view addSubview:self.changePassworkView];
        @weakify(self)
        [self.changePassworkView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.view.mas_top).offset(10);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }else if (self.changeInfoExhibitionType == ChangeCarInfoAssignment) {
        /** 修改车辆信息View */
        self.changeCarInfoView = [[ChangeCarInfoView alloc] init];
        [self.changeCarInfoView.editCar.usedCellBtn addTarget:self action:@selector(editCarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.changeCarInfoView];
        @weakify(self)
        [self.changeCarInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.view.mas_top).offset(10);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }else {
        /** 修改信息view */
        self.changeInfoView = [[ChangeInfoView alloc] init];
        [self.view addSubview:self.changeInfoView];
        @weakify(self)
        [self.changeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.view.mas_top).offset(10);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
