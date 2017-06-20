//
//  EditCarInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCarInfoViewController.h"
// view
#import "EditCarInfoView.h"
// 下级控制器
#import "CarBrandListViewController.h"
#import "UserInfoViewController.h"
// 网络请求
#import "EditCarInfoNetwork.h"

@interface EditCarInfoViewController ()
/** 编辑用户车辆view */
@property (strong, nonatomic) EditCarInfoView *editCarInfoView;
/** 会员修改车辆 */
@property (strong, nonatomic) CWFUserCarModel *selectCar;

@end

@implementation EditCarInfoViewController

// 懒加载selectCar
- (CWFUserCarModel *)selectCar {
    if (!_selectCar) {
        _selectCar = [[CWFUserCarModel alloc] init];
    }
    return _selectCar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self editCarInfoLayoutView];
    // 布局nav
    [self editCarInfoLayoutNAV];
    // 界面赋值
    [self ecditCarInfoAssignment];
}


#pragma mark - 按钮点击方法
// nav按钮点击
- (void)editCarInfoRightBtnAction {
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
    params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfo.provider_user_id]; // 编辑和删除车辆时必传，设置默认非必传
    params[@"provider_user_car_id"] = self.userCar.provider_user_car_id; // 用户车辆id
    params[@"car_plate_no"] = self.editCarInfoView.editPln.viceTF.text; // 车牌号
    params[@"car_brand_id"] = self.selectCar.car_brand_id; // 品牌id
    params[@"car_brand_series_id"] = self.selectCar.car_series_id; // 车系id
    params[@"type"] = @"edit"; // 操作类型
    [EditCarInfoNetwork editUserCarInfoParams:params success:^(EditCarInfoNetwork *editCarInfo) {
        // 判断车牌号是否存在
        if (editCarInfo.exist_user == 2) { // 车牌号存在
            [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"车牌号已经存在，是否编辑已存在的用户?" admitBlock:nil noadmitBlock:^{
                UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                userInfoVC.providerUserId = editCarInfo.provider_user_id;
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
}
/** 修改车辆 */
- (void)editCarBtnAction:(UIButton *)button {
    CarBrandListViewController *carBrandListVC = [[CarBrandListViewController alloc] init];
    carBrandListVC.carSystemBlack = ^(CWFUserCarModel *selectCarSystem) {
        // 保存用户选中的车辆
        self.selectCar = selectCarSystem;
        self.editCarInfoView.editCar.rightViceLabel.text = selectCarSystem.car_series_name;
        [self.editCarInfoView.editCarImage setImageWithImageUrl:selectCarSystem.image perchImage:@"placeholder_car"];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    };
    [self.navigationController pushViewController:carBrandListVC animated:YES];
}

#pragma mark - 界面赋值
- (void)ecditCarInfoAssignment {
    /** 车牌号 */
    self.editCarInfoView.editPln.viceTF.text = self.userCar.car_plate_no;
    /** 品牌车系 */
    self.editCarInfoView.editCar.rightViceLabel.text = self.userCar.car_brand_series;
    /** 品牌图片 */
    [self.editCarInfoView.editCarImage setImageWithImageUrl:self.userCar.image perchImage:@"placeholder_car"];
    // 品牌id
    self.selectCar.car_brand_id = self.userCar.car_brand_id;
    // 车系id
    self.selectCar.car_series_id = self.userCar.car_brand_series_id;
}

#pragma mark - 布局nav
- (void)editCarInfoLayoutNAV {
    self.navigationItem.title = @"编辑车辆信息";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(editCarInfoRightBtnAction)];
    // 根据账户输入框，修改保存按钮是否可点击属性
    RAC(self.navigationItem.rightBarButtonItem, enabled) =
    [self.editCarInfoView.aggregationInfo map:^id(NSNumber *nameTF){
        return@([nameTF boolValue]);
    }];
}
#pragma mark - 布局视图
- (void)editCarInfoLayoutView {
    /** 编辑用户车辆view */
    self.editCarInfoView = [[EditCarInfoView alloc] init];
    /** 品牌车系 */
    [self.editCarInfoView.editCar.mainBtn addTarget:self action:@selector(editCarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editCarInfoView];
    @weakify(self)
    [self.editCarInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
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
