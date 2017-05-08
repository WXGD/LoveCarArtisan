//
//  UserInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoView.h"
// 下级控制器
#import "ChangeInfoViewController.h"
#import "OrderViewController.h"
#import "UserCardListViewController.h"
#import "CustomOpenCardViewController.h"
#import "AddCarViewController.h"
#import "BenefitQuiryViewController.h"
#import "UsedCarViewController.h"
// 用户模型
#import "UserModel.h"

@interface UserInfoViewController ()<UserCarBtnDelegate>

/** 用户信息view */
@property (strong, nonatomic) UserInfoView *userInfoView;
/** 用户信息模型 */
@property (strong, nonatomic) UserModel *userInfoModel;

@end

@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 网络请求
    [self userInfoRequestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self userInfoLayoutNAV];
}
#pragma mark - 网络请求
- (void)userInfoRequestData {
    /*/index.php?c=provider_user&a=detail&v=1
     provider_user_id 	int 	否 	用户id(通过用户列表获取用户信息时必传,开卡时不必传)
     provider_id 	int 	否 	服务商获取用户时必传，用户获取自身信息时不传
     mobile 	string 	否 	分配卡的时候必传     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商获取用户时必传，用户获取自身信息时不传
    params[@"provider_user_id"] = self.providerUserId; // 用户id
    [UserModel requestUserDetailsInfo:params success:^(UserModel *userInfo) {
        // 保存用户信息模型
        self.userInfoModel = userInfo;
        // 移除用户信息view
        [self.userInfoView removeFromSuperview];
        // 布局视图
        [self userInfoLayoutView];
        // 界面赋值
        [self userInfoAssignment:userInfo];
    }];
}
#pragma mark - 按钮点击方法
- (void)userInfoBtnAction:(UIButton *)button {
    PDLog(@"%ld", (long)button.tag);
    switch (button.tag) {
        /** 会员头像，名称，微信号 */
        case UserHeaderBtnAction:{
            ChangeInfoViewController *changeInfoVC = [[ChangeInfoViewController alloc] init];
            changeInfoVC.changeInfoExhibitionType = ChangeNameAssignment;
            changeInfoVC.userInfo = self.userInfoModel;
            changeInfoVC.editSuccessBlock = ^(UserModel *userInfo) {
                // 界面赋值
                [self userInfoAssignment:userInfo];
            };
            [self.navigationController pushViewController:changeInfoVC animated:YES];
            break;
        }
            /** 电话 */
        case UserPhoneBtnAction:{
            ChangeInfoViewController *changeInfoVC = [[ChangeInfoViewController alloc] init];
            changeInfoVC.changeInfoExhibitionType = ChangeUserPhoneAssignment;
            changeInfoVC.userInfo = self.userInfoModel;
            changeInfoVC.editSuccessBlock = ^(UserModel *userInfo) {
                // 界面赋值
                [self userInfoAssignment:userInfo];
            };
            [self.navigationController pushViewController:changeInfoVC animated:YES];
            break;
        }
        /** 会员卡 */
        case UserCodeBtnAction:{
            UserCardListViewController *userCardListVC = [[UserCardListViewController alloc] init];
            userCardListVC.userModel = self.userInfoModel;
            [self.navigationController pushViewController:userCardListVC animated:YES];
            break;
        }
        /** 消费记录 */
        case PurchaseHistoryBtnAction:{
            OrderViewController *orderVC = [[OrderViewController alloc] init];
            orderVC.userInfoMode = self.userInfoModel;
            orderVC.orderNavTitle = @"消费记录";
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        }
            /** 添加会员车辆 */
        case UserCarBtnAction:{
            /** 添加车辆信息 */
            AddCarViewController *addCarVC = [[AddCarViewController alloc] init];
            addCarVC.userInfo = self.userInfoModel;
            [self.navigationController pushViewController:addCarVC animated:YES];
            break;
        }
            /** 开卡 */
        case OpenCardBtnAction:{
            CustomOpenCardViewController *customOpenCardVC = [[CustomOpenCardViewController alloc] init];
            customOpenCardVC.userModel = self.userInfoModel;
            [self.navigationController pushViewController:customOpenCardVC animated:YES];
            break;
        }
        default:
            break;
    }
}
// 删除用户
- (void)userInfoRightBarButtonItmeAction {
    [AlertAction determineStayLeft:self title:@"提示" message:@"您确定删除该用户吗?" determineBlock:^{
        /*/index.php?c=provider_user&a=del&v=1
         provider_user_id 	int 	是 	删除用户的id      */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfoModel.provider_user_id]; // 服用户id
        [UserModel deleteUserParams:params success:^{
            [MBProgressHUD showSuccess:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

#pragma mark - 会员车辆代理方法
/** 编辑按钮 */
- (void)editCarInfoBtnDelegate:(UIButton *)button {
    /** 修改车辆信息 */
    ChangeInfoViewController *changeInfoVC = [[ChangeInfoViewController alloc] init];
    changeInfoVC.changeInfoExhibitionType = ChangeCarInfoAssignment;
    changeInfoVC.userCar = self.userInfoView.userCarArray[button.tag];
    changeInfoVC.userInfo = self.userInfoModel;
    changeInfoVC.provider_user_id = [NSString stringWithFormat:@"%ld", self.userInfoModel.provider_user_id];
    [self.navigationController pushViewController:changeInfoVC animated:YES];
}
/** 二手车估值 */
- (void)useCarValuationBtnDelegate:(UIButton *)button {
    /** 二手车估值 */
    UsedCarViewController *usedCarVC = [[UsedCarViewController alloc] init];
    usedCarVC.userCar = self.userInfoView.userCarArray[button.tag];
    [self.navigationController pushViewController:usedCarVC animated:YES];
}
/** 查保险 */
- (void)quiryBenefitBtnDelegate:(UIButton *)button {
    /** 查保险 */
    BenefitQuiryViewController *benefitQuiryVC = [[BenefitQuiryViewController alloc] init];
    benefitQuiryVC.userCar = self.userInfoView.userCarArray[button.tag];
    [self.navigationController pushViewController:benefitQuiryVC animated:YES];
}

#pragma mark - 界面赋值
- (void)userInfoAssignment:(UserModel *)userInfo {
    /** 会员头像，名称，微信号 */
    self.userInfoView.userHeaderView.describeLabel.text = userInfo.name;
    /** 电话 */
    self.userInfoView.userPhoneView.describeLabel.text = userInfo.mobile;
    /** 会员卡 */
    self.userInfoView.userCodeView.describeLabel.text = [NSString stringWithFormat:@"%ld", (long)userInfo.card_num];
    /** 消费记录 */
    self.userInfoView.purchaseHistoryView.describeLabel.text = userInfo.consume_time;
}
#pragma mark - 布局nav
- (void)userInfoLayoutNAV {
    self.navigationItem.title = @"用户详情";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_del_user"] style:UIBarButtonItemStyleDone target:self action:@selector(userInfoRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)userInfoLayoutView {
    /** 用户信息view */
    self.userInfoView = [[UserInfoView alloc] init];
    /** 会员头像，名称，微信号 */
    [self.userInfoView.userHeaderView.usedCellBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 电话 */
    [self.userInfoView.userPhoneView.usedCellBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 会员卡 */
    [self.userInfoView.userCodeView.usedCellBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 消费记录 */
    [self.userInfoView.purchaseHistoryView.usedCellBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 添加会员车辆 */
    [self.userInfoView.userCarView.usedCellBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 会员车辆代理 */
    self.userInfoView.delegate = self;
    /** 会员车辆数据 */
    self.userInfoView.userCarArray = self.userInfoModel.car;
    /** 开卡 */
    [self.userInfoView.openCardBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.userInfoView];
    @weakify(self)
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
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
