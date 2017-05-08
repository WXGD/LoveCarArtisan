//
//  AddUserViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddUserViewController.h"
// view
#import "AddUserView.h"
#import "CashierServiceChoiceView.h"
// 网络请求
#import "AddUserNetWork.h"
// 下级控制器
#import "CarBrandListViewController.h"
//#import "CardTypeListViewController.h"
#import "UserInfoViewController.h"
// 数据模型
#import "CWFUserCarModel.h"
//#import "CardTypeListDetaSource.h"

@interface AddUserViewController ()<CashierServiceChoiceDelegate>

/** 添加会员View */
@property (strong, nonatomic) AddUserView *addUserView;
/** 会员添加车辆 */
@property (strong, nonatomic) CWFUserCarModel *carModel;
/** 会员卡类型列表 */
@property (strong, nonatomic) NSMutableArray *cardTypeListArray;
/** 当前选中会员卡 */
@property (strong, nonatomic) CardTypeModel *cardTypeModel;

@end

@implementation AddUserViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self addUserLayoutNAV];
    // 布局视图
    [self addUserLayoutView];
    // 请求会员卡类型
    [self requestCardTypeData];
    // 界面赋值
    [self addUserAssignment];
}
#pragma mark - 网络请求
// 请求会员卡类型
- (void)requestCardTypeData {
//    /* /index.php?c=provider_card&a=list&v=1
//     provider_id 	int 	是 	服务商id     */
//    // 网络请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
//    // 请求会员卡类型数据
//    [CardTypeListDetaSource requestCardTypeListDataParams:params success:^(NSMutableArray *cardTypeListArray) {
//        /** 会员卡类型列表 */
//        self.cardTypeListArray = cardTypeListArray;
//    }];
}

#pragma mark - 按钮点击方法
- (void)addUserBtnAction:(UIButton *)button {
    CarBrandListViewController *carBrandListVC = [[CarBrandListViewController alloc] init];
    carBrandListVC.carSystemBlack = ^(CWFUserCarModel *selectCarSystem) {
        // 保存用户选中的车辆
        self.carModel = selectCarSystem;
        self.addUserView.addCar.describeLabel.text = selectCarSystem.car_series_name;
        [self.addUserView.addCar.describeImage setImageWithImageUrl:selectCarSystem.image perchImage:@"placeholder_car"];
        self.addUserView.addCar.viceLabel.text = @"";
    };
    [self.navigationController pushViewController:carBrandListVC animated:YES];
}
// nav右边按钮
- (void)addUserRightBarButtonItmeAction {
    [self.view endEditing:YES];
    // 判断是否输入车牌
    if (self.addUserView.addPln.viceTextFiled.text.length > 5) { // 有车牌输入
        if (![CustomObject isPlnNumber:self.addUserView.addPln.viceTextFiled.text]) {
            [MBProgressHUD showError:@"车牌号输入有误"];
            return;
        }
    }
    // 判断是否输入手机号
    if (![CustomObject checkTel:self.addUserView.addPhone.viceTextFiled.text]) {
        [MBProgressHUD showError:@"手机号输入有误"];
        return;
    }
    /*/index.php?c=provider_user&a=add&v=1
     provider_id 	string 	是 	服务商id
     mobile 	string 	是 	用户手机号
     car_plate_no 	string 	否 	车牌号
     car_brand_id 	int 	否 	车品牌id
     car_brand_series_id 	int 	否 	车系id
     name 	string 	否 	用户姓名
     gender 	string 	否 	用户性别 0-男 1-女
     provider_card_id 	int 	否 	服务商卡id
     card_category_id 	int 	否 	卡类型id
     card_value 	string 	否 	卡值(如果是年卡,值为日期类型)      */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
    params[@"mobile"] = self.addUserView.addPhone.viceTextFiled.text; // 用户手机号
    params[@"car_plate_no"] = self.addUserView.addPln.viceTextFiled.text; // 车牌号
    params[@"car_brand_id"] = self.carModel.car_brand_id; // 车品牌id
    params[@"car_brand_series_id"] = self.carModel.car_series_id; // 车系id
    params[@"name"] = self.addUserView.addName.viceTextFiled.text; // 用户姓名
//    params[@"birthday"] = [self.addUserView.addBirthday.viceLabel.text isEqualToString:@"请选择生日日期"] ? nil : self.addUserView.addBirthday.viceLabel.text; // 用户生日
    params[@"gender"] = self.addUserView.addSexChoice.selectedSex; // 用户性别
    params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardTypeModel.provider_card_id]; // 服务商卡id
    params[@"card_category_id"] = [NSString stringWithFormat:@"%ld", (long)self.cardTypeModel.card_category_id]; // 卡类型id
    // 判断是否是年卡
    if (self.cardTypeModel.card_category_id == 3) {
        params[@"card_value"] = self.addUserView.kakaValueView.viceLabel.text; // 卡值(如果是年卡,值为日期类型)
    }else {
        params[@"card_value"] = self.addUserView.balanceMoreThanView.viceTextFiled.text; // 卡值(如果是年卡,值为日期类型)
    }
    [AddUserNetWork addUserInfoParams:params success:^(AddUserNetWork *addUser) {
        // 判断用户是否存在(1-手机号已存在 2-车牌号已存在)
        if (addUser.exist_user == 0) {
            [MBProgressHUD showSuccess:@"新增成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (addUser.exist_user == 1) {
            [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"手机号已经存在，是否编辑已存在的用户?" admitBlock:nil noadmitBlock:^{
                UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                userInfoVC.providerUserId = addUser.provider_user_id;
                [self.navigationController pushViewController:userInfoVC animated:YES];
            }];
        }else if (addUser.exist_user == 2) {
            [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"车牌号已经存在，是否编辑已存在的用户?" admitBlock:nil noadmitBlock:^{
                UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                userInfoVC.providerUserId = addUser.provider_user_id;
                [self.navigationController pushViewController:userInfoVC animated:YES];
            }];
        }
    }];

}
// 选中切换会员卡
- (void)cardTypeBtnAction:(UIButton *)button {
    // 遍历所有服务，找到当前选中的服务
    for (CardTypeModel *cardTypeModel in self.cardTypeListArray) {
        cardTypeModel.checkMark = NO;
        if (cardTypeModel.provider_card_id == self.cardTypeModel.provider_card_id) {
            cardTypeModel.checkMark = YES;
        }
    }
    // 弹出支付方式选择
    CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
    payChoiceBoxView.choiceArray = self.cardTypeListArray;
    payChoiceBoxView.serviceChoice = UserCardTyoeChoiceBtnAction;
    payChoiceBoxView.delegate = self;
    [payChoiceBoxView show];
}
// 选中会员卡类型
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    /** 当前选中会员卡 */
    self.cardTypeModel = [choiceArray objectAtIndex:indexPath.row];
    // 会员卡类型赋值
    [self userCardClassAssignment];
}

