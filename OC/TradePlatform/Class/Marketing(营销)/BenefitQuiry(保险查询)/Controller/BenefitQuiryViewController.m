//
//  BenefitQuiryViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitQuiryViewController.h"
// view
#import "BenefitQuiryView.h"
// 下级控制器
#import "PhotographViewController.h"
#import "ImageCropViewController.h"
#import "BenefitQuiryInfoWebController.h"

// 模型
#import "BenefitCarInfoModel.h"

@interface BenefitQuiryViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, QuiryRecordChoiceDelegate, UITextFieldDelegate, PECropViewControllerDelegate>

/** 保险查询 */
@property (strong, nonatomic) BenefitQuiryView *benefitQuiryView;

@end

@implementation BenefitQuiryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self benefitQuiryLayoutNAV];
    // 布局视图
    [self benefitQuiryLayoutView];
    // 网络请求
    [self benefitQuiryRepuestData];
    // 界面赋值
    [self benefitQuiryAssignment];
}
#pragma mark - 网络请求
- (void)benefitQuiryRepuestData {
    BennfitQuiryRecordModel *quiryRecordModel = [[BennfitQuiryRecordModel alloc] init];
    /* /index.php?c=insurance_query&a=list&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     start 	int 	否 	记录开始位置,默认0
     pageSize 	int 	否 	每页显示条数,默认10   */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
    // 下拉刷新
    @weakify(self)
    self.benefitQuiryView.quiryRecordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [quiryRecordModel requestCardTypeListDataParams:params tableView:self.benefitQuiryView.quiryRecordTableView success:^(NSMutableArray *bennfitQuiryRecordArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.benefitQuiryView.quiryRecordArray removeAllObjects];
            // 判断是否有数据
            if (bennfitQuiryRecordArray.count == 0) {
                [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    noLabel.text = @"还没有查询记录\n去新增查询添加吧！";
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.benefitQuiryView.quiryRecordTableView.mas_centerX);
                        make.centerY.equalTo(self.benefitQuiryView.quiryRecordTableView.mas_centerY);
                    }];
                }];
            }else {
                self.benefitQuiryView.quiryRecordArray = bennfitQuiryRecordArray;
            }
            [self.benefitQuiryView.quiryRecordTableView reloadData];
        }];
    }];
    // 上拉加载
    self.benefitQuiryView.quiryRecordTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [quiryRecordModel userCardLoadRequestData:self.benefitQuiryView.quiryRecordTableView params:params viewController:self success:^(NSMutableArray *bennfitQuiryRecordArray) {
            [self.benefitQuiryView.quiryRecordArray addObjectsFromArray:bennfitQuiryRecordArray];
            [self.benefitQuiryView.quiryRecordTableView reloadData];
        }];
    }];
    // 马上刷新
    [self.benefitQuiryView.quiryRecordTableView.mj_header beginRefreshing];
}
#pragma mark - 按钮点击方法
// 保险查询页，右边按钮点击
- (void)benefitQuiryRightBarBtnAction {
    
    
}
// 查询历史点击代理
- (void)quiryRecordChoiceCell:(NSIndexPath *)indexPath quiryRecordModel:(BennfitQuiryRecordModel *)quiryRecordModel {
    /** 查询状态 （1:查询中。2:完成。3:失败） */
    switch (quiryRecordModel.status) {
        case 1: {
            BenefitQuiryInfoWebController *quiryOngoing = [[BenefitQuiryInfoWebController alloc] init];
            NSString *WEBURL = [NSString stringWithFormat:@"%@%@?car_plate_no=%@", WEBAPI, @"insurance/insuranceWriting.html", quiryRecordModel.car_plate_no];
            PDLog(@"%@", WEBURL);
            quiryOngoing.webUrl = WEBURL;
            quiryOngoing.quiryRecordModel = quiryRecordModel;
            [self.navigationController pushViewController:quiryOngoing animated:YES];
            break;
        }
        case 2: {
            BenefitQuiryInfoWebController *quirySuccess = [[BenefitQuiryInfoWebController alloc] init];
            NSString *WEBURL = [NSString stringWithFormat:@"%@%@?car_plate_no=%@", WEBAPI, @"insurance/insuranceResult.html", quiryRecordModel.car_plate_no];
            PDLog(@"%@", WEBURL);
            quirySuccess.webUrl = WEBURL;
            quirySuccess.quiryRecordModel = quiryRecordModel;
            [self.navigationController pushViewController:quirySuccess animated:YES];
            break;
        }
        case 3: {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"查询失败是您的信息填写不正确\n或拍摄不清楚，您要重新编辑吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *admit = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                UIButton *checkBtn = (UIButton *)[self.benefitQuiryView viewWithTag:5010];
                [self.benefitQuiryView benefitTabBtnAction:checkBtn];
                /** 车牌号 */
                self.benefitQuiryView.plnView.viceTextFiled.text = quiryRecordModel.car_plate_no;
                /** 品牌车型 */
                self.benefitQuiryView.carBrandView.viceTextFiled.text = quiryRecordModel.license_brand_model;
                /** 车架号 */
                self.benefitQuiryView.vinView.viceTextFiled.text = quiryRecordModel.vin;
                /** 发动机号 */
                self.benefitQuiryView.engineView.viceTextFiled.text = quiryRecordModel.engine_num;
                /** 初次登记时间 */
                self.benefitQuiryView.checkTimeView.viceTextFiled.text = quiryRecordModel.register_time;
            }];
            [alertController addAction:admit];
            [self presentViewController:alertController animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}


// 保险查询页，按钮点击
- (void)benefitQuiryBtnAvtion:(UIButton *)button {
    [self.benefitQuiryView endEditing:YES];
    switch (button.tag) {
            /** 车牌号 */
        case PlnBtnAction: {
            PhotographViewController *photographVC = [[PhotographViewController alloc] init];
            photographVC.photographViewType = BenefitQuiryAssignment;
            photographVC.DistinguishSuccessBlock = ^(NSMutableDictionary *plnPhoto) {
                // 车牌号
                if (plnPhoto) {
                    /** 车牌号 */
                    self.benefitQuiryView.plnView.viceTextFiled.text = plnPhoto[@"车牌号"];
                    /* /index.php?c=insurance_query&a=car_info&v=1
                     provider_id 	int 	是 	服务商id
                     car_plate_no 	int 	是 	车牌号       */
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
                    params[@"car_plate_no"] = self.benefitQuiryView.plnView.viceTextFiled.text; // 车牌号
                    [BenefitCarInfoModel usePlnQuiryCarInfo:params success:^(BenefitCarInfoModel *carInfo) {
                        /** 品牌车型 */
                        self.benefitQuiryView.carBrandView.viceTextFiled.text = carInfo.license_brand_model;
                        /** 车架号 */
                        self.benefitQuiryView.vinView.viceTextFiled.text = carInfo.vin;
                        /** 发动机号 */
                        self.benefitQuiryView.engineView.viceTextFiled.text = carInfo.engine_num;
                        /** 初次登记时间 */
                        self.benefitQuiryView.checkTimeView.viceTextFiled.text = carInfo.register_time;
                    }];
                }
            };
            [self.navigationController pushViewController:photographVC animated:YES];
            break;
        }
            /** 提交查询 */
        case SubmitQueryBtnAction: {
            // 判断车牌号格式
            if (![CustomObject isPlnNumber:self.benefitQuiryView.plnView.viceTextFiled.text]) {
                [MBProgressHUD showError:@"车牌号格式不正确"];
                return;
            }
            // 判断车牌型号不能为空
            if (self.benefitQuiryView.carBrandView.viceTextFiled.text.length == 0) {
                [MBProgressHUD showError:@"品牌车型不能为空"];
                return;
            }
            // 判断车架号不能为空
            if (self.benefitQuiryView.vinView.viceTextFiled.text.length == 0) {
                [MBProgressHUD showError:@"车架号不能为空"];
                return;
            }
            // 判断车架号输入位数
            if (self.benefitQuiryView.vinView.viceTextFiled.text.length != 17) {
                [MBProgressHUD showError:@"请输入17位车架号"];
                return;
            }
            // 判断发动机号不能为空
            if (self.benefitQuiryView.engineView.viceTextFiled.text.length == 0) {
                [MBProgressHUD showError:@"发动机号不能为空"];
                return;
            }
            /* /index.php?c=insurance_query&a=add&v=1
             provider_id 	int 	是 	服务商id
             staff_user_id 	int 	是 	登录者id
             car_plate_no 	string 	否 	车牌号(拍照不传,直接查询必传)
             license_brand_model 	string 	否 	车牌型号(拍照不传,直接查询必传)
             engine_num 	string 	否 	发动机号(拍照不传,直接查询必传)
             vin 	string 	否 	车架号(拍照不传,直接查询必传)
             register_time 	string 	否 	初次登记时间(拍照不传,直接查询必传)
             query_type 	int 	否 	查询方式, 1-输入查询 2-拍照查询 (默认为1)      */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
            params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
            params[@"car_plate_no"] = self.benefitQuiryView.plnView.viceTextFiled.text; // 车牌号
            params[@"license_brand_model"] = self.benefitQuiryView.carBrandView.viceTextFiled.text; // 车牌型号
            params[@"engine_num"] = self.benefitQuiryView.engineView.viceTextFiled.text; // 发动机号
            params[@"vin"] = self.benefitQuiryView.vinView.viceTextFiled.text; // 车架号
            params[@"register_time"] = self.benefitQuiryView.checkTimeView.viceLabel.text; // 初次登记时间
            params[@"query_type"] = @"1"; // 查询方式
            [BennfitQuiryRecordModel addBenefitQuiryTextFieldParams:params success:^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功，10分钟后出查询结果" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *admit = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    UIButton *checkBtn = (UIButton *)[self.benefitQuiryView viewWithTag:5010];
                    [self.benefitQuiryView benefitTabBtnAction:checkBtn];
                }];
                [alertController addAction:admit];
                [self presentViewController:alertController animated:YES completion:nil];
            }];
            break;
        }
            /** 拍摄行驶证查询 */
        case ShotQueryBtnAction: {
            // 图片选择
            [AlertAction callCameraAlertActionStyleActionSheetBtn:button ViewController:self CameraBlock:^(UIImagePickerController *picker) {
                // 设置代理
                picker.delegate = self;
            } albumBlock:^(UIImagePickerController *picker) {
                // 设置代理
                picker.delegate = self;
            } cancelBlock:nil];
            break;
        }
        default:
            break;
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [[UIImage alloc] init];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        image = [info valueForKey:UIImagePickerControllerEditedImage];
    } else {
        image = [info valueForKey:UIImagePickerControllerEditedImage];
    }
    
    // 模态出图片编辑
    @weakify(self)
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        @strongify(self)
        ImageCropViewController *imageCropVC = [[ImageCropViewController alloc] init];
        imageCropVC.delegate = self;
        imageCropVC.image = image;
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        CGFloat length = MIN(width, height);
        imageCropVC.imageCropRect = CGRectMake((width - length) / 2, (height - length) / 2, length, length);
        imageCropVC.toolbarHidden = YES;
        [self.navigationController pushViewController:imageCropVC animated:YES];
    }];
}
#pragma mark - 取消图片挑选
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{    }];
}

