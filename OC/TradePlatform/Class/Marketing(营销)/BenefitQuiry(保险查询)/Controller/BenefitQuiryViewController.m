//
//  BenefitQuiryViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitQuiryViewController.h"
// view
#import "BenefitQuiryView.h"
// 出险记录
#import "DangerRecordViewController.h"
//询价记录
#import "InquiryRecordViewController.h"
// 下级控制器
#import "AddSchemeViewController.h"
#import "QuotationViewController.h"
#import "BenefitPaySuccessViewController.h"
#import "PhotographViewController.h"
// model
#import "UserCarModel.h"
#import "BenefitCarInfoModel.h"

@interface BenefitQuiryViewController ()

/** 车险询价view */
@property (strong, nonatomic) BenefitQuiryView *benefitQuiryView;

@end

@implementation BenefitQuiryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /** 车牌号 */
    self.benefitQuiryView.plnTF.text = nil;
    /** 品牌车型 */
    self.benefitQuiryView.carBrandView.viceTextFiled.text = nil;
    /** 车架号 */
    self.benefitQuiryView.vinView.viceTextFiled.text = nil;
    /** 发动机号 */
    self.benefitQuiryView.engineView.viceTextFiled.text = nil;
    /** 初次登记时间 */
    self.benefitQuiryView.registerTimeView.viceTextFiled.text = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self benefitQuiryLayoutNAV];
    // 布局视图
    [self benefitQuiryLayoutView];
}
#pragma mark - 网络请求


#pragma mark - 按钮点击方法
// nav右边按钮
- (void)benefitQuiryRightBarBtnAction {

}

