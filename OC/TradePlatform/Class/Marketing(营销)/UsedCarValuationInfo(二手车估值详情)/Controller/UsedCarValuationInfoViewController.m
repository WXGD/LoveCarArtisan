//
//  UsedCarValuationInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarValuationInfoViewController.h"
// view
#import "UsedCarValuationInfoView.h"
// model
#import "UsedCarValuationInfoModel.h"


@interface UsedCarValuationInfoViewController ()

/** 二手车估值详情view */
@property (strong, nonatomic) UsedCarValuationInfoView *usedCarValuationInfoView;
/** 二手车估值详情数据 */
@property (strong, nonatomic) UsedCarValuationInfoModel *valuationInfoModel;

@end

@implementation UsedCarValuationInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self usedCarValuationInfoLayoutNAV];
    // 布局视图
    [self usedCarValuationInfoLayoutView];
    // 请求二手车估值详情数据
    [self requestUsedCarValuationInfoData];
}
#pragma mark - 网络请求
// 请求二手车估值详情数据
- (void)requestUsedCarValuationInfoData {
    /* /index.php?c=usedcar_assess&a=detail&v=1
     usedcar_assess_record_id 	int 	是 	估值记录id     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"usedcar_assess_record_id"] = self.valuationNotesModel.usedcar_assess_record_id; // 估值记录id
    [UsedCarValuationInfoModel requestUsedCarValuationInfoData:params success:^(UsedCarValuationInfoModel *valuationInfoModel) {
        // 保存估值详情数据
        self.valuationInfoModel = valuationInfoModel;
        // 界面赋值
        [self usedCarValuationInfoAssignment];
    }];
}
#pragma mark - 按钮点击方法
- (void)usedCarValuationInfoBtnAvtion:(UIButton *)button {
    
}

#pragma mark - 界面赋值
- (void)usedCarValuationInfoAssignment {
    // nav标题
    self.navigationItem.title = self.valuationInfoModel.car_plate_no;
    /** 车商收购价 */
    self.usedCarValuationInfoView.buyPriceView.describeLabel.text = [NSString stringWithFormat:@"%.2f万元", self.valuationInfoModel.purchase_price];
    /** 个人交易价格 */
    self.usedCarValuationInfoView.dealPriceView.describeLabel.text = [NSString stringWithFormat:@"%.2f万元", self.valuationInfoModel.deal_price];
    /** 车牌型号 */
    self.usedCarValuationInfoView.carBrandDetails.text = self.valuationInfoModel.car_model_name;
    /** 所在城市 */
    self.usedCarValuationInfoView.cityView.describeLabel.text = self.valuationInfoModel.city_name;
    /** 首次上牌 */
    self.usedCarValuationInfoView.firstFailingView.describeLabel.text = self.valuationInfoModel.used_date;
    /** 行驶里程 */
    self.usedCarValuationInfoView.mileageView.describeLabel.text = [NSString stringWithFormat:@"%@万公里", self.valuationInfoModel.mileage];
    /** 车况 */
    self.usedCarValuationInfoView.conditionView.describeLabel.text = self.valuationInfoModel.car_status_text;
    /** 车辆用途 */
    self.usedCarValuationInfoView.carUseView.describeLabel.text = self.valuationInfoModel.purpose_text;
    /** 车辆购入价 */
    self.usedCarValuationInfoView.carBuyPriceView.describeLabel.text = [NSString stringWithFormat:@"%.2f万元", self.valuationInfoModel.buy_price];
}


#pragma mark - 布局nav
- (void)usedCarValuationInfoLayoutNAV {
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(usedCarRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(usedCarRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)usedCarValuationInfoLayoutView {
    /** 二手车估值详情view */
    self.usedCarValuationInfoView = [[UsedCarValuationInfoView alloc] init];
    [self.view addSubview:self.usedCarValuationInfoView];
    @weakify(self)
    [self.usedCarValuationInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
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