#pragma mark - 图片裁剪代理方法
// 确认裁剪
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    [self.navigationController popViewControllerAnimated:YES];
    /* /index.php?c=insurance_query&a=add&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     query_type 	int 	否 	查询方式, 1-输入查询 2-拍照查询 (默认为1)      */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
    params[@"query_type"] = @"2"; // 查询方式
    [BennfitQuiryRecordModel addBenefitQuiryImageViewParams:params drivingPermitImage:croppedImage success:^{
        
    }];
}
// 取消裁剪
- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - textField输入代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断是输入内容,不是删除内容
    if (string && string.length != 0) {
        // 拼接textField内容和输入内容
        NSString *tfText = [textField.text stringByAppendingString:string];
        // 判断是那个输入框
        if ([CustomObject isPlnNumber:tfText]) { // 车牌号输入框
            /* /index.php?c=insurance_query&a=car_info&v=1
             provider_id 	int 	是 	服务商id
             car_plate_no 	int 	是 	车牌号       */
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
            params[@"car_plate_no"] = self.benefitQuiryView.plnView.viceTextFiled.text; // 车牌号
            [BenefitCarInfoModel usePlnQuiryCarInfo:params success:^(BenefitCarInfoModel *carInfo) {
                /** 品牌车型 */
                self.benefitQuiryView.carBrandView.viceTextFiled.text = carInfo.license_brand_model;
                /** 车架号 */
                self.benefitQuiryView.vinView.viceTextFiled.text = carInfo.vin;
                /** 发动机号 */
                self.benefitQuiryView.engineView.viceTextFiled.text = carInfo.engine_num;
                /** 初次登记时间 */
                self.benefitQuiryView.checkTimeView.viceTextFiled.text = carInfo.register_time;
            }];
        }
    }
    return YES;
}

