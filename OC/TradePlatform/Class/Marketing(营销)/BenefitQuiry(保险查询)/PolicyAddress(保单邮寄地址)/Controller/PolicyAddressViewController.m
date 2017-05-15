//
//  PolicyAddressViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PolicyAddressViewController.h"
// view
#import "PolicyAddressView.h"
#import "CashierServiceChoiceView.h"
// 支付宝
#import "ALiPay.h"
#import "ALiPayHandle.h"
// 微信支付
#import "WXPayment.h"
#import "WXApiManager.h"
// 模型
#import "ConfirmPayModel.h"
// 下级控制器
#import "BenefitPaySuccessViewController.h"

@interface PolicyAddressViewController ()<ALiPayHandleDelegate, WXApiManagerDelegate, CashierServiceChoiceDelegate>

/** 邮寄地址view */
@property (strong, nonatomic) PolicyAddressView *policyAddressView;
/** 提交并支付保费btnBg */
@property (strong, nonatomic) UIView *policyBtnBgView;
/** 提交并支付保费btn */
@property (strong, nonatomic) UIButton *policyBtn;
/** 订单号 */
@property (copy, nonatomic) NSString *orderNo;

@end

@implementation PolicyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self PolicyAddressLayoutNAV];
    // 布局视图
    [self PolicyAddressLayout];
    // 填充数据
    [self PolicyAddressData];
    // 微信回调代理
    [WXApiManager sharedManager].delegate = self;
    // 支付宝回调代理
    [ALiPayHandle sharedManager].delegate = self;
}
#pragma mark - 布局nav
- (void)PolicyAddressLayoutNAV {
    self.navigationItem.title = @"填写保单邮寄地址";
}
#pragma mark - 填充数据
- (void)PolicyAddressData{
    self.policyAddressView.theCarNumView.cellLabel.text = [NSString stringWithFormat:@"受保车辆: %@",self.inquiryRecordModel.car_plate_no];
    self.policyAddressView.theCarNumView.describeLabel.text = self.inquiryRecordModel.license_brand_model;
    self.policyAddressView.theAmountView.viceLabel.text = [NSString stringWithFormat:@"%.2f元",self.insuranceQuoteModel.actual_total_price];
    self.policyAddressView.theNameView.viceTextFiled.text = self.inquiryRecordModel.name;
}


#pragma mark - 按钮点击方法
//选择日期
- (void)recipientAddress{
    [self.view endEditing:YES];
    AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc]init];
    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
        self.policyAddressView.theRecipientAddressView.viceTextFiled.textColor = Black;
        self.policyAddressView.theRecipientAddressView.viceTextFiled.text = [NSString stringWithFormat:@"%@",locate];
    };
    [addressPickerView show];
}
// 提交保单
- (void)addInsuranceorder{
    if (self.policyAddressView.theNameView.viceTextFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请输入车主姓名"];
        return;
    }
    if (![CustomObject isIDCorrect:self.policyAddressView.theCardIdView.viceTextFiled.text]) {
        [MBProgressHUD showError:@"请正确输入车主身份证号"];
        return;
    }
    if (self.policyAddressView.theRecipientNameView.viceTextFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请输入收件人姓名"];
        return;
    }
    if (![CustomObject checkTel:self.policyAddressView.theRecipientPhoneView.viceTextFiled.text]) {
        [MBProgressHUD showError:@"请正确输入收件人手机号"];
        return;
    }
    if (self.policyAddressView.theRecipientAddressView.viceTextFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请选择省市县"];
        return;
    }
    if (self.policyAddressView.theAddressDetailView.viceTextFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请输入街道、楼牌号"];
        return;
    }
    [PaymentMethodModel requestThirdPartyPayMethodSuccess:^(NSMutableArray *paymentMethodArray) {
        // 弹出支付方式选择
        CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
        payChoiceBoxView.choiceArray = paymentMethodArray;
        payChoiceBoxView.serviceChoice = PayMethodChoiceBtnAction;
        payChoiceBoxView.delegate = self;
        [payChoiceBoxView show];
    }];
}