#pragma mark - 界面赋值
- (void)addUserAssignment {
    // 判断是否有手机号
    if (self.userPhone) {
        /** 手机 */
        self.addUserView.addPhone.viceTextFiled.text = self.userPhone;
    }
    // 判断是否有车牌号
    if (self.userPln) {
        /** 车牌号 */
        self.addUserView.addPln.viceTextFiled.text = self.userPln;
    }
}
// 会员卡类型赋值
- (void)userCardClassAssignment {
    /** 会员卡类型 */
    self.addUserView.cardTypeView.describeLabel.text = self.cardTypeModel.name;
    // 判断卡类型 次卡，2储值卡,3年卡
    if (self.cardTypeModel.card_category_id == 1) { // 次卡
        // 隐藏
        [self.addUserView.kakaValueView setHidden:YES];
        /** 余额，余次 */
        self.addUserView.balanceMoreThanView.cellLabel.text = @"余次";
        self.addUserView.balanceMoreThanView.viceTextFiled.placeholder = @"请输入余次";
    }else if (self.cardTypeModel.card_category_id == 2) { // 储值卡
        // 隐藏
        [self.addUserView.kakaValueView setHidden:YES];
        /** 余额，余次 */
        self.addUserView.balanceMoreThanView.cellLabel.text = @"余额";
        self.addUserView.balanceMoreThanView.viceTextFiled.placeholder = @"请输入余额";
    }else if (self.cardTypeModel.card_category_id == 3) { // 年卡
        [self.addUserView.kakaValueView setHidden:NO];
    }
}
#pragma mark - 布局nav
- (void)addUserLayoutNAV {
    self.navigationItem.title = @"新增用户";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(addUserRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)addUserLayoutView {
    @weakify(self)
    /** 会员卡选择View */
    self.addUserView = [[AddUserView alloc] init];
    /** 品牌车系 */
    [self.addUserView.addCar.usedCellBtn addTarget:self action:@selector(addUserBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 会员卡类型 */
    [self.addUserView.cardTypeView.usedCellBtn addTarget:self action:@selector(cardTypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addUserView];
    [self.addUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
//    // 根据账户输入框，修改保存按钮是否可点击属性
//    RAC(self.navigationItem.rightBarButtonItem, enabled) =
//    [self.addUserView.addPhoneSig map:^id(NSNumber *aggregationInfoTF){
//        return@([aggregationInfoTF boolValue]);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