#pragma mark - 界面赋值
- (void)benefitQuiryAssignment {
    /** 车牌号 */
    self.benefitQuiryView.plnView.viceTextFiled.text = self.userCar.car_plate_no;
    /** 品牌车型 */
    self.benefitQuiryView.carBrandView.viceTextFiled.text = self.userCar.car_brand_series;
//    /** 车架号 */
//    self.benefitQuiryView.vinView.viceTextFiled.text = self.userCar.car_brand_series;
//    /** 发动机号 */
//    self.benefitQuiryView.engineView.viceTextFiled.text = self.userCar.car_brand_series;
//    /** 初次登记时间 */
//    self.benefitQuiryView.checkTimeView.viceTextFiled.text = self.userCar.car_brand_series;
}
#pragma mark - 布局nav
- (void)benefitQuiryLayoutNAV {
    self.navigationItem.title = @"保险查询";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(benefitQuiryLeftBtnAction)];
    // 右边   benefitQuiryRightBarBtnAction
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(benefitQuiryRightBarBtnAction)];
}
#pragma mark - 布局视图
- (void)benefitQuiryLayoutView {
    /** 保险查询 */
    self.benefitQuiryView = [[BenefitQuiryView alloc] init];
    self.benefitQuiryView.delegate = self;
    /** 车牌号 */
    self.benefitQuiryView.plnView.viceTextFiled.delegate = self;
    [self.benefitQuiryView.plnView.arrowImage addTarget:self action:@selector(benefitQuiryBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 提交查询 */
    [self.benefitQuiryView.submitQueryBtn addTarget:self action:@selector(benefitQuiryBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 拍摄行驶证查询 */
    [self.benefitQuiryView.shotQueryBtn addTarget:self action:@selector(benefitQuiryBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