#pragma mark - 支付方式选择
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    /** 支付方式选择 */
    PaymentMethodModel *payMethodModel = [choiceArray objectAtIndex:indexPath.row];
    

    switch (payMethodModel.pay_method_id) {
        case 1: { // 支付宝支付
            // 发起支付
            [self initiatePayment:@"1" paySuccess:^(NSMutableDictionary *responseObject) {
                // 保存订单ID
                self.orderNo = responseObject[@"insurance_order_id"];
                // 发起支付宝支付
                [ALiPay callALiPayOrderDic:responseObject[@"payStr"] paymentEndBlock:^(NSDictionary *resultDic) {
                    
                }];
            }];
            break;
        }
        case 2: { // 微信支付
            [self initiatePayment:@"2" paySuccess:^(NSMutableDictionary *responseObject) {
                // 保存订单ID
                self.orderNo = responseObject[@"insurance_order_id"];
                // 调用微信
                [WXPayment callPayment:responseObject[@"payStr"]];
            }];
            break;
        }
        default:
            break;
    }
}


#pragma mark - 支付宝回调代理
- (void)aLiPaySuccessCallback:(NSDictionary *)aliPayDic {
    // 支付宝支付状态
    NSString *payState = [[NSString alloc] init];
    if ([[NSString stringWithFormat:@"%@", aliPayDic[@"resultStatus"]] isEqualToString:@"9000"]) {
        payState = @"1";
    }else if ([[NSString stringWithFormat:@"%@", aliPayDic[@"resultStatus"]] isEqualToString:@"4000"]) {
        payState = @"0";
    }else if ([[NSString stringWithFormat:@"%@", aliPayDic[@"resultStatus"]] isEqualToString:@"6001"]) {
        payState = @"-1";
        return;
    }else {
        payState = @"0";
    }
    PDLog(@"%@", payState);
    
    /* /index.php?c=insurance_order&a=confirm&v=1
     insurance_order_id 	int 	是 	保单id
     confirm_status 	int 	是 	-1：失败 1-成功     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"insurance_order_id"] = self.orderNo; // 保单id
    params[@"confirm_status"] = payState; // 保单id
    // 支付宝支付回调
    [ConfirmPayModel payCompletionVerification:params success:^(NSMutableDictionary *responseObject) {
        // 支付状态 0-回调失败 1-成功 2-未回调且客户端确认成功 3-客户端确认失败
        NSString *paySta = [NSString stringWithFormat:@"%@", responseObject[@"is_success"]];
        if ([paySta isEqualToString:@"1"]) {
            BenefitPaySuccessViewController *benefitPaySuccessVC = [[BenefitPaySuccessViewController alloc] init];
            [self.navigationController pushViewController:benefitPaySuccessVC animated:YES];
        }
    }];
}

#pragma mark - 微信支付成功回调
- (void)managerDidRecvPayResp:(PayResp *)payResp {
    PDLog(@"%@", [NSString stringWithFormat:@"%d", payResp.errCode]);
    // 微信支付状态
    NSString *payState = [[NSString alloc] init];
    if ([[NSString stringWithFormat:@"%d", payResp.errCode] isEqualToString:@"0"]) {
        payState = @"1";
    }else if ([[NSString stringWithFormat:@"%d", payResp.errCode] isEqualToString:@"-1"]) {
        payState = @"0";
    }else if ([[NSString stringWithFormat:@"%d", payResp.errCode] isEqualToString:@"-2"]) {
        payState = @"-1";
        return;
    }else {
        payState = @"0";
    }
    PDLog(@"%@", payState);
    NSMutableDictionary *payStateDic = [[NSMutableDictionary alloc] init];
    [payStateDic setObject:payState forKey:@"payState"];
    // 微信支付回调
    /* /index.php?c=insurance_order&a=confirm&v=1
     insurance_order_id 	int 	是 	保单id
     confirm_status 	int 	是 	-1：失败 1-成功     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"insurance_order_id"] = self.orderNo; // 保单id
    params[@"confirm_status"] = payState; // 保单id
    // 支付宝支付回调
    [ConfirmPayModel payCompletionVerification:params success:^(NSMutableDictionary *responseObject) {
        // 支付状态 0-回调失败 1-成功 2-未回调且客户端确认成功 3-客户端确认失败
        if ([responseObject[@"is_success"] isEqualToString:@"1"]) {
            BenefitPaySuccessViewController *benefitPaySuccessVC = [[BenefitPaySuccessViewController alloc] init];
            [self.navigationController pushViewController:benefitPaySuccessVC animated:YES];
        }
    }];
}



#pragma mark - 布局视图
- (void)PolicyAddressLayout{
    /** 邮寄信息view */
    self.policyAddressView = [[PolicyAddressView alloc] init];
    [self.view addSubview:self.policyAddressView];
    [self.policyAddressView.theRecipientAddressView.usedCellBtn addTarget:self action:@selector(recipientAddress) forControlEvents:UIControlEventTouchUpInside];
    @weakify(self)
    [self.policyAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    self.policyBtnBgView = [UIView new];
    self.policyBtnBgView.backgroundColor = WhiteColor;
    [self.view addSubview:self.policyBtnBgView];
    [self.policyBtnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.height.mas_equalTo(50);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.policyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.policyBtn.backgroundColor = ThemeColor;
    self.policyBtn.titleLabel.textColor = WhiteColor;
    self.policyBtn.titleLabel.font = FifteenTypeface;
    [self.policyBtn setTitle:@"提交并支付保费" forState:UIControlStateNormal];
    self.policyBtn.layer.cornerRadius = 2;
    self.policyBtn.clipsToBounds = YES;
    [self.policyBtn addTarget:self action:@selector(addInsuranceorder) forControlEvents:UIControlEventTouchUpInside];
    [self.policyBtnBgView addSubview:self.policyBtn];
    [self.policyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.policyBtnBgView.mas_top).offset(5);
        make.left.equalTo(self.policyBtnBgView.mas_left).offset(16);
        make.right.equalTo(self.policyBtnBgView.mas_right).offset(-16);
        make.bottom.equalTo(self.policyBtnBgView.mas_bottom).offset(-5);
    }];
}


