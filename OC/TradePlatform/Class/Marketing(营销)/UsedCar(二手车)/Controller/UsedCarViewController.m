//
//  UsedCarViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarViewController.h"
// view
#import "UsedCarView.h"
#import "CashierServiceChoiceView.h"
// 下级控制器
#import "UsedCarBrandViewController.h"
#import "UsedCarValuationInfoViewController.h"
#import "CityListViewController.h"
// 模型
#import "CarConditionModel.h"
#import "CarUseModel.h"
#import "ValuationNotesModel.h"

@interface UsedCarViewController ()<UsedCarValuationInfoChoiceDelegate, CashierServiceChoiceDelegate>

/** 二手车估值view */
@property (strong, nonatomic) UsedCarView *usedCarView;
/** 选中车品牌 */
@property (strong, nonatomic) UsedCarBrandModel *usedCarBrandModel;
/** 选中车系 */
@property (strong, nonatomic) UsedCarBrandModel *usedCarSerierModel;
/** 选中车型 */
@property (strong, nonatomic) UsedCarBrandModel *usedCarKindsModel;
/** 选中城市 */
@property (strong, nonatomic) CityModel *cityModel;
/** 默认选择车况 */
@property (strong, nonatomic) CarConditionModel *defaultCarCondition;
/** 默认选择车辆用途 */
@property (strong, nonatomic) CarUseModel *defaultCarUse;

@end

@implementation UsedCarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self usedCarLayoutNAV];
    // 布局视图
    [self usedCarLayoutView];
    /** 加载二手车品牌数据 */
    [UsedCarBrandHandle sharedInstance];
    // 加载二手车估值记录数据
    [self valuationRecordRepuestData];
}
#pragma mark - 网络请求
- (void)valuationRecordRepuestData {
    ValuationNotesModel *valuationNotesModel = [[ValuationNotesModel alloc] init];
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
    self.usedCarView.valuationRecordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [valuationNotesModel usedCarValuationListDataParams:params tableView:self.usedCarView.valuationRecordTableView success:^(NSMutableArray *valuationNotesArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.usedCarView.valuationRecordArray removeAllObjects];
            // 判断是否有数据
            if (valuationNotesArray.count == 0) {
                [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    noLabel.text = @"还没有估值记录\n去新增估值添加吧！";
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.usedCarView.valuationRecordTableView.mas_centerX);
                        make.centerY.equalTo(self.usedCarView.valuationRecordTableView.mas_centerY);
                    }];
                }];
            }else {
                self.usedCarView.valuationRecordArray = valuationNotesArray;
            }
            [self.usedCarView.valuationRecordTableView reloadData];
        }];
    }];
    // 上拉加载
    self.usedCarView.valuationRecordTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [valuationNotesModel usedCarValuationLoadRequestData:self.usedCarView.valuationRecordTableView params:params success:^(NSMutableArray *valuationNotesArray) {
            [self.usedCarView.valuationRecordArray addObjectsFromArray:valuationNotesArray];
            [self.usedCarView.valuationRecordTableView reloadData];
        }];
    }];
    // 马上刷新
    [self.usedCarView.valuationRecordTableView.mj_header beginRefreshing];
}

