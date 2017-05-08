//
//  OpenCardViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OpenCardViewController.h"
// view
#import "OpenCardView.h"
#import "CashierServiceChoiceView.h"
// 下级控制器
#import "SearchUserViewController.h"
#import "PhotographViewController.h"
#import "SelectPremiumViewController.h"
#import "PhotographViewController.h"
#import "UserConflictViewController.h"
#import "PayQRCodeViewController.h"
#import "OpenCardSuccessViewController.h"
// 模型
#import "ServiceMasterHandle.h"
#import "OpenCardNetwork.h"

@interface OpenCardViewController ()<CashierServiceChoiceDelegate, UITextFieldDelegate>

/** 开卡view */
@property (strong, nonatomic) OpenCardView *openCardView;
/** 服务师傅 */
@property (strong, nonatomic) MerchantInfoModel *serviceMasterModel;
/** 赠送次数／赠送金额 */
@property (copy, nonatomic) NSString *premiumNumMon;
/** 赠品ID */
@property (copy, nonatomic) NSString *premiumID;
/** 之前保存的赠品 */
@property (strong, nonatomic) NSMutableArray *keepsGoodsArray;
/** 之前保存的服务 */
@property (strong, nonatomic) NSMutableArray *currentServiceArray;
/** 选择的支付方式 */
@property (strong, nonatomic) PaymentMethodModel *payModeModel;

@end

@implementation OpenCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self openCardLayoutNAV];
    // 布局视图
    [self openCardLayoutView];
    // 界面赋值
    [self openCardAssignment];
}