#pragma mark - 车险询价功能选择按钮
- (void)benefitQuiryBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 提交查询 */
        case SubmitQueryBtnAction: {
            // 提交查询按钮点击方法
            [self submitQueryBtnAction];
            break;
        }
            /** 询价记录 */
        case InquiryRecordBtnAction: {
            InquiryRecordViewController *InquiryRecordVC = [[InquiryRecordViewController alloc] init];
            [self.navigationController pushViewController:InquiryRecordVC animated:YES];
            break;
        }
            /** 出险记录 */
        case DangerRecordBtnAction: {
            DangerRecordViewController *dangerRecordVC = [[DangerRecordViewController alloc] init];
            [self.navigationController pushViewController:dangerRecordVC animated:YES];
            break;
        }
            /** 车牌号 */
        case PlnBtnAction: {
            PhotographViewController *photographVC = [[PhotographViewController alloc] init];
            photographVC.photographViewType = BenefitQuiryAssignment;
            photographVC.DistinguishSuccessBlock = ^(NSMutableDictionary *plnPhoto) {
                // 车牌号
                if (plnPhoto) {
                    /** 车牌号 */
                    NSString *pln = plnPhoto[@"车牌号"];
                    self.benefitQuiryView.plnTF.text = [pln substringFromIndex:1];
                    self.benefitQuiryView.caftaBtn.titleLabel.text = [pln substringToIndex:1];
//                    /* /index.php?c=insurance_query&a=car_info&v=1
//                     provider_id 	int 	是 	服务商id
//                     car_plate_no 	int 	是 	车牌号       */
//                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//                    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
//                    params[@"car_plate_no"] = self.benefitQuiryView.plnTF.text; // 车牌号
//                    [BenefitCarInfoModel usePlnQuiryCarInfo:params success:^(BenefitCarInfoModel *carInfo) {
//                        /** 品牌车型 */
//                        self.benefitQuiryView.carBrandView.viceTextFiled.text = carInfo.license_brand_model;
//                        /** 车架号 */
//                        self.benefitQuiryView.vinView.viceTextFiled.text = carInfo.vin;
//                        /** 发动机号 */
//                        self.benefitQuiryView.engineView.viceTextFiled.text = carInfo.engine_num;
//                        /** 初次登记时间 */
//                        self.benefitQuiryView.registerTimeView.viceTextFiled.text = carInfo.register_time;
//                    }];
                }
            };
            [self.navigationController pushViewController:photographVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - textField操作
// 手机号输入
- (void)plnTFAvtion:(UITextField *)textField {
    // 拼接省份简称
    NSString *pln = [NSString stringWithFormat:@"%@%@", self.benefitQuiryView.caftaBtn.titleLabel.text, textField.text];
    // 当车牌号输入框为空时
    if (textField.text.length == 0) {
        
    }else if ([CustomObject isPlnNumber:pln]) {
//        // 车牌号
//        /* /index.php?c=insurance_query&a=car_info&v=1
//         provider_id 	int 	是 	服务商id
//         car_plate_no 	int 	是 	车牌号       */
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
//        params[@"car_plate_no"] = self.benefitQuiryView.plnTF.text; // 车牌号
//        [BenefitCarInfoModel usePlnQuiryCarInfo:params success:^(BenefitCarInfoModel *carInfo) {
//            /** 品牌车型 */
//            self.benefitQuiryView.carBrandView.viceTextFiled.text = carInfo.license_brand_model;
//            /** 车架号 */
//            self.benefitQuiryView.vinView.viceTextFiled.text = carInfo.vin;
//            /** 发动机号 */
//            self.benefitQuiryView.engineView.viceTextFiled.text = carInfo.engine_num;
//            /** 初次登记时间 */
//            self.benefitQuiryView.registerTimeView.viceTextFiled.text = carInfo.register_time;
//        }];
    }
}


#pragma mark - 界面赋值
- (void)benefitQuiryAssignment {
    

}


#pragma mark - 布局nav
- (void)benefitQuiryLayoutNAV {
    self.navigationItem.title = @"车险询价";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(benefitQuiryRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(benefitQuiryRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)benefitQuiryLayoutView {
    /** 车险询价view */
    self.benefitQuiryView = [[BenefitQuiryView alloc] init];
    /** 监控车牌号输入框输入 */
    [self.benefitQuiryView.plnTF addTarget:self action:@selector(plnTFAvtion:) forControlEvents:UIControlEventEditingChanged];
    /** 提交查询btn */
    [self.benefitQuiryView.submitQueryBtn addTarget:self action:@selector(benefitQuiryBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 询价记录 */
    [self.benefitQuiryView.inquiryRecordBtn addTarget:self action:@selector(benefitQuiryBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 出险记录 */
    [self.benefitQuiryView.dangerRecordBtn addTarget:self action:@selector(benefitQuiryBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 车牌号view */
    [self.benefitQuiryView.plnBtn addTarget:self action:@selector(benefitQuiryBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.benefitQuiryView];
    @weakify(self)
    [self.benefitQuiryView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


#pragma mark - 封装方法
// 提交查询按钮点击方法
- (void)submitQueryBtnAction {
    // 判断有没有车牌号
    if ([self.benefitQuiryView.plnTF.text length] == 0) {
        [MBProgressHUD showError:@"请填写车牌号"];
        return;
    }
    NSString *pln = [NSString stringWithFormat:@"%@%@", self.benefitQuiryView.caftaBtn.titleLabel.text, self.benefitQuiryView.plnTF.text];
    // 判断车牌号是否正确
    if (![CustomObject isPlnNumber:pln]) {
        [MBProgressHUD showError:@"请正确填写车牌号"];
        return;
    }
    // 判断有没有品牌车型
    if ([self.benefitQuiryView.carBrandView.viceTextFiled.text length] == 0) {
        [MBProgressHUD showError:@"请填写品牌车型"];
        return;
    }
    // 判断有没有车架号
    if ([self.benefitQuiryView.vinView.viceTextFiled.text length] == 10) {
        [MBProgressHUD showError:@"请填写车架号"];
        return;
    }
    // 判断有没有发动机号
    if ([self.benefitQuiryView.engineView.viceTextFiled.text length] == 0) {
        [MBProgressHUD showError:@"请填写发动机号"];
        return;
    }
    // 判断有没有注册时间
    if ([self.benefitQuiryView.registerTimeView.viceTextFiled.text length] == 0) {
        [MBProgressHUD showError:@"请填写注册时间"];
        return;
    }
    // 判断有没有所有人
    if ([self.benefitQuiryView.holdManView.viceTextFiled.text length] == 0) {
        [MBProgressHUD showError:@"请填写所有人"];
        return;
    }
    // 创建用户车辆模型
    UserCarModel *carModel = [[UserCarModel alloc] init];
    /** 车牌号view */
    carModel.car_plate_no = [NSString stringWithFormat:@"%@%@", self.benefitQuiryView.caftaBtn.titleLabel.text, self.benefitQuiryView.plnTF.text];
    /** 品牌车型 */
    carModel.car_brand_name = self.benefitQuiryView.carBrandView.viceTextFiled.text;
    /** 车架号 */
    carModel.vin = self.benefitQuiryView.vinView.viceTextFiled.text;
    /** 发动机号 */
    carModel.engine = self.benefitQuiryView.engineView.viceTextFiled.text;
    /** 注册时间 */
    carModel.register_time = self.benefitQuiryView.registerTimeView.viceTextFiled.text;
    /** 所有人 */
    carModel.hold_man = self.benefitQuiryView.holdManView.viceTextFiled.text;
    /** 行驶证图片 */
    carModel.license_img = self.benefitQuiryView.cardImg.image;
    AddSchemeViewController *addSchemeVC = [[AddSchemeViewController alloc] init];
    addSchemeVC.carModel = carModel;
    [self.navigationController pushViewController:addSchemeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