#pragma mark - 封装方法
// 发起支付
- (void)initiatePayment:(NSString *)payMethodId paySuccess:(void(^)(NSMutableDictionary *responseObject))paySuccess {
    // 拼接请求参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"provider_id"] = self.merchantInfo.provider_id;
    parameters[@"insurance_query_id"] = self.inquiryRecordModel.insurance_query_id;
    parameters[@"insurance_quote_id"] = self.insuranceQuoteModel.insurance_quote_id;
    parameters[@"owner_name"] = self.policyAddressView.theNameView.viceTextFiled.text;
    parameters[@"id_no"] = self.policyAddressView.theCardIdView.viceTextFiled.text;
    parameters[@"name"] = self.policyAddressView.theRecipientNameView.viceTextFiled.text;
    parameters[@"mobile"] = self.policyAddressView.theRecipientPhoneView.viceTextFiled.text;
    parameters[@"address"] = [NSString stringWithFormat:@"%@%@",self.policyAddressView.theRecipientAddressView.viceTextFiled.text,self.policyAddressView.theAddressDetailView.viceTextFiled.text];
    parameters[@"pay_method_id"] = payMethodId;//1支付宝；2微信
    parameters[@"total_price"] = [NSString stringWithFormat:@"%.2f",self.insuranceQuoteModel.actual_total_price];
    [ConfirmPayModel launchThirdPartyPayParame:parameters success:^(NSMutableDictionary *responseObject) {
        if (paySuccess) {
            paySuccess(responseObject);
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