#pragma mark - 网络请求
// 选择支付方式，确认开卡
- (void)choicePayModeConfirmOpenCardIsCashPay:(BOOL)isCashPay {
    /*/index.php?c=provider_card&a=allocate&v=1
     provider_card_id 	int 	是 	服务商卡id
     staff_user_id 	int 	是 	登录者id
     sale_user_id 		是 	销售者id
     provider_id 	int 	是 	服务商id
     mobile 	string 	是 	用户手机号
     car_plate_no 	string 	否 	车牌号
     donate 	string 	否 	赠送次数或余额
     donate_service 	string 	否 	赠送的服务,格式： 商品id=赠送次数 eg:1=10(1.0.4新增)
     sale_price 	float 	否 	开卡售价(1.0.4版本新增)  
     pay_method_id 	int 	否 	支付方式:1-支付宝 2-微信 6-现金 
     user_name  用户名  */
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    parame[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", (long)self.cardTypeModel.provider_card_id]; // 服务商卡id
    parame[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
    parame[@"sale_user_id"] = self.serviceMasterModel.staff_user_id; // 服务者id
    parame[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    parame[@"mobile"] = self.openCardView.phoneView.viceTextFiled.text; // 用户手机号
    parame[@"car_plate_no"] = self.openCardView.plnView.viceTextFiled.text; // 用户车牌号
    parame[@"donate"] = self.premiumNumMon; // 赠送次数或余额
    parame[@"donate_service"] = self.premiumID; // 赠送次数或余额
    parame[@"sale_price"] = self.openCardView.priceView.viceTextFiled.text; // 开卡售价
    parame[@"pay_method_id"] = [NSString stringWithFormat:@"%ld", (long)self.payModeModel.pay_method_id]; // 支付方式
    parame[@"user_name"] = [self.openCardView.userNameView.viceTextFiled.text isEqualToString:@"无姓名"] ? @"" : self.openCardView.userNameView.viceTextFiled.text; // 用户名
    [OpenCardNetwork openCardParame:parame isCashPay:isCashPay success:^(NSMutableDictionary *successDic) {
        // 判断支付方式
        switch (self.payModeModel.pay_method_id) {
            case 1: { // 支付宝支付
                PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                qr.paySuccessVCSource = CashierPaySuccessVCSource;
                qr.payQRCodePageType = OpenCardUseVCPageType;
                qr.navTitle = @"支付宝支付";
                // 添加支付金额
                [successDic setObject:self.openCardView.priceView.viceTextFiled.text forKey:@"price_money"];
                qr.payParams = successDic;
                [self.navigationController pushViewController:qr animated:YES];
                break;
            }
            case 2: { // 微信支付
                PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                qr.paySuccessVCSource = CashierPaySuccessVCSource;
                qr.payQRCodePageType = OpenCardUseVCPageType;
                qr.navTitle = @"微信支付";
                // 添加支付金额
                [successDic setObject:self.openCardView.priceView.viceTextFiled.text forKey:@"price_money"];
                qr.payParams = successDic;
                [self.navigationController pushViewController:qr animated:YES];
                break;
            }
            case 6: { // 现金支付
                OpenCardSuccessViewController *openCardSuccessVC = [[OpenCardSuccessViewController alloc] init];
                openCardSuccessVC.openCardSuccessType = OpenCardUseType;
                [self.navigationController pushViewController:openCardSuccessVC animated:YES];
                break;
            }
            default:
                break;
        }
    } conflict:^(OpneUserConflictModel *userConflict) {
        [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"您输入的车牌号和手机号是两个用户，\n无法开卡是否编辑用户信息！" admitBlock:nil noadmitBlock:^{
            UserConflictViewController *userConflictVC = [[UserConflictViewController alloc] init];
            userConflictVC.provider_user_id = userConflict.provider_user_id;
            [self.navigationController pushViewController:userConflictVC animated:YES];
        }];
    }];
}


#pragma mark - 按钮点击方法

#pragma mark - 开卡功能选择按钮
- (void)openCardBtnAvtion:(UIButton *)button {
    // 回收键盘
    [self.openCardView endEditing:YES];
    switch (button.tag) {
            /** 手机号 */
        case PhoneBtnAction: {
            SearchUserViewController *searchUserVC = [[SearchUserViewController alloc] init];
            searchUserVC.ChoiceUserBlock = ^(UserModel *userModel) {
                // 手机号
                self.openCardView.phoneView.viceTextFiled.text = userModel.mobile;
                // 车牌号
                self.openCardView.plnView.viceTextFiled.text = userModel.car_plate_no;
                // 用户名
                self.openCardView.userNameView.viceTextFiled.text = userModel.name;
            };
            [self.navigationController pushViewController:searchUserVC animated:NO];
            break;
        }
            /** 车牌号 */
        case PlnBtnAction: {
            PhotographViewController *photographVC = [[PhotographViewController alloc] init];
            photographVC.photographViewType = CustomOpenCardAssignment;
            photographVC.DistinguishSuccessBlock = ^(NSMutableDictionary *plnPhoto) {
                // 车牌号
                self.openCardView.plnView.viceTextFiled.text = plnPhoto[@"车牌号"];
                // 判断手机号输入框是否有手机号，如果没有，请求用户信息
                if (![CustomObject checkTel:self.openCardView.phoneView.viceTextFiled.text] && [CustomObject isPlnNumber:self.openCardView.plnView.viceTextFiled.text]) { // 手机号输入框有手机号，车牌号输入框有车牌号
                    // 使用输入车牌号，请求手机号
                    /*/index.php?c=provider_user&a=user_info&v=1
                     provider_id 	int 	是 	服务商id
                     user_input 	string 	否 	用户输入的值      */
                    // 网络请求参数
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
                    params[@"user_input"] = self.openCardView.plnView.viceTextFiled.text; // 用户输入的值
                    [UserModel requestUserPhoneAndPln:params success:^(UserModel *userInfo) {
                        // 车牌号
                        self.openCardView.phoneView.viceTextFiled.text = userInfo.mobile;
                        // 用户名
                        self.openCardView.userNameView.viceTextFiled.text = userInfo.name;
                    }];
                }
            };
            [self.navigationController pushViewController:photographVC animated:YES];
            break;
        }
            /** 赠品 */
        case PremiumBtnAction: {
            SelectPremiumViewController *selectPremiumVC = [[SelectPremiumViewController alloc] init];
            selectPremiumVC.cardCategoryID = self.cardTypeModel.card_category_id;
            selectPremiumVC.keepsGoodsArray = self.keepsGoodsArray;
            selectPremiumVC.currentServiceArray = self.currentServiceArray;
            selectPremiumVC.premiumNumMon = self.premiumNumMon;
            selectPremiumVC.KeepsPremiumBlock = ^(NSString *premiumName, NSString *premiumID, NSString *premiumNumMon, NSMutableArray *keepsGoodsArray, NSMutableArray *currentServiceArray) {
                /** 之前保存的赠品 */
                self.keepsGoodsArray = keepsGoodsArray;
                /** 之前保存的服务 */
                self.currentServiceArray = currentServiceArray;
                /** 赠品view */
                if (premiumName.length != 0) {
                    self.openCardView.premiumContentLabel.text = premiumName;
                    self.openCardView.premiumContentLabel.textColor = Black;
                }
                /** 赠送次数／赠送金额 */
                self.premiumNumMon = premiumNumMon;
                /** 赠品ID */
                self.premiumID = premiumID;
            };
            [self.navigationController pushViewController:selectPremiumVC animated:YES];
            break;
        }
            /** 销售员 */
        case SalespersonBtnAction: {
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
            break;
        }
            /** 确认开卡 */
        case ConfirOpenCardBtnAction: {
            // 判断手机号不能为空
            if (self.openCardView.phoneView.viceTextFiled.text.length == 0) {
                [MBProgressHUD showError:@"手机号不能为空"];
                return;
            }
            // 判断售价不能为空
            if (self.openCardView.priceView.viceTextFiled.text.length == 0) {
                [MBProgressHUD showError:@"售价不能为空"];
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
            break;
        }
        default:
            break;
    }
}

// 服务师傅选择代理方法
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    switch (serviceChoice) {
            /** 服务师傅选择 */
        case ServiceMasterChoiceBtnAction:{
            // 更换当前服务师傅
            self.serviceMasterModel = [choiceArray objectAtIndex:indexPath.row];
            /** 销售员view */
            self.openCardView.salespersonView.describeLabel.text = self.serviceMasterModel.user_name;
            break;
        }
            /** 支付方式选择 */
        case PayMethodChoiceBtnAction:{
            /** 选择的支付方式 */
            self.payModeModel = [choiceArray objectAtIndex:indexPath.row];
            switch (self.payModeModel.pay_method_id) {
                case 1: { // 支付宝支付
                    // 选择支付方式，确认开卡
                    [self choicePayModeConfirmOpenCardIsCashPay:NO];
                    break;
                }
                case 2: { // 微信支付
                    // 选择支付方式，确认开卡
                    [self choicePayModeConfirmOpenCardIsCashPay:NO];
                    break;
                }
                case 6: { // 现金支付
                    [AlertAction determineStayLeft:self title:@"现金支付" message:@"请确认您已收到用户的现金/刷卡支付" determineBlock:^{
                        // 选择支付方式，确认开卡
                        [self choicePayModeConfirmOpenCardIsCashPay:YES];
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


#pragma mark - textField输入代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断是输入内容,不是删除内容
    if (string && string.length != 0) {
        // 拼接textField内容和输入内容
        NSString *tfText = [textField.text stringByAppendingString:string];
        // 判断是那个输入框
        if ([textField isEqual:self.openCardView.plnView.viceTextFiled] && ![CustomObject checkTel:self.openCardView.phoneView.viceTextFiled.text] && [CustomObject isPlnNumber:tfText]) { // 车牌号输入框，且手机号输入框没有手机号，且车牌号输入框，输入内容为车牌号
            // 使用输入车牌号，请求手机号
            /*/index.php?c=provider_user&a=user_info&v=1
             provider_id 	int 	是 	服务商id
             user_input 	string 	否 	用户输入的值      */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
            params[@"user_input"] = tfText; // 用户输入的值
            [UserModel requestUserPhoneAndPln:params success:^(UserModel *userInfo) {
                // 手机号
                self.openCardView.phoneView.viceTextFiled.text = userInfo.mobile;
                // 用户名
                self.openCardView.userNameView.viceTextFiled.text = userInfo.name;
            }];
        }else if ([textField isEqual:self.openCardView.phoneView.viceTextFiled] && [CustomObject checkTel:tfText] && ![CustomObject isPlnNumber:self.openCardView.plnView.viceTextFiled.text]) { // 手机号输入框，且手机号输入框有手机号，且车牌号输入框没有车牌号
            // 使用输入手机号，请求车牌号
            /*/index.php?c=provider_user&a=user_info&v=1
             provider_id 	int 	是 	服务商id
             user_input 	string 	否 	用户输入的值      */
            // 网络请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
            params[@"user_input"] = tfText; // 用户输入的值
            [UserModel requestUserPhoneAndPln:params success:^(UserModel *userInfo) {
                // 车牌号
                self.openCardView.plnView.viceTextFiled.text = userInfo.car_plate_no;
                // 用户名
                self.openCardView.userNameView.viceTextFiled.text = userInfo.name;
            }];
        }
    }
    return YES;
}


#pragma mark - 界面赋值
- (void)openCardAssignment  {
    /** 卡号 */
    self.openCardView.cardInfoView.cardNumLabel.text = [NSString stringWithFormat:@"%03ld", self.cardTypeModel.code];
    /** 卡名称 */
    self.openCardView.cardInfoView.cardNameLabel.text = self.cardTypeModel.name;
    /** 卡类型 */
    switch (self.cardTypeModel.card_category_id) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            self.openCardView.cardInfoView.cardTypeLabel.text = @"次卡";
            /** 可用次数 */
            self.openCardView.cardInfoView.canNumMoneyLabel.leftText.text = @"可用次数:";
            /** 可用次数 */
            self.openCardView.cardInfoView.canNumMoneyLabel.rightText.text = [NSString stringWithFormat:@"%ld次", self.cardTypeModel.available_num];
            break;
        }
        case 2: {
            self.openCardView.cardInfoView.cardTypeLabel.text = @"储值卡";
            /** 可用金额 */
            self.openCardView.cardInfoView.canNumMoneyLabel.leftText.text = @"可用金额:";
            /** 可用金额 */
            self.openCardView.cardInfoView.canNumMoneyLabel.rightText.text = [NSString stringWithFormat:@"%.2f元", self.cardTypeModel.face_money];
            break;
        }
        case 3: {
            self.openCardView.cardInfoView.cardTypeLabel.text = @"年卡";
            /** 可用次数 */
            self.openCardView.cardInfoView.canNumMoneyLabel.leftText.text = @"可用次数:";
            /** 可用次数 */
            self.openCardView.cardInfoView.canNumMoneyLabel.rightText.text = @"无限";
            break;
        }
        default:
            break;
    }
    /** 可用服务 */
    self.openCardView.cardInfoView.availableServiceLabel.text = self.cardTypeModel.used_goods_text;
    /** 原价 */
    self.openCardView.cardInfoView.costPriceLabel.rightText.text = [NSString stringWithFormat:@"%.2f元", self.cardTypeModel.price];
    /** 售价 */
    self.openCardView.priceView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.cardTypeModel.sale_price];
    /** 销售员 */
    self.openCardView.salespersonView.describeLabel.text = self.serviceMasterModel.user_name;
}


#pragma mark - 布局nav
- (void)openCardLayoutNAV {
    self.navigationItem.title = @"开卡";
}

#pragma mark - 布局视图
- (void)openCardLayoutView {
    /** 开卡view */
    self.openCardView = [[OpenCardView alloc] init];
    /** 手机号view */
    self.openCardView.phoneView.viceTextFiled.delegate = self;
    [self.openCardView.phoneView.arrowImage addTarget:self action:@selector(openCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 车牌号view */
    self.openCardView.plnView.viceTextFiled.delegate = self;
    [self.openCardView.plnView.arrowImage addTarget:self action:@selector(openCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 赠品view */
    [self.openCardView.premiumBtn addTarget:self action:@selector(openCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 销售员view */
    [self.openCardView.salespersonView.usedCellBtn addTarget:self action:@selector(openCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 确认开卡 */
    [self.openCardView.confirOpenCardBtn addTarget:self action:@selector(openCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.openCardView];
    @weakify(self)
    [self.openCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    // 保存默认服务师傅
    self.serviceMasterModel = self.merchantInfo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
