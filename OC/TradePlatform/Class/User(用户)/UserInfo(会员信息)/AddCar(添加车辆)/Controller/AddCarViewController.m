//
//  AddCarViewController.m
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCarViewController.h"
// view
#import "EditCarInfoView.h"
// 下级控制器
#import "CarBrandListViewController.h"
#import "UserInfoViewController.h"
// 网络请求
#import "AddCarNetwork.h"

@interface AddCarViewController ()

/** 添加view */
@property (strong, nonatomic) EditCarInfoView *addCarView;
/** 车辆模型 */
@property (strong, nonatomic) CWFUserCarModel *carModel;

@end

@implementation AddCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self addCarLayoutNAV];
    // 布局视图
    [self addCarLayoutView];
}
#pragma mark - 网络请求
- (void)addCarRequestData {
    
}
#pragma mark - 按钮点击方法
/** 选择车辆 */
- (void)addCarBtnAction:(UIButton *)button {
    CarBrandListViewController *carBrandListVC = [[CarBrandListViewController alloc] init];
    carBrandListVC.carSystemBlack = ^(CWFUserCarModel *selectCarSystem) {
        // 保存用户选中的车辆
        self.carModel = selectCarSystem;
        self.addCarView.editCar.rightViceLabel.text = selectCarSystem.car_series_name;
        [self.addCarView.editCarImage setImageWithImageUrl:selectCarSystem.image perchImage:@"placeholder_car"];
    };
    [self.navigationController pushViewController:carBrandListVC animated:YES];
}
// nav右边按钮
- (void)addCarRightBarButtonItmeAction {
    [self.view endEditing:YES];
    // 判断车牌号格式
    if (![CustomObject isPlnNumber:self.addCarView.editPln.viceTF.text]) {
        [MBProgressHUD showError:@"车牌号格式不正确"];
        return;
    }
    /*/index.php?c=provider_user_car&a=add&v=1
     provider_user_id 	int 	是 	用户id
     car_brand_id 	int 	是 	车品牌id
     car_brand_series_id 	int 	是 	车系id
     car_plate_no 	string 	是 	车辆车牌号      */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfo.provider_user_id]; // 服用户id
    params[@"car_brand_id"] = self.carModel.car_brand_id; // 车品牌id
    params[@"car_brand_series_id"] = self.carModel.car_series_id; // 车系id
    params[@"car_plate_no"] = self.addCarView.editPln.viceTF.text; // 车辆车牌号
    [AddCarNetwork addUserCarParams:params success:^(AddCarNetwork *addCarNetwork) {
        // 判断车牌号是否存在
        if (addCarNetwork.exist_user == 2) { // 车牌号存在
            [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"车牌号已经存在，是否编辑已存在的用户?" admitBlock:nil noadmitBlock:^{
                UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                userInfoVC.providerUserId = addCarNetwork.provider_user_id;
                [self.navigationController pushViewController:userInfoVC animated:YES];
                // 删除当前页面
                NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                [navViews removeObject:self];
                [navViews removeObjectAtIndex:navViews.count - 2];
                [self.navigationController setViewControllers:navViews animated:YES];
            }];
        }else {
            [MBProgressHUD showSuccess:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


#pragma mark - 界面赋值
- (void)addCarAssignment {
    
}

#pragma mark - 布局nav
- (void)addCarLayoutNAV {
    self.navigationItem.title = @"添加车辆";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(addCarRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)addCarLayoutView {
    /** 用户信息view */
    self.addCarView = [[EditCarInfoView alloc] init];
    [self.addCarView.editCar.mainBtn addTarget:self action:@selector(addCarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addCarView];
    @weakify(self)
    [self.addCarView mas_makeConstraints:^(MASConstraintMaker *make) {
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
