//
//  CustomOpenCardViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CustomOpenCardViewController.h"
// view
#import "CustomOpenCardView.h"
#import "CashierServiceChoiceView.h"
// 下级控制器
#import "SelectPremiumViewController.h"
#import "CardCategoryViewController.h"
#import "CardApplyViewController.h"
#import "SearchUserViewController.h"
#import "CardTypeChoiceViewController.h"
#import "PhotographViewController.h"
#import "UserConflictViewController.h"
#import "PayQRCodeViewController.h"
#import "OpenCardSuccessViewController.h"
// 模型
#import "ServiceMasterHandle.h"
#import "CustomOpenCardNetwork.h"
#import "AllGoodsHandle.h"

@interface CustomOpenCardViewController ()<CashierServiceChoiceDelegate, UITextFieldDelegate>

/** 自定义开卡view */
@property (strong, nonatomic) CustomOpenCardView *customOpenCardView;
/** 当前展示的会员卡类别 */
@property (strong, nonatomic) CardCategoryModel *defaultCardType;
/** 会员卡类别数据 */
@property (strong, nonatomic) NSMutableArray *cardCategoryArray;

/** 适用范围ID */
@property (copy, nonatomic) NSString *applyID;
/** 选中的商品 */
@property (strong, nonatomic) NSMutableArray *chooseCommodityArray;
/** 选中的服务 */
@property (strong, nonatomic) NSMutableArray *chooseServiceArray;
/** 全部服务商品 */
@property (strong, nonatomic) NSMutableArray *wholeCommodityArray;

/** 服务师傅 */
@property (strong, nonatomic) MerchantInfoModel *serviceMasterModel;

/** 选择的会员卡 */
@property (strong, nonatomic) CardTypeModel *choiceCardModel;

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