#pragma mark - 按钮点击方法
- (void)usedCarBtnAvtion:(UIButton *)button {
    [self.usedCarView endEditing:YES];
    switch (button.tag) {
            /** 车辆型号 */
        case CarBrandBtnAction:{
            UsedCarBrandViewController *usedCarBrandVC = [[UsedCarBrandViewController alloc] init];
            usedCarBrandVC.usedCarBrandChoiceBlock = ^(UsedCarBrandModel *usedCarBrandModel, UsedCarBrandModel *usedCarSerierModel, UsedCarBrandModel *usedCarKindsModel) {
                /** 选中车品牌 */
                self.usedCarBrandModel = usedCarBrandModel;
                /** 选中车系 */
                self.usedCarSerierModel = usedCarSerierModel;
                /** 选中车型 */
                self.usedCarKindsModel = usedCarKindsModel;
                // 选中车型
                self.usedCarView.carBrandDetails.text = [NSString stringWithFormat:@"%@", usedCarKindsModel.name];
                self.usedCarView.carBrandDetails.textColor = Black;
            };
            [self.navigationController pushViewController:usedCarBrandVC animated:YES];
            break;
        }
            /** 所在城市 */
        case CityBtnAction:{
            CityListViewController *cityListVC = [[CityListViewController alloc] init];
            @weakify(self)
            cityListVC.cityChoiceBlock = ^ (CityModel *cityModel) {
                @strongify(self)
                // 保存当前城市模型
                self.cityModel = cityModel;
                // 所在城市
                self.usedCarView.cityView.describeLabel.text = cityModel.cityName;
                self.usedCarView.cityView.describeLabel.textColor = Black;
            };
            [self.navigationController pushViewController:cityListVC animated:YES];
            break;
        }
            /** 车况 */
        case ConditionBtnAction:{
            [CarConditionModel requestCarConditionSuccess:^(NSMutableArray *carConditionArray) {
                // 遍历所有车况，找到当前选中的车况
                for (CarConditionModel *carConditionModel in carConditionArray) {
                    carConditionModel.checkMark = NO;
                    if (carConditionModel.car_condition_id == self.defaultCarCondition.car_condition_id) {
                        carConditionModel.checkMark = YES;
                    }
                }
                CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
                payChoiceBoxView.choiceArray = carConditionArray;
                payChoiceBoxView.serviceChoice = CarConditionTypeChoiceBtnAction;
                payChoiceBoxView.delegate = self;
                [payChoiceBoxView show];
            }];
            break;
        }
            /** 车辆用途 */
        case CarUseBtnAction:{
            [CarUseModel requestCarPurposeSuccess:^(NSMutableArray *carPurposeArray) {
                // 遍历所有车辆用途务，找到当前选中的车辆用途
                for (CarUseModel *carUseModel in carPurposeArray) {
                    carUseModel.checkMark = NO;
                    if (carUseModel.purpose_id == self.defaultCarUse.purpose_id) {
                        carUseModel.checkMark = YES;
                    }
                }
                CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
                payChoiceBoxView.choiceArray = carPurposeArray;
                payChoiceBoxView.serviceChoice = CarUseTypeChoiceBtnAction;
                payChoiceBoxView.delegate = self;
                [payChoiceBoxView show];
            }];
            break;
        }
            /** 开始估值 */
        case StartValuationBtnAction:{
            // 判断是否选择了车型
            if ([self.usedCarView.carBrandDetails.text isEqualToString:@"请选择车辆型号"]) {
                [MBProgressHUD showError:@"请选择车辆型号"];
                return;
            }
            // 判断是否选择了所在城市
            if ([self.usedCarView.cityView.describeLabel.text isEqualToString:@"请选择所在城市"]) {
                [MBProgressHUD showError:@"请选择所在城市"];
                return;
            }
            // 判断是否选择了首次上牌
            if ([self.usedCarView.firstFailingView.describeLabel.text isEqualToString:@"请选择上牌时间"]) {
                [MBProgressHUD showError:@"请选择上牌时间"];
                return;
            }
            // 判断是否选择了首次上牌
            if ([self.usedCarView.firstFailingView.describeLabel.text isEqualToString:@"请选择上牌时间"]) {
                [MBProgressHUD showError:@"请选择上牌时间"];
                return;
            }
            // 判断是否输入了行驶里程
            if ([self.usedCarView.mileageView.viceTextFiled.text doubleValue] <= 0) {
                [MBProgressHUD showError:@"请输入行驶里程"];
                return;
            }
            // 判断是否选择了车况
            if ([self.usedCarView.conditionView.describeLabel.text isEqualToString:@"请选择车况"]) {
                [MBProgressHUD showError:@"请选择车况"];
                return;
            }
            // 判断是否选择了车辆用途
            if ([self.usedCarView.carUseView.describeLabel.text isEqualToString:@"请选择车辆用途"]) {
                [MBProgressHUD showError:@"请选择车辆用途"];
                return;
            }
            // 判断是否输入了车辆购入价
            if ([self.usedCarView.carBuyPriceView.viceTextFiled.text doubleValue] <= 0) {
                [MBProgressHUD showError:@"请输入车辆购入价"];
                return;
            }
            /* /index.php?c=usedcar_assess&a=car_assess&v=1
             provider_id 	int 	是 	服务商id
             provider_user_car_id 	int 	否 	用户车辆id,用户详情中必传
             city_id 	int 	是 	城市id
             brand_id 	int 	是 	品牌id
             brand_series_id 	int 	是 	车系id
             car_model_id 	int 	是 	车型id
             purpose 	int 	是 	车辆用途：1自用 2公务商用 3营运
             car_status 	int 	是 	车况：1优秀 2一般 3较差
             used_date 	string 	是 	上牌时间： 格式yyyy-mm
             mileage 	float 	是 	公里数
             purchase_price 	float 	是 	购买价格     */
            NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
            parame[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
            parame[@"provider_user_car_id"] = self.userCar.provider_user_car_id; // 用户车辆id
            parame[@"city_id"] = self.cityModel.cityID; // 城市id
            parame[@"brand_id"] = [NSString stringWithFormat:@"%ld", self.usedCarBrandModel.brand_series_id]; // 品牌id
            parame[@"brand_series_id"] = [NSString stringWithFormat:@"%ld", self.usedCarSerierModel.brand_series_id]; // 车系id
            parame[@"car_model_id"] = [NSString stringWithFormat:@"%ld", self.usedCarKindsModel.car_model_id]; // 车型id
            parame[@"purpose"] = [NSString stringWithFormat:@"%ld", self.defaultCarUse.purpose_id]; // 车辆用途id
            parame[@"car_status"] = [NSString stringWithFormat:@"%ld", self.defaultCarCondition.car_condition_id]; // 车况id
            parame[@"used_date"] = self.usedCarView.firstFailingView.describeLabel.text; // 上牌时间
            parame[@"mileage"] = self.usedCarView.mileageView.viceTextFiled.text; // 公里数
            parame[@"purchase_price"] = self.usedCarView.carBuyPriceView.viceTextFiled.text; // 购买价格
            [ValuationNotesModel AddUsedCarValuation:parame success:^{
                // 马上刷新
                [self.usedCarView.valuationRecordTableView.mj_header beginRefreshing];
                //
                [self.usedCarView usedCarTabBtnAction:self.usedCarView.usedCarHistoryBtn];
            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 二手车详情选择点击代理
- (void)usedCarValuationInfoChoiceCell:(ValuationNotesModel *)valuationNotesModel {
    UsedCarValuationInfoViewController *usedCarValuationInfoVC = [[UsedCarValuationInfoViewController alloc] init];
    usedCarValuationInfoVC.valuationNotesModel = valuationNotesModel;
    [self.navigationController pushViewController:usedCarValuationInfoVC animated:YES];
}

#pragma mark - 车况，车辆用途选择代理
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    switch (serviceChoice) {
        case CarConditionTypeChoiceBtnAction:{
            /** 默认选择车况 */
            self.defaultCarCondition = [choiceArray objectAtIndex:indexPath.row];
            // 车况view赋值
            self.usedCarView.conditionView.describeLabel.text = self.defaultCarCondition.car_condition_name;
            self.usedCarView.conditionView.describeLabel.textColor = Black;
            break;
        }
            /** 车辆用途 */
        case CarUseTypeChoiceBtnAction:{
            /** 默认选择车辆用途 */
            self.defaultCarUse = [choiceArray objectAtIndex:indexPath.row];
            // 车辆用途view赋值
            self.usedCarView.carUseView.describeLabel.text = self.defaultCarUse.purpose_name;
            self.usedCarView.carUseView.describeLabel.textColor = Black;
            break;
        }
        default:
            break;
    }
}

#pragma mark - 界面赋值
- (void)usedCarAssignment {
    
    
}


#pragma mark - 布局nav
- (void)usedCarLayoutNAV {
    self.navigationItem.title = @"二手车估值";
        // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(usedCarRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(usedCarRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)usedCarLayoutView {
    /** 二手车估值view */
    self.usedCarView = [[UsedCarView alloc] init];
    // 遵守估值记录点击代理
    self.usedCarView.delegate = self;
    /** 车辆型号 */
    [self.usedCarView.carBrandBtn addTarget:self action:@selector(usedCarBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 所在城市 */
    [self.usedCarView.cityView.usedCellBtn addTarget:self action:@selector(usedCarBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 车况 */
    [self.usedCarView.conditionView.usedCellBtn addTarget:self action:@selector(usedCarBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 车辆用途 */
    [self.usedCarView.carUseView.usedCellBtn addTarget:self action:@selector(usedCarBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 开始估值 */
    [self.usedCarView.startValuationBtn addTarget:self action:@selector(usedCarBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.usedCarView];
    @weakify(self)
    [self.usedCarView mas_makeConstraints:^(MASConstraintMaker *make) {
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
