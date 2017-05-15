//
//  PolicyDetailViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PolicyDetailViewController.h"
#import "PolicyDetailView.h"
//下级
#import "PolicyAddressViewController.h"
//model
#import "PolicyDetailModel.h"

@interface PolicyDetailViewController ()
/** 订单view */
@property (strong, nonatomic) PolicyDetailView *policyDetailView;
/** 详情model */
@property (strong, nonatomic) PolicyDetailModel *policyDetailModel;
/*================== 出保单 ================*/
/** 实付详情按钮view */
@property (strong, nonatomic) UsedCellView *thePaidBtnView;
/** 实付详情按钮 */
@property (strong, nonatomic) UIButton *thePaidBtn;

@end

@implementation PolicyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self dangerRecordLayoutNAV];
    // 布局视图
    [self PolicyDetailLayoutView];
    // 网络请求
    [self quotationRequestData];
}
#pragma mark - 布局nav
- (void)dangerRecordLayoutNAV {
    self.navigationItem.title = @"详细报价";
}


#pragma mark - 网络请求
- (void)quotationRequestData{
    PolicyDetailModel *policyDetailModel = [[PolicyDetailModel alloc] init];
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_whereFrom == 1) {
        params[@"insurance_quote_id"] = self.insuranceQuoteModel.insurance_quote_id; // 服务商id
    }else if (_whereFrom == 2) {
        params[@"insurance_quote_id"] = self.dangerRecordModel.insurance_quote_id; // 服务商id
    }
    
    // 网络请求
    [policyDetailModel PolicyDetailRefreshRequestData:nil params:params viewController:self success:^(PolicyDetailModel *policyDetailModel) {
        self.policyDetailModel = policyDetailModel;
    }];
    
}
#pragma mark - 填充数据
- (void)setPolicyDetailModel:(PolicyDetailModel *)policyDetailModel{
    _policyDetailModel = policyDetailModel;
    //强制险
    self.policyDetailView.compulsoryInsuranceTableArray = policyDetailModel.insurance_categorys.jqx.insurance_categorys.mutableCopy;
    [self.policyDetailView.compulsoryInsuranceTable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.policyDetailView.compulsoryInsuranceTableArray.count*30);
    }];
    [self.policyDetailView.compulsoryInsuranceTable reloadData];
    
    // 商业险
    self.policyDetailView.businessInsuranceTableArray = policyDetailModel.insurance_categorys.syx.insurance_categorys.mutableCopy;
    [self.policyDetailView.businessInsuranceTable reloadData];
    [self.policyDetailView.businessInsuranceTable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.policyDetailView.businessInsuranceTableArray.count*30);
    }];
    
    // 强制险
    NSArray *jqxMoneyArr = policyDetailModel.insurance_categorys.jqx.insurance_categorys;
    double jqxMoney = 0;
    for (JqxInsuranceCategorys *mo in jqxMoneyArr) {
        jqxMoney = jqxMoney + mo.premium;
    }
    NSMutableAttributedString *jqxStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"保费小计:%.2f元",jqxMoney]];
    [jqxStr addAttribute:NSForegroundColorAttributeName value:GrayH1 range:NSMakeRange(0, 5)];
    self.policyDetailView.theCompulsoryView.describeLabel.attributedText = jqxStr;
    
    // 商业险
    NSArray *syxMoneyArr = policyDetailModel.insurance_categorys.syx.insurance_categorys;
    double syxMoney = 0;
    for (SyxInsuranceCategorys *mo in syxMoneyArr) {
        syxMoney = syxMoney + mo.premium;
    }
    NSMutableAttributedString *syxStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"保费小计:%.2f元",syxMoney]];
    [syxStr addAttribute:NSForegroundColorAttributeName value:GrayH1 range:NSMakeRange(0, 5)];
    self.policyDetailView.theBusinessView.describeLabel.attributedText = syxStr;
    
    if (_whereFrom == 1) {
        /*================== 出保单  ================*/
        /** 出保单 */
        self.thePaidBtnView = [[UsedCellView alloc] init];
        self.thePaidBtnView.cellLabel.text = @"实付";
        self.thePaidBtnView.cellLabel.font = FourteenTypeface;
        self.thePaidBtnView.cellLabel.textColor = Black;
        self.thePaidBtnView.viceLabel.font = EighteenTypeface;
        self.thePaidBtnView.viceLabel.textColor = HEXSTR_RGB(@"ef5350");
        self.thePaidBtnView.isArrow = YES;
        self.thePaidBtnView.isCellBtn = YES;
        self.thePaidBtnView.isSplistLine = YES;
        self.thePaidBtnView.isCellImage = YES;
        [self.view addSubview:self.thePaidBtnView];
        /** 出保单btn */
        self.thePaidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.thePaidBtn.backgroundColor = ThemeColor;
        self.thePaidBtn.titleLabel.textColor = WhiteColor;
        self.thePaidBtn.layer.cornerRadius = 2;
        self.thePaidBtn.clipsToBounds = YES;
        [self.thePaidBtn addTarget:self action:@selector(printfPolicy) forControlEvents:UIControlEventTouchUpInside];
        [self.thePaidBtn setTitle:@"出保单" forState:UIControlStateNormal];
        self.thePaidBtn.titleLabel.font = SixteenTypeface;
        [self.thePaidBtnView addSubview:self.thePaidBtn];
        /** 实付详情btnView */
        @weakify(self)
        [self.thePaidBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.height.mas_equalTo(@50);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        /** 实付详情btn */
        [self.thePaidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.height.mas_equalTo(@40);
            make.width.mas_equalTo(@120);
            make.centerY.mas_equalTo(self.thePaidBtnView.centerY);
            make.right.equalTo(self.thePaidBtnView.mas_right).offset(-16);
        }];
    }
    // 询价or出现   布局约束
    self.policyDetailView.whereFrom = _whereFrom;
    /*================== 询价 or 出现  ================*/
    if (_whereFrom == 1) {//询价
        // 到期时间
        self.policyDetailView.timeTableArray = policyDetailModel.insurance_end_time.mutableCopy;
        [self.policyDetailView.TimeTable reloadData];
        [self.policyDetailView.TimeTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.policyDetailView.timeTableArray.count*30);
        }];
        // 保险信息
        [self.policyDetailView.theInsuranceBankView.cellImage setImageWithImageUrl:_insuranceQuoteModel.insurance_company_icon perchImage:@"company_icon"];
        self.policyDetailView.theInsuranceBankView.describeLabel.text = _insuranceQuoteModel.insurance_company_name;
        self.policyDetailView.theInsuranceAmountView.describeLabel.text = [NSString stringWithFormat:@"%.2f 元",_insuranceQuoteModel.total_price];
        self.policyDetailView.theDiscountView.describeLabel.text = [NSString stringWithFormat:@"%.4f",_insuranceQuoteModel.discount];
        // 车辆信息
        self.policyDetailView.theCarNumView.cellLabel.text = _inquiryRecordModel.car_plate_no;
        self.policyDetailView.theCarNumView.describeLabel.text = _inquiryRecordModel.license_brand_model;
        self.policyDetailView.theCarTypeView.cellLabel.text = _inquiryRecordModel.name;
        self.thePaidBtnView.viceLabel.text = [NSString stringWithFormat:@"%.2f 元",_insuranceQuoteModel.actual_total_price];
    }else if (_whereFrom == 2) {//出现
        // 生效时间
        self.policyDetailView.timeTableArray = policyDetailModel.insurance_start_time.mutableCopy;
        [self.policyDetailView.TimeTable reloadData];
        [self.policyDetailView.TimeTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.policyDetailView.timeTableArray.count*30);
        }];
        // 保险信息
        [self.policyDetailView.theInsuranceBankView.cellImage setImageWithImageUrl:_dangerRecordModel.insurance_company_icon perchImage:@"company_icon"];
        self.policyDetailView.theInsuranceBankView.describeLabel.text = _dangerRecordModel.insurance_company_name;
        self.policyDetailView.theInsuranceAmountView.describeLabel.text = [NSString stringWithFormat:@"%.2f 元",_dangerRecordModel.total_price];
        self.policyDetailView.theDiscountView.describeLabel.text = [NSString stringWithFormat:@"%.4f",_dangerRecordModel.discount];
        // 车辆信息
        self.policyDetailView.theCarNumView.cellLabel.text = _dangerRecordModel.car_plate_no;
        self.policyDetailView.theCarNumView.describeLabel.text = _dangerRecordModel.license_brand_model;
        self.policyDetailView.theCarTypeView.cellLabel.text = _dangerRecordModel.owner_name;
        self.policyDetailView.thePaidView.describeLabel.text = [NSString stringWithFormat:@"%.2f 元",_dangerRecordModel.actual_total_price];
        // 收件人信息
        self.policyDetailView.theRecipientView.describeLabel.text = _dangerRecordModel.name;
        self.policyDetailView.theRecipientPhoneView.describeLabel.text = _dangerRecordModel.mobile;
        self.policyDetailView.theRecipientAddressView.describeLabel.text = _dangerRecordModel.address;
    }
    
}
#pragma mark - 布局视图
- (void)PolicyDetailLayoutView{
    /** 详情view */
    self.policyDetailView = [[PolicyDetailView alloc] init];
    [self.view addSubview:self.policyDetailView];
    @weakify(self)
    [self.policyDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        if (_whereFrom == 1) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        }else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        
    }];

}
#pragma mark - 出保单
-(void)printfPolicy{
    PolicyAddressViewController *policyAddressVC = [[PolicyAddressViewController alloc] init];
    policyAddressVC.insuranceQuoteModel = self.insuranceQuoteModel;
    policyAddressVC.inquiryRecordModel = self.inquiryRecordModel;
    [self.navigationController pushViewController:policyAddressVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