@implementation CustomOpenCardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self customOpenCardLayoutView];
    // 布局nav
    [self customOpenCardLayoutNAV];
    // 界面赋值
    [self customOpenCardAssignment];
    // 获取会员卡类型
    [self requestCardType];
}
#pragma mark - 网络请求
// 获取会员卡类型
- (void)requestCardType {
    CardCategoryDataSource *cardCategory = [[CardCategoryDataSource alloc] init];
    [cardCategory requestCardTypeData];
    self.cardCategoryArray = cardCategory.rowArray;
    // 获取默认展示会员卡类型
    self.defaultCardType = [self.cardCategoryArray firstObject];
    // 界面赋值
    [self customOpenCardAssignment];
}
// 选择支付方式，确认开卡
- (void)choicePayModeConfirmOpenCardIsCashPay:(BOOL)isCashPay {
    /*/index.php?c=provider_card&a=custom_allocate&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     sale_user_id 	int 	是 	服务者id
     mobile 	string 	是 	用户手机号
     car_plate_no 	string 	否 	用户车牌号
     card_name 	string 	是 	卡名称
     card_category_id 	int 	是 	卡类型
     rules 	string 	否 	适用的服务, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)
     card_value 	string 	是 	卡面值（可以为次数、储值数或年数）
     sale_price 	string 	是 	销售价
     donate 	string 	否 	赠送次数或余额
     donate_service 	string 	否 	赠送的服务,格式： 商品id=赠送次数 eg:1=10(1.0.4新增) 
     pay_method_id 	int 	否 	支付方式:1-支付宝 2-微信 6-现金   
     user_name  用户名  */
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    parame[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    parame[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
    parame[@"sale_user_id"] = self.serviceMasterModel.staff_user_id; // 服务者id
    parame[@"mobile"] = self.customOpenCardView.phoneView.viceTextFiled.text; // 用户手机号
    parame[@"car_plate_no"] = self.customOpenCardView.plnView.viceTextFiled.text; // 用户车牌号
    parame[@"card_name"] = self.customOpenCardView.cardNameView.viceTextFiled.text; // 卡名称
    parame[@"card_category_id"] = [NSString stringWithFormat:@"%ld", self.defaultCardType.card_category_id]; // 卡类型
    parame[@"rules"] = self.applyID; // 适用的服务
    parame[@"card_value"] = self.customOpenCardView.numView.viceTextFiled.text; // 卡面值
    parame[@"sale_price"] = self.customOpenCardView.priceView.viceTextFiled.text; // 销售价
    parame[@"donate"] = self.premiumNumMon; // 赠送次数或余额
    parame[@"donate_service"] = self.premiumID; // 赠送次数或余额
    parame[@"pay_method_id"] = [NSString stringWithFormat:@"%ld", (long)self.payModeModel.pay_method_id]; // 支付方式
    parame[@"user_name"] = [self.customOpenCardView.userNameView.viceTextFiled.text isEqualToString:@"无姓名"] ? @"" : self.customOpenCardView.userNameView.viceTextFiled.text; // 用户名
    [CustomOpenCardNetwork customOpenCardParame:parame isCashPay:isCashPay success:^(NSMutableDictionary *successDic) {
        // 判断支付方式
        switch (self.payModeModel.pay_method_id) {
            case 1: { // 支付宝支付
                PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                qr.paySuccessVCSource = CashierPaySuccessVCSource;
                qr.payQRCodePageType = OpenCardUseVCPageType;
                qr.navTitle = @"支付宝支付";
                // 添加支付金额
                [successDic setObject:self.customOpenCardView.priceView.viceTextFiled.text forKey:@"price_money"];
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
                [successDic setObject:self.customOpenCardView.priceView.viceTextFiled.text forKey:@"price_money"];
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
#pragma mark - 自定义开卡功能选择按钮
- (void)customOpenCardBtnAvtion:(UIButton *)button {
        // 回收键盘
        [self.customOpenCardView endEditing:YES];
    switch (button.tag) {
            /** 手机号 */
        case PhoneBtnAction: {
            SearchUserViewController *searchUserVC = [[SearchUserViewController alloc] init];
            searchUserVC.ChoiceUserBlock = ^(UserModel *userModel) {
                // 保存当前选中的用户模型
                self.userModel = userModel;
                // 手机号
                self.customOpenCardView.phoneView.viceTextFiled.text = userModel.mobile;
                // 车牌号
                self.customOpenCardView.plnView.viceTextFiled.text = userModel.car_plate_no;
                // 用户名
                self.customOpenCardView.userNameView.viceTextFiled.text = userModel.name;
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
                self.customOpenCardView.plnView.viceTextFiled.text = plnPhoto[@"车牌号"];
                // 判断手机号输入框是否有手机号，如果没有，请求用户信息
                if (![CustomObject checkTel:self.customOpenCardView.phoneView.viceTextFiled.text] && [CustomObject isPlnNumber:self.customOpenCardView.plnView.viceTextFiled.text]) { // 手机号输入框有手机号，车牌号输入框有车牌号
                    // 使用输入车牌号，请求手机号
                    /*/index.php?c=provider_user&a=user_info&v=1
                     provider_id 	int 	是 	服务商id
                     user_input 	string 	否 	用户输入的值      */
                    // 网络请求参数
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
                    params[@"user_input"] = self.customOpenCardView.plnView.viceTextFiled.text; // 用户输入的值
                    [UserModel requestUserPhoneAndPln:params success:^(UserModel *userInfo) {
                        // 手机号
                        self.customOpenCardView.phoneView.viceTextFiled.text = userInfo.mobile;
                        // 用户名
                        self.customOpenCardView.userNameView.viceTextFiled.text = userInfo.name;
                    }];
                }
            };
            [self.navigationController pushViewController:photographVC animated:YES];
            break;
        }
            /** 卡名称 */
        case CardNameBtnAction: {
            CardTypeChoiceViewController *cardTypeChoiceVC = [[CardTypeChoiceViewController alloc] init];
            cardTypeChoiceVC.cardInfoModel = self.choiceCardModel;
            cardTypeChoiceVC.CardTypeChoiceBlock = ^(CardTypeModel *choiceCardModel) {
                // 保存当前选择的卡
                self.choiceCardModel = choiceCardModel;
                /** 卡类型view */
                // 判断是否有选中卡
                if (self.choiceCardModel) {
                    // 如果有选中卡，就遍历卡类型，获取当前卡类型
                    for (CardCategoryModel *cardCategoryModel in self.cardCategoryArray) {
                        if (cardCategoryModel.card_category_id == choiceCardModel.card_category_id) {
                            // 获取默认展示会员卡类型
                            self.defaultCardType = cardCategoryModel;
                            // 界面赋值
                            [self customOpenCardAssignment];
                        }
                    }
                    // 获取会员卡对应服务和商品名称
                    [self obtainCradAppropriateServiceAddGoodsName];
                }else { // 没有选择会员卡
                    // 取消会员卡选择界面赋值
                    [self cancelCardChioceAssignment];
                }
            };
            [self.navigationController pushViewController:cardTypeChoiceVC animated:NO];
            break;
        }
            /** 卡类型 */
        case CardTypeBtnAction: {
            CardCategoryViewController *cardCategoryVC = [[CardCategoryViewController alloc] init];
            cardCategoryVC.cardCategoryType = NOChangeCardCategoryAssignment;
            cardCategoryVC.cardCategoryArray = self.cardCategoryArray;
            cardCategoryVC.cardCategoryName = self.defaultCardType.name;
            cardCategoryVC.CardTypeChioceBlock = ^(CardCategoryModel *cardCategoryModel) {
                // 获取默认展示会员卡类型
                self.defaultCardType = cardCategoryModel;
                // 界面赋值
                [self customOpenCardAssignment];
            };
            [self.navigationController pushViewController:cardCategoryVC animated:YES];
            break;
        }
            /** 可用服务 */
        case UsableServiceBtnAction: {
            CardApplyViewController *cardApplyVC = [[CardApplyViewController alloc] init];
            cardApplyVC.cardApplyUseType = CustomOpenCardChangeCardInfoUseType;
            /** 选中的商品 */
            cardApplyVC.chooseCommodityArray = self.chooseCommodityArray;
            /** 选中的服务 */
            cardApplyVC.chooseServiceArray = self.chooseServiceArray;
            /** 全部服务商品 */
            cardApplyVC.wholeCommodityArray = self.wholeCommodityArray;
            cardApplyVC.confirmApply = ^(NSMutableArray *wholeCommodityArray, NSMutableArray *chooseCommodityArray, NSMutableArray *chooseServiceArray) {
                // 保存选中的商品
                self.chooseCommodityArray = chooseCommodityArray;
                // 保存选中的服务
                self.chooseServiceArray = chooseServiceArray;
                /** 全部服务商品 */
                self.wholeCommodityArray = wholeCommodityArray;
                // 保存选中的商品，保存选中的服务为空时
                if (self.chooseCommodityArray.count == 0 && self.chooseServiceArray.count == 0) {
                    self.applyID = @"";
                    self.customOpenCardView.usableServiceLabel.text = @"全部服务";
                }else {
                    // 初始化两个字符串
                    NSString *apply = [[NSString alloc] init];
                    self.applyID = [[NSString alloc] init];
                    for (ServiceProviderModel *service  in chooseServiceArray) {
                        apply = [apply stringByAppendingFormat:@"%@,", service.name];
                        self.applyID = [self.applyID stringByAppendingFormat:@"goods_category_id=%ld,", (long)service.goods_category_id];
                    }
                    for (CommodityShowStyleModel *commodity in chooseCommodityArray) {
                        apply = [apply stringByAppendingFormat:@"%@,", commodity.name];
                        self.applyID = [self.applyID stringByAppendingFormat:@"goods_id=%ld,", (long)commodity.goods_id];
                    }
                    apply = [apply substringToIndex:[apply length]-1];
                    self.applyID = [self.applyID substringToIndex:[self.applyID length]-1];
                    self.customOpenCardView.usableServiceLabel.text = apply;
                }
            };
            [self.navigationController pushViewController:cardApplyVC animated:YES];
            break;
        }
            /** 赠品 */
        case PremiumBtnAction: {
            SelectPremiumViewController *selectPremiumVC = [[SelectPremiumViewController alloc] init];
            selectPremiumVC.cardCategoryID = self.defaultCardType.card_category_id;
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
                    self.customOpenCardView.premiumContentLabel.text = premiumName;
                    self.customOpenCardView.premiumContentLabel.textColor = Black;
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
            if (self.customOpenCardView.phoneView.viceTextFiled.text.length == 0) {
                [MBProgressHUD showError:@"手机号不能为空"];
                return;
            }
            // 卡名称不能为空
            if (self.customOpenCardView.cardNameView.viceTextFiled.text.length == 0) {
                [MBProgressHUD showError:@"卡名称不能为空"];
                return;
            }
            // 判断余额／余次／年数不能为空
            if ([self.customOpenCardView.numView.viceTextFiled.text doubleValue] == 0) {
                [MBProgressHUD showError:[NSString stringWithFormat:@"%@不能为0", self.customOpenCardView.numView.cellLabel.text]];
                return;
            }
            // 判断售价不能为空
            if ([self.customOpenCardView.priceView.viceTextFiled.text doubleValue] == 0) {
                [MBProgressHUD showError:@"售价不能为0"];
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
            self.customOpenCardView.salespersonView.describeLabel.text = self.serviceMasterModel.user_name;
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
        if ([textField isEqual:self.customOpenCardView.plnView.viceTextFiled] && ![CustomObject checkTel:self.customOpenCardView.phoneView.viceTextFiled.text] && [CustomObject isPlnNumber:tfText]) { // 车牌号输入框，且手机号输入框没有手机号，且车牌号输入框，输入内容为车牌号
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
                self.customOpenCardView.phoneView.viceTextFiled.text = userInfo.mobile;
                // 用户名
                self.customOpenCardView.userNameView.viceTextFiled.text = userInfo.name;
            }];
        }else if ([textField isEqual:self.customOpenCardView.phoneView.viceTextFiled] && [CustomObject checkTel:tfText] && ![CustomObject isPlnNumber:self.customOpenCardView.plnView.viceTextFiled.text]) { // 手机号输入框，且手机号输入框有手机号，且车牌号输入框没有车牌号
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
                self.customOpenCardView.plnView.viceTextFiled.text = userInfo.car_plate_no;
                // 用户名
                self.customOpenCardView.userNameView.viceTextFiled.text = userInfo.name;
            }];
        }
    }
    return YES;
}

#pragma mark - 界面赋值
- (void)customOpenCardAssignment {
    /** 卡类型view */
    self.customOpenCardView.cardTypeView.describeLabel.text = self.defaultCardType.name;
    /** 卡类型 */
    switch (self.defaultCardType.card_category_id) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            self.customOpenCardView.numView.viceTextFiled.placeholder = @"请输入卡的初始次数";
            self.customOpenCardView.numView.cellLabel.text = @"次数";
            // 判断如果此时有选中卡，就对响应输入框赋值
            if (self.choiceCardModel) {
                // 卡次数
                self.customOpenCardView.numView.viceTextFiled.text = [NSString stringWithFormat:@"%ld", self.choiceCardModel.available_num];
                // 卡名称
                self.customOpenCardView.cardNameView.viceTextFiled.text = self.choiceCardModel.name;
                // 售价
                self.customOpenCardView.priceView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.choiceCardModel.sale_price];
            }else {
                // 卡次数
                self.customOpenCardView.numView.viceTextFiled.text = nil;
            }
            break;
        }
        case 2: {
            // 卡余额
            self.customOpenCardView.numView.viceTextFiled.placeholder = @"请输入卡的初始余额";
            self.customOpenCardView.numView.cellLabel.text = @"余额";
            self.customOpenCardView.numView.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            // 判断如果此时有选中卡，就对响应输入框赋值
            if (self.choiceCardModel) {
                // 卡余额
                self.customOpenCardView.numView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.choiceCardModel.face_money];
                // 卡名称
                self.customOpenCardView.cardNameView.viceTextFiled.text = self.choiceCardModel.name;
                // 售价
                self.customOpenCardView.priceView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.choiceCardModel.sale_price];
            }else {
                // 卡余额
                self.customOpenCardView.numView.viceTextFiled.text = nil;
            }
            break;
        }
        case 3: {
            self.customOpenCardView.numView.viceTextFiled.placeholder = @"请输入卡可使用年限，如1、2";
            self.customOpenCardView.numView.cellLabel.text = @"年数";
            // 判断如果此时有选中卡，就对响应输入框赋值
            if (self.choiceCardModel) {
                // 年数
                self.customOpenCardView.numView.viceTextFiled.text = [NSString stringWithFormat:@"%ld", self.choiceCardModel.available_year];;
                // 卡名称
                self.customOpenCardView.cardNameView.viceTextFiled.text = self.choiceCardModel.name;
                // 售价
                self.customOpenCardView.priceView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.choiceCardModel.sale_price];
            }else {
                // 年数
                self.customOpenCardView.numView.viceTextFiled.text = nil;
            }
            break;
        }
        default:
            break;
    }
    /** 销售员view */
    self.customOpenCardView.salespersonView.describeLabel.text = self.serviceMasterModel.user_name;
    // 手机号
    self.customOpenCardView.phoneView.viceTextFiled.text = self.userModel.mobile;
    // 车牌号
    self.customOpenCardView.plnView.viceTextFiled.text = self.userModel.car_plate_no;
    // 用户名
    self.customOpenCardView.userNameView.viceTextFiled.text = self.userModel.name;
}

