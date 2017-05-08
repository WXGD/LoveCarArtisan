//
//  UserCardRechargeViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardRechargeViewController.h"
// view
#import "UserCardRechargeView.h"
#import "CashierServiceChoiceView.h"

// 数据请求
#import "EditUserCardNetwork.h"
#import "ServiceMasterHandle.h"
// 下级控制器
#import "PayQRCodeViewController.h"
#import "OpenCardSuccessViewController.h"

@interface UserCardRechargeViewController ()<CashierServiceChoiceDelegate>

/** 会员卡充值View */
@property (strong, nonatomic) UserCardRechargeView *userCardRechargeView;
/** 选中的服务师傅 */
@property (strong, nonatomic) MerchantInfoModel *serviceMasterModel;
/** 选择的支付方式 */
@property (strong, nonatomic) PaymentMethodModel *payMethodModel;

@end

@implementation UserCardRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self userCardRechargeLayoutNAV];
    // 布局视图
    [self userCardRechargeLayoutView];
    // 界面赋值
    [self userCardRechargeAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
- (void)userCardRechargeBtnAction:(UIButton *)button {
}
//// nav左边按钮，取消充值
//- (void)userCardRechargeNavBarLeftBtnAction {
//    [self.navigationController popViewControllerAnimated:YES];
//}
/** 确认充值 */
- (void)confirmRechargeBtnAvtion:(UIButton *)button {
    [self.userCardRechargeView endEditing:YES];
    // 判断充值数字
    if (self.userCardRechargeView.recNoreThanRecharge.viceTextFiled.text.length == 0) {
        [MBProgressHUD showSuccess:@"充值数不能为空"];
        return;
    }
    // 判断实收金额不能为空
    if (self.userCardRechargeView.netReceiptsMoney.viceTextFiled.text.length == 0) {
        [MBProgressHUD showSuccess:@"实收金额不能为空"];
        return;
    }
    [PaymentMethodModel requestPaymentMethodSuccess:^(NSMutableArray *paymentMethodArray) {
        // 遍历支付方式，删除会员卡支付
        [paymentMethodArray enumerateObjectsUsingBlock:^(PaymentMethodModel *payMethod, NSUInteger goodsID, BOOL *stop) {
            if (payMethod.pay_method_id == 3) {
                [paymentMethodArray removeObject:payMethod];
            }
        }];
        // 弹出支付方式选择
        CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
        payChoiceBoxView.choiceArray = paymentMethodArray;
        payChoiceBoxView.serviceChoice = PayMethodChoiceBtnAction;
        payChoiceBoxView.delegate = self;
        [payChoiceBoxView show];
    }];
}
// 服务师傅选择
- (void)serviceMasterBtnAvtion:(UIButton *)button {
    [self.userCardRechargeView endEditing:YES];
    /** 服务师傅数据 */
    NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (serviceMasterArray.count == 0) {
        [ServiceMasterHandle sharedInstance].requestSuccessBlock = ^ () {
            /** 服务列表数据 */
            NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
            // 遍历所有服务，找到当前选中的服务
            for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
                serviceMasterModel.checkMark = NO;
                if ([serviceMasterModel.staff_user_id isEqualToString:self.merchantInfo.staff_user_id]) {
                    serviceMasterModel.checkMark = YES;
                }
            }
            // 弹出支付方式选择
            CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            payChoiceBoxView.choiceArray = serviceMasterArray;
            payChoiceBoxView.serviceChoice = ServiceMasterChoiceBtnAction;
            payChoiceBoxView.delegate = self;
            [payChoiceBoxView show];
        };
    }else {
        /** 服务列表数据 */
        NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
        // 遍历所有服务，找到当前选中的服务
        for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
            serviceMasterModel.checkMark = NO;
            if ([serviceMasterModel.staff_user_id isEqualToString:self.merchantInfo.staff_user_id]) {
                serviceMasterModel.checkMark = YES;
            }
        }
        // 弹出支付方式选择
        CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
        payChoiceBoxView.choiceArray = serviceMasterArray;
        payChoiceBoxView.serviceChoice = ServiceMasterChoiceBtnAction;
        payChoiceBoxView.delegate = self;
        [payChoiceBoxView show];
    }
}
#pragma mark - 服务师傅选择代理
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    switch (serviceChoice) {
            /** 服务师傅选择 */
        case ServiceMasterChoiceBtnAction:{
            // 更换当前服务师傅
            self.serviceMasterModel = [choiceArray objectAtIndex:indexPath.row];
            /** 服务师傅，界面赋值 */
            self.userCardRechargeView.serviceMasterView.describeLabel.text = self.serviceMasterModel.user_name;
            break;
        }
            /** 支付方式选择 */
        case PayMethodChoiceBtnAction:{
            self.payMethodModel = [choiceArray objectAtIndex:indexPath.row];
            switch (self.payMethodModel.pay_method_id) {
                case 1: { // 支付宝支付
                    // 确认支付
                    [self selectPaymentMethodIsCashPay:NO];
                    break;
                }
                case 2: { // 微信支付
                    // 确认支付
                    [self selectPaymentMethodIsCashPay:NO];
                    break;
                }
                case 6: { // 现金支付
                    [AlertAction determineStayLeft:self title:@"现金支付" message:@"请确认您已收到用户的现金/刷卡支付" determineBlock:^{
                        // 确认支付
                        [self selectPaymentMethodIsCashPay:YES];
                    }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }

    
    
}

#pragma mark - 界面赋值
- (void)userCardRechargeAssignment {
    /** 卡号 */
    self.userCardRechargeView.recCardNum.describeLabel.text = self.userCard.card_no;
    // 判断是次卡还是储值卡
    if (self.userCard.card_category_id == 1) { // 次卡
        self.userCardRechargeView.recNoreThan.cellLabel.text = @"余次";
        /** 余次 */
        self.userCardRechargeView.recNoreThan.describeLabel.text = [NSString stringWithFormat:@"%ld次", (long)self.userCard.num];
        // 充值余次
        self.userCardRechargeView.recNoreThanRecharge.viceTextFiled.placeholder = @"请输入充值次数";
        self.userCardRechargeView.recNoreThanRecharge.cellLabel.text = @"充值次数";
    }else if (self.userCard.card_category_id == 2) { // 金额卡
        self.userCardRechargeView.recNoreThan.cellLabel.text = @"余额";
        /** 余额 */
        self.userCardRechargeView.recNoreThan.describeLabel.text = [NSString stringWithFormat:@"%.2f元", self.userCard.money];
        // 充值余额
        self.userCardRechargeView.recNoreThanRecharge.viceTextFiled.placeholder = @"请输入充值余额";
        self.userCardRechargeView.recNoreThanRecharge.cellLabel.text = @"充值余额";
        self.userCardRechargeView.recNoreThanRecharge.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    /** 手机号 */
    self.userCardRechargeView.recUserPhone.describeLabel.text = self.userCard.mobile;
    /** 服务师傅，界面赋值 */
    self.userCardRechargeView.serviceMasterView.describeLabel.text = self.serviceMasterModel.user_name;
}
#pragma mark - 布局nav
- (void)userCardRechargeLayoutNAV {
    self.navigationItem.title = @"会员卡充值";
//    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(userCardRechargeNavBarLeftBtnAction)];
//    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(userCardRechargeNavBarRightBtnAction)];
}
#pragma mark - 布局视图
- (void)userCardRechargeLayoutView {
    @weakify(self)
    /** 会员卡充值View */
    self.userCardRechargeView = [[UserCardRechargeView alloc] init];
    /** 服务师傅 */
    [self.userCardRechargeView.serviceMasterView.usedCellBtn addTarget:self action:@selector(serviceMasterBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 确认充值 */
    [self.userCardRechargeView.confirmRechargeBtn addTarget:self action:@selector(confirmRechargeBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.userCardRechargeView];
    [self.userCardRechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    // 保存默认服务师傅
    self.serviceMasterModel = self.merchantInfo;
}



#pragma mark - 封装方法
// 选中支付方式支付
- (void)selectPaymentMethodIsCashPay:(BOOL)isCashPay {
    // 编辑信息
    // 判断是次卡还是储值卡
    NSString *data = [[NSString alloc] init];
    if (self.userCard.card_category_id == 1) { // 次卡
        data = [NSString stringWithFormat:@"num=%@,money=0", self.userCardRechargeView.recNoreThanRecharge.viceTextFiled.text];
    }else if (self.userCard.card_category_id == 2) { // 金额卡
        data = [NSString stringWithFormat:@"num=0,money=%@", self.userCardRechargeView.recNoreThanRecharge.viceTextFiled.text];
    }
    /*/index.php?c=provider_user_card&a=edit&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登陆者id
     sale_user_id 	int 	是 	销售者id
     provider_user_card_id 	int 	是 	用户卡id
     data 	string 	是 	编辑的信息 格式： 数据库字段名=值, 数据库字段名1=值1(对应数据库字段名见备注)
     price 	string 	否 	实收金额(充值时必传)   
     pay_method_id 	int 	否 	充值时必传,1-支付宝 2-微信 6-现金    */
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    parame[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    parame[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id
    parame[@"sale_user_id"] = self.serviceMasterModel.staff_user_id; // 销售者id
    parame[@"provider_user_card_id"] = self.userCard.provider_user_card_id; // 用户卡id
    parame[@"data"] = data; // 编辑的信息
    parame[@"price"] = self.userCardRechargeView.netReceiptsMoney.viceTextFiled.text; // 实收金额
    parame[@"pay_method_id"] = [NSString stringWithFormat:@"%ld", self.payMethodModel.pay_method_id]; // 充值方式
    [EditUserCardNetwork preservedEditUserCardParame:parame isCashPay:isCashPay success:^(NSMutableDictionary *thirdPartyDic) {
        // 判断支付方式
        switch (self.payMethodModel.pay_method_id) {
            case 1: { // 支付宝支付
                PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                qr.paySuccessVCSource = CashierPaySuccessVCSource;
                qr.payQRCodePageType = RechargeUseVCPageType;
                qr.navTitle = @"支付宝支付";
                // 添加支付金额
                [thirdPartyDic setObject:self.userCardRechargeView.netReceiptsMoney.viceTextFiled.text forKey:@"price_money"];
                qr.payParams = thirdPartyDic;
                [self.navigationController pushViewController:qr animated:YES];
                break;
            }
            case 2: { // 微信支付
                PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                qr.paySuccessVCSource = CashierPaySuccessVCSource;
                qr.payQRCodePageType = RechargeUseVCPageType;
                qr.navTitle = @"微信支付";
                // 添加支付金额
                [thirdPartyDic setObject:self.userCardRechargeView.netReceiptsMoney.viceTextFiled.text forKey:@"price_money"];
                qr.payParams = thirdPartyDic;
                [self.navigationController pushViewController:qr animated:YES];
                break;
            }
            case 6: { // 现金支付
                OpenCardSuccessViewController *openCardSuccessVC = [[OpenCardSuccessViewController alloc] init];
                openCardSuccessVC.openCardSuccessType = RechargeUseType;
                [self.navigationController pushViewController:openCardSuccessVC animated:YES];
                break;
            }
            default:
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