// 取消会员卡选择界面赋值
- (void)cancelCardChioceAssignment {
    // 卡次数
    self.customOpenCardView.numView.viceTextFiled.text = nil;
    // 售价
    self.customOpenCardView.priceView.viceTextFiled.text = nil;
    // 卡名称
    self.customOpenCardView.cardNameView.viceTextFiled.text = nil;
    /** 可用服务view */
    self.customOpenCardView.usableServiceLabel.text = @"全部服务";
}


#pragma mark - 布局nav
- (void)customOpenCardLayoutNAV {
    self.navigationItem.title = @"自定义开卡";
//    // 根据账户输入框，修改保存按钮是否可点击属性
//    RAC(self.navigationItem.rightBarButtonItem, enabled) =
//    [self.customOpenCardView.aggregationInfo map:^id(NSNumber *nameTF){
//        return@([nameTF boolValue]);
//    }];
}

#pragma mark - 布局视图
- (void)customOpenCardLayoutView {
    /** 自定义开卡view */
    self.customOpenCardView = [[CustomOpenCardView alloc] init];
    /** 手机号view */
    self.customOpenCardView.phoneView.viceTextFiled.delegate = self;
    [self.customOpenCardView.phoneView.arrowImage addTarget:self action:@selector(customOpenCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 车牌号view */
    self.customOpenCardView.plnView.viceTextFiled.delegate = self;
    [self.customOpenCardView.plnView.arrowImage addTarget:self action:@selector(customOpenCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 卡名称view */
    [self.customOpenCardView.cardNameView.arrowImage addTarget:self action:@selector(customOpenCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 卡类型view */
    [self.customOpenCardView.cardTypeView.usedCellBtn addTarget:self action:@selector(customOpenCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 可用服务view */
    [self.customOpenCardView.usableServiceBtn addTarget:self action:@selector(customOpenCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 赠品view */
    [self.customOpenCardView.premiumBtn addTarget:self action:@selector(customOpenCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 销售员view */
    [self.customOpenCardView.salespersonView.usedCellBtn addTarget:self action:@selector(customOpenCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 确认开卡 */
    [self.customOpenCardView.confirOpenCardBtn addTarget:self action:@selector(customOpenCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customOpenCardView];
    @weakify(self)
    [self.customOpenCardView mas_makeConstraints:^(MASConstraintMaker *make) {
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
// 获取会员卡对应服务和商品名称
- (void)obtainCradAppropriateServiceAddGoodsName {
    // 初始化服务数组
    self.chooseServiceArray = [[NSMutableArray alloc] init];
    // 初始化商品数组
    self.chooseCommodityArray = [[NSMutableArray alloc] init];
    /** 所有服务及商品 */
    [AllGoodsHandle sharedInstance].requestSuccessBlock = ^ (NSMutableArray *allGoodsArray) {
        // 判断卡可用服务ID是否为空
        if (self.choiceCardModel.all_service.goods_category_id.count == 0 && self.choiceCardModel.all_service.goods_id.count == 0) {
            self.applyID = @"";
            self.customOpenCardView.usableServiceLabel.text = @"全部服务";
        }else {
            // 初始化两个字符串
            NSString *apply = [[NSString alloc] init];
            self.applyID = [[NSString alloc] init];
            // 遍历该卡对应的服务商品，拼接适用范围ID
            for (ServiceProviderModel *serviceModel in allGoodsArray) {
                // 遍历保存的服务ID
                for (NSString *serviceID  in self.choiceCardModel.all_service.goods_category_id) {
                    if ([serviceID integerValue] == serviceModel.goods_category_id) {
                        /** 选中标记 */
                        serviceModel.checkMark = YES;
                        // 保存选中服务
                        [self.chooseServiceArray addObject:serviceModel];
                        // 拼接适用服务字段
                        apply = [apply stringByAppendingFormat:@"%@,", serviceModel.name];
                        self.applyID = [self.applyID stringByAppendingFormat:@"goods_category_id=%ld,", (long)serviceModel.goods_category_id];
                    }
                }
                for (CommodityShowStyleModel *goodsModel in serviceModel.goods) {
                    for (NSString *goodsID in self.choiceCardModel.all_service.goods_id) {
                        // 判断是否包含本服务
                        if ([goodsID integerValue] == goodsModel.goods_id) {
                            /** 选中标记 */
                            goodsModel.checkMark = YES;
                            // 保存选中商品
                            [self.chooseCommodityArray addObject:goodsModel];
                            // 拼接适用服务字段
                            apply = [apply stringByAppendingFormat:@"%@,", goodsModel.name];
                            self.applyID = [self.applyID stringByAppendingFormat:@"goods_id=%ld,", (long)goodsModel.goods_id];
                        }
                    }
                }
            }
            // 保护，避免因为字符串为空，崩溃
            if (apply.length != 0) {
                apply = [apply substringToIndex:[apply length]-1];
                self.applyID = [self.applyID substringToIndex:[self.applyID length]-1];
                self.customOpenCardView.usableServiceLabel.text = apply;
            }
        }
        // 初始化全部服务商品
        self.wholeCommodityArray = allGoodsArray;
    };
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
