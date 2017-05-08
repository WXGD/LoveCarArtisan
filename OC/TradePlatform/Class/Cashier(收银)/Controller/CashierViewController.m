//
//  CashierViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierViewController.h"
// view
#import "CashierView.h"
#import "CashierServiceChoiceView.h"
#import "CashierPremiumView.h"
// 数据
#import "ShoppingCartModel.h"
#import "ServiceCategoryHandle.h"
#import "PaymentMethodModel.h"
#import "CashierPayNetwork.h"
#import "CashierUserModel.h"
#import "ServiceMasterHandle.h"
// 下级控制器
#import "ShoppingCartViewController.h"
#import "SearchUserViewController.h"
#import "CancellationViewController.h"
#import "UserInfoViewController.h"
#import "UserCarOptViewController.h"
#import "AffirmOrderViewController.h"
#import "AddUserViewController.h"
#import "UserConflictViewController.h"

// 1.1.0用下级控制器
#import "CardChoiceViewController.h"
#import "PayQRCodeViewController.h"
#import "PaySuccessViewController.h"

@interface CashierViewController ()<CashierViewDelegate ,AddSubBtnDelegate, CashierServiceChoiceDelegate, CashierPremiumDelegate, UITextFieldDelegate>

/** 收银view */
@property (strong, nonatomic) CashierView *cashierView;
/** 保存收银用户信息 */
@property (strong, nonatomic) CashierUserModel *cashierUserModel;
/** 服务列表数据 */
@property (strong, nonatomic) NSMutableArray *serviceListArray;
/** 商品列表数据 */
@property (strong, nonatomic) NSMutableArray *commodityListArray;
/** 默认选择服务类型 */
@property (strong, nonatomic) ServiceProviderModel *defaultService;
/** 默认选择商品类型 */
@property (strong, nonatomic) CommodityShowStyleModel *defaultCommodity;
/** 购物车商品 */
@property (strong, nonatomic) NSMutableArray *shoppingCartCommodityArray;
/** 购物车商品字典 */
@property (strong, nonatomic) NSMutableDictionary *shoppingCartGoodsDic;
/************1.1.0版本*************/
/** 支付方式数据 */
@property (strong, nonatomic) NSMutableArray *payMethodArray;
/** 选择的支付方式 */
@property (strong, nonatomic) PaymentMethodModel *payMethodModel;

@end

@implementation CashierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self cashierLayoutNAV];
    // 布局视图
    [self cashierLayoutView];
    // 请求购买方式
    [self requestPaymentMethodData];
    // 请求服务商品
    [self requestServiceProvidersDataSuccess:^{
        // 判断来源
        if (self.cashierVCSource == PendOrderCashierViewSource) { // 挂单
            // 请求服务师傅
            [self requestServiceMasterModelData];
            // 页面来源是挂单，对商品，用户信息进行赋值
            [self sourcePendOrderGoodsAssignment];
        }else {
            // 界面赋值
            [self cashierAssignment];
        }
    }];
}

#pragma mark - 网络请求
// 请求服务项目
- (void)requestServiceProvidersDataSuccess:(void(^)())success {
    /** 服务列表数据 */
    self.serviceListArray = [ServiceCategoryHandle sharedInstance].serviceCategoryArray;
    /** 默认选择服务类型 */
    self.defaultService = [self.serviceListArray firstObject];
    // 请求服务商品
    [self requestServiceCommodityDataSuccess:^{
        if (success) {
            success();
        }
    }];
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (self.serviceListArray.count == 0) {
        [ServiceCategoryHandle sharedInstance].requestCategorySuccessBlock = ^ () {
            /** 服务列表数据 */
            self.serviceListArray = [ServiceCategoryHandle sharedInstance].serviceCategoryArray;
            /** 默认选择服务类型 */
            self.defaultService = [self.serviceListArray firstObject];
            // 判断当前选中的服务类型是保养
            if (self.defaultService.goods_category_id == 6) {
                [self.cashierView.mileageView setHidden:NO];
                [self.cashierView.nextTimeView setHidden:NO];
            }else {
                [self.cashierView.mileageView setHidden:YES];
                [self.cashierView.nextTimeView setHidden:YES];
            }
            // 请求服务商品
            [self requestServiceCommodityDataSuccess:^{
                if (success) {
                    success();
                }
            }];
        };
    }
}

// 请求服务商品
- (void)requestServiceCommodityDataSuccess:(void(^)())success {
    // 请求服务商品
    /*/index.php?c=goods&a=list&v=1
     provider_id 	int 	是 	服务id
     goods_category_id 	int 	否 	商品分类id，(获取某类商品中必传)  */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
    params[@"goods_category_id"] = [NSString stringWithFormat:@"%ld", (long)self.defaultService.goods_category_id]; // 商品分类id
    // 请求商品列表
    [CommodityShowStyleModel requesCommodityListDataParams:params success:^(NSMutableArray *commodityList) {
        [MBProgressHUD hideHUD];
        /** 商品列表数据 */
        self.commodityListArray = commodityList;
        /** 默认选择商品类型 */
        self.defaultCommodity = [commodityList firstObject];
        /** 更换商品，商品信息赋值 */
        [self replaceCommodityInfoAssignment];
        if (success) {
            success();
        }
    }];
}

// 请求服务师傅
- (void)requestServiceMasterModelData {
    /** 服务师傅数据 */
    NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (serviceMasterArray.count == 0) {
        [ServiceMasterHandle sharedInstance].requestSuccessBlock = ^ () {
            /** 服务师傅列表数据 */
            NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
            // 遍历服务师傅，找到当前选中的服务师傅
            for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
                if ([serviceMasterModel.staff_user_id isEqualToString:self.serviceMasterModel.staff_user_id]) {
                    // 保存服务师傅
                    self.serviceMasterModel = serviceMasterModel;
                    /** 服务师傅 */
                    self.cashierView.serviceMasterView.viceTextFiled.text = self.serviceMasterModel.user_name;
                }
            }
        };
    }else {
        /** 服务列表数据 */
        NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
        // 遍历服务师傅，找到当前选中的服务师傅
        for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
            if ([serviceMasterModel.staff_user_id isEqualToString:self.serviceMasterModel.staff_user_id]) {
                // 保存服务师傅
                self.serviceMasterModel = serviceMasterModel;
                /** 服务师傅 */
                self.cashierView.serviceMasterView.viceTextFiled.text = self.serviceMasterModel.user_name;
            }
        }
    }
}

#pragma mark - 按钮点击方法
- (void)cashierBtnAction:(UIButton *)button {
    [self.cashierView endEditing:YES];
    switch (button.tag) {
            /** 确认收款 */
        case ConfirmationCollectionBtnAction: {
            // 判断有没有服务商品
            if (self.defaultCommodity.goods_id == 0) {
                [MBProgressHUD showError:@"请先选择商品"];
                return;
            }
            // 判断总价是否小于0
            if ([self.cashierView.totalView.viceLabel.text doubleValue] <= 0) {
                [MBProgressHUD showError:@"总价不能小于0"];
                return;
            }
            // 弹出支付方式选择
            CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            payChoiceBoxView.choiceArray = self.payMethodArray;
            payChoiceBoxView.serviceChoice = PayMethodChoiceBtnAction;
            payChoiceBoxView.delegate = self;
            [payChoiceBoxView show];
//            // 判断是否有客户
//            if (!self.cashierUserModel.user_info.provider_user_id) {
//                [MBProgressHUD showError:@"请添加购买客户"];
//                return;
//            }
//            // 判断购物车是否为空
//            if (self.shoppingCartCommodityArray.count == 0) {
//                [MBProgressHUD showError:@"请先添加商品到购物车"];
//                return;
//            }
//            // 遍历购物车数组数据，将相同商品数量累计在一起，并返回商品数据
//            NSString *goodsData = [self equalCommodityNumberCumulative];
//            AffirmOrderViewController *affirmOrderVC = [[AffirmOrderViewController alloc] init];
//            /** 收银用户信息 */
//            affirmOrderVC.cashierUserModel = self.cashierUserModel;
//            /** 服务师傅 */
//            affirmOrderVC.serviceMasterModel = self.serviceMasterModel;
//            /** 服务商品 */
//            affirmOrderVC.goodsArray = self.shoppingCartCommodityArray;
//            /** 订单总价 */
//            affirmOrderVC.orderTotal = self.shoppingCartTotal;
//            /** 商品data */
//            affirmOrderVC.goodsData = goodsData;
//            /** 行驶里程 */
//            affirmOrderVC.mileage = self.cashierView.mileageView.viceTextFiled.text;
//            /** 下一次保养时间 */
//            affirmOrderVC.nextMaintain = self.cashierView.nextTimeView.viceTextFiled.text;
//            /** 购物车记录 */
//            @property (copy, nonatomic) NSString *cartID;
//            [self.navigationController pushViewController:affirmOrderVC animated:YES];
//            // 弹出支付方式选择
//            CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
//            payChoiceBoxView.choiceArray = self.payMethodArray;
//            payChoiceBoxView.serviceChoice = PayMethodChoiceBtnAction;
//            payChoiceBoxView.delegate = self;
//            [payChoiceBoxView show];
            break;
        }
            /** 提交订单 */
        case PlaceOrderBtnAction: {
            // 1.1.0,挂单网络请求
            [self placeOrderNetwork];
//            // 判断购物车是否为空
//            if (self.shoppingCartCommodityArray.count == 0) {
//                [MBProgressHUD showError:@"请先添加商品到购物车"];
//                return;
//            }
//            // 遍历购物车数组数据，将相同商品数量累计在一起，并返回商品数据
//            NSString *goodsData = [self equalCommodityNumberCumulative];
//            /** /index.php?c=cart&a=add&v=1
//             provider_id 	int 	是 	服务商id
//             staff_user_id 	int 	是 	登录者id
//             sale_user_id 	int 	是 	服务师傅
//             mobile 	string 	是 	手机号
//             car_plate_no 	string 	是 	车牌号
//             goods_data 	string 	是 	商品数据,格式： 服务类别id_商品id_购买数量_售价， 多个商品用逗号分割
//             total_price 	float 	是 	总价
//             mileage 	float 	否 	行驶里程
//             next_maintain 	string 	否 	下一次保养时间,  */
//            // 网络请求参数
//            NSMutableDictionary *params = [NSMutableDictionary dictionary];
//            params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
//            params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
//            params[@"sale_user_id"] = self.serviceMasterModel.staff_user_id; // 服务师傅
//            params[@"mobile"] = self.cashierView.phoneTF.text; // 手机号
//            params[@"car_plate_no"] = self.cashierView.plnTF.text; // 车牌号
//            params[@"total_price"] = [NSString stringWithFormat:@"%.2f", self.shoppingCartTotal]; // 总价
//            params[@"mileage"] = self.cashierView.mileageView.viceTextFiled.text; // 行驶里程
//            params[@"next_maintain"] = self.cashierView.nextTimeView.viceTextFiled.text; // 下一次保养时间
//            params[@"goods_data"] = goodsData; // 商品数据
//            [CashierPayNetwork cartAddNotCashier:params success:^{
//                
//            }];
            break;
        }
            /** 手机号 */
        case PhoneBtnAction: {
            SearchUserViewController *searchUserVC = [[SearchUserViewController alloc] init];
            searchUserVC.ChoiceUserBlock = ^(UserModel *userModel) {
                // 清空输入框
                self.cashierView.phoneTF.text = userModel.mobile;
                self.cashierView.plnTF.text = userModel.car_plate_num;
                // 判断手机号格式
                if ([CustomObject checkTel:userModel.mobile]) {
                    // 手机号
                    [self foundationTextFieldInfoRequestUserInfo:userModel.mobile textField:self.cashierView.phoneTF];
                }else if ([CustomObject isPlnNumber:userModel.car_plate_no]) {
                    // 车牌号
                    [self foundationTextFieldInfoRequestUserInfo:userModel.car_plate_num textField:self.cashierView.plnTF];
                }
            };
            [self.navigationController pushViewController:searchUserVC animated:YES];
            break;
        }
            /** 车牌号 */
        case PlnBtnAction: {
            PDLog(@"车牌号");
            UserCarOptViewController *userCarOptVC = [[UserCarOptViewController alloc] init];
            userCarOptVC.userModel = self.cashierUserModel.user_info;
            userCarOptVC.ChoiceCarBlock = ^(UserCarModel *userCarModel) {
                // 清空输入框
                self.cashierView.phoneTF.text = @"";
                self.cashierView.plnTF.text = userCarModel.car_plate_num;
                self.cashierView.caftaBtn.titleLabel.text = userCarModel.province_CAFTA;
                // 判断手机号格式
                if ([CustomObject isPlnNumber:userCarModel.car_plate_no]) {
                    // 车牌号
                    [self foundationTextFieldInfoRequestUserInfo:userCarModel.car_plate_no textField:self.cashierView.plnTF];
                }
            };
            [self.navigationController pushViewController:userCarOptVC animated:YES];
            break;
        }
            /** 用户名 */
        case UserNameBtnAction: {
            if (self.cashierUserModel.user_info.provider_user_id) {
                UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                userInfoVC.providerUserId = [NSString stringWithFormat:@"%ld", self.cashierUserModel.user_info.provider_user_id];
                [self.navigationController pushViewController:userInfoVC animated:YES];
            }
            break;
        }
            /** 类别 */
        case ClassBtnAction: {
            PDLog(@"类别");
            // 遍历所有服务，找到当前选中的服务
            for (ServiceProviderModel *service in self.serviceListArray) {
                service.checkMark = NO;
                if (service.goods_category_id == self.defaultService.goods_category_id) {
                    service.checkMark = YES;
                }
            }
            // 弹出
            CashierServiceChoiceView *classChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            classChoiceBoxView.choiceArray = self.serviceListArray;
            classChoiceBoxView.serviceChoice = ServiceTypeChoiceBtnAction;
            classChoiceBoxView.delegate = self;
            [classChoiceBoxView show];
            break;
        }
            /** 服务 */
        case ServiceBtnAction: {
            PDLog(@"服务");
            if (self.commodityListArray.count == 0) {
                [MBProgressHUD showError:@"服务列表为空"];
                return;
            }
            // 遍历所有服务，找到当前选中的服务
            for (CommodityShowStyleModel *commodity in self.commodityListArray) {
                commodity.checkMark = NO;
                if (commodity.goods_id == self.defaultCommodity.goods_id) {
                    commodity.checkMark = YES;
                }
            }
            CashierServiceChoiceView *goodsChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            goodsChoiceBoxView.choiceArray = self.commodityListArray;
            goodsChoiceBoxView.serviceChoice = ServiceGoodsChoiceBtnAction;
            goodsChoiceBoxView.delegate = self;
            [goodsChoiceBoxView show];
            break;
        }
            /** 添加商品 */
        case AddGoodsBtnAction: {
            // 判断是保养商品
            if (self.defaultService.goods_category_id == 6) {
                // 判断行驶里程
                if (self.cashierView.mileageView.viceTextFiled.text.length == 0) {
                    [MBProgressHUD showError:@"请输入行驶里程"];
                    return;
                }
            }
            // 判断是否有商品
            if (self.defaultCommodity.goods_id == 0) {
                [MBProgressHUD showError:@"请选择商品"];
                return;
            }
            // 判断商品价格不能为0
            if ([self.cashierView.pretiumView.viceLabel.text doubleValue] <= 0) {
                [MBProgressHUD showError:@"销售价不能为0"];
                return;
            }
            // 判断是否有客户
            if (!self.cashierUserModel.user_info.provider_user_id) {
                [MBProgressHUD showError:@"请添加购买客户"];
                return;
            }
            // 初始化购物车商品模型
            ShoppingCartModel *shoppingCartModel = [[ShoppingCartModel alloc] init];
            // 商品分类
            shoppingCartModel.goods_category = self.defaultService;
            // 商品
            shoppingCartModel.goods = self.defaultCommodity;
            // 商品实际售价
            shoppingCartModel.goods.actual_sale_price = [self.cashierView.pretiumView.viceLabel.text doubleValue];
            // 购买数量
            shoppingCartModel.buy_num = [self.cashierView.numberOperationBtn.numTF.text integerValue];
            // 购物车商品数量
            self.cashierView.shoppingCartNum = shoppingCartModel.buy_num + self.cashierView.shoppingCartNum;
            // 添加商品到购物车商品数组
            [self.shoppingCartCommodityArray addObject:shoppingCartModel];

            break;
        }
            /** 购物车 */
        case ShoppingCartBtnAction: {
            PDLog(@"购物车");
            // 判断购物车是否为空
            if (self.shoppingCartCommodityArray.count == 0) {
                [MBProgressHUD showError:@"请先添加商品"];
                return;
            }
            // 遍历购物车数组数据，将相同商品数量累计在一起
            [self equalCommodityNumberCumulative];
            // 跳转到购物车页面
            ShoppingCartViewController *shoppingCartVC = [[ShoppingCartViewController alloc] init];
            shoppingCartVC.shoppingCartCommodityArray = self.shoppingCartCommodityArray;
            shoppingCartVC.shoppingCartNum = self.cashierView.shoppingCartNum;
            shoppingCartVC.shoppingCartTotal = self.shoppingCartTotal;
            shoppingCartVC.ShoppingCartBlock = ^(NSInteger shoppingCartNum, double shoppingCartTotal) {
                // 购物车商品数量
                self.cashierView.shoppingCartNum = shoppingCartNum;
                // 购物车商品总价
                self.shoppingCartTotal = shoppingCartTotal;
            };
            [self.navigationController pushViewController:shoppingCartVC animated:YES];
            break;
        }
            /** 服务师傅 */
        case ServiceMasterBtnAction: {
            PDLog(@"服务师傅");
            /** 服务师傅数据 */
            NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
            // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
            if (serviceMasterArray.count == 0) {
                [ServiceMasterHandle sharedInstance].requestSuccessBlock = ^ () {
                    /** 服务师傅列表数据 */
                    NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
                    // 遍历服务师傅，找到当前选中的服务师傅
                    for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
                        serviceMasterModel.checkMark = NO;
                        if ([serviceMasterModel.staff_user_id isEqualToString:self.serviceMasterModel.staff_user_id]) {
                            serviceMasterModel.checkMark = YES;
                        }
                    }
                    // 弹出服务师傅选择
                    CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
                    payChoiceBoxView.choiceArray = serviceMasterArray;
                    payChoiceBoxView.serviceChoice = ServiceMasterChoiceBtnAction;
                    payChoiceBoxView.delegate = self;
                    [payChoiceBoxView show];
                };
            }else {
                /** 服务列表数据 */
                NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
                // 遍历服务师傅，找到当前选中的服务师傅
                for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
                    serviceMasterModel.checkMark = NO;
                    if ([serviceMasterModel.staff_user_id isEqualToString:self.serviceMasterModel.staff_user_id]) {
                        serviceMasterModel.checkMark = YES;
                    }
                }
                // 弹出服务师傅选择
                CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
                payChoiceBoxView.choiceArray = serviceMasterArray;
                payChoiceBoxView.serviceChoice = ServiceMasterChoiceBtnAction;
                payChoiceBoxView.delegate = self;
                [payChoiceBoxView show];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - 服务，服务商品，服务师傅，支付方式，选择代理方法
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    switch (serviceChoice) {
            /** 服务类型选择 */
        case ServiceTypeChoiceBtnAction:{
            /** 默认选择服务类型 */
            self.defaultService = [choiceArray objectAtIndex:indexPath.row];
            // 判断当前选中的服务类型是保养
            if (self.defaultService.goods_category_id == 6) {
                [self.cashierView.mileageView setHidden:NO];
                [self.cashierView.nextTimeView setHidden:NO];
            }else {
                [self.cashierView.mileageView setHidden:YES];
                [self.cashierView.nextTimeView setHidden:YES];
            }
            // 请求服务商品
            [self requestServiceCommodityDataSuccess:nil];
            break;
        }
            /** 服务商品选择 */
        case ServiceGoodsChoiceBtnAction:{
            /** 默认选择商品类型 */
            self.defaultCommodity = [choiceArray objectAtIndex:indexPath.row];
            /** 更换商品，商品信息赋值 */
            [self replaceCommodityInfoAssignment];
            break;
        }
            /** 服务师傅选择 */
        case ServiceMasterChoiceBtnAction:{
            // 更换当前服务师傅
            self.serviceMasterModel = [choiceArray objectAtIndex:indexPath.row];
            /** 服务师傅 */
            self.cashierView.serviceMasterView.viceTextFiled.text = self.serviceMasterModel.user_name;
            break;
        }
            /** 支付方式选择 */
        case PayMethodChoiceBtnAction:{
            self.payMethodModel = [choiceArray objectAtIndex:indexPath.row];
            switch (self.payMethodModel.pay_method_id) {
                case 1: { // 支付宝支付
                    NSMutableDictionary *params = [self payNetwork];
                    [CashierPayNetwork v2CashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                        PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                        qr.paySuccessVCSource = CashierPaySuccessVCSource;
                        qr.payQRCodePageType = CashierUseVCPageType;
                        // 添加支付金额
                        [responseObject setObject:[CustomString getNumber:self.cashierView.totalView.viceLabel.text] forKey:@"price_money"];
                        qr.payParams = responseObject;
                        qr.navTitle = @"支付宝支付";
                        qr.userInfo = self.cashierUserModel.user_info;
                        [self.navigationController pushViewController:qr animated:YES];
                    }];
                    break;
                }
                case 2: { // 微信支付
                    NSMutableDictionary *params = [self payNetwork];
                    [CashierPayNetwork v2CashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                        PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                        qr.paySuccessVCSource = CashierPaySuccessVCSource;
                        qr.payQRCodePageType = CashierUseVCPageType;
                        // 添加支付金额
                        [responseObject setObject:[CustomString getNumber:self.cashierView.totalView.viceLabel.text] forKey:@"price_money"];
                        qr.payParams = responseObject;
                        qr.navTitle = @"微信支付";
                        qr.userInfo = self.cashierUserModel.user_info;
                        [self.navigationController pushViewController:qr animated:YES];
                    }];
                    break;
                }
                case 3: { // 会员卡支付
                    // 跳转到换卡界面
                    CardChoiceViewController *cardChoiceVC = [[CardChoiceViewController alloc] init];
                    /** 会员卡列表 */
                    cardChoiceVC.userCardListArray = [self judgeUserCardWhetherHaveAccess];
                    /** 用户信息 */
                    cardChoiceVC.userInfo = self.cashierUserModel.user_info;
                    /** 服务师傅 */
                    cardChoiceVC.serviceMasterModel = self.serviceMasterModel;
                    /** 服务 */
                    cardChoiceVC.defaultService = self.defaultService;
                    /** 商品 */
                    cardChoiceVC.defaultCommodity = self.defaultCommodity;
                    /** 购买次数 */
                    cardChoiceVC.defaultCommodity.num = [self.cashierView.numberOperationBtn.numTF.text integerValue];
                    /** 成交价格 */
                    cardChoiceVC.defaultCommodity.actual_sale_price = [self.cashierView.pretiumView.viceLabel.text floatValue];
                    /** 支付金额 */
                    cardChoiceVC.defaultCommodity.total = [self.cashierView.numberOperationBtn.numTF.text integerValue] * [self.cashierView.pretiumView.viceLabel.text floatValue];
                    /** 挂单ID */
                    cardChoiceVC.cartID = self.cartID;
                    /** 行驶里程 */
                    cardChoiceVC.mileage = self.cashierView.mileageView.viceTextFiled.text;
                    /** 下一次保养时间 */
                    cardChoiceVC.nextMaintain = self.cashierView.nextTimeView.viceTextFiled.text;
                    /** 支付成功页面来源 */
                    cardChoiceVC.paySuccessVCSource = CashierPaySuccessVCSource;
                    [self.navigationController pushViewController:cardChoiceVC animated:YES];
                    break;
                }
                case 6: { // 现金支付
                    [AlertAction determineStayLeft:self title:@"现金支付" message:@"请确认您已收到用户的现金/刷卡支付" determineBlock:^{
                        NSMutableDictionary *params = [self payNetwork];
                        [CashierPayNetwork v2CashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                            PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
                            paySuccessVC.userInfo = self.cashierUserModel.user_info;
                            paySuccessVC.paySuccessVCSource = CashierPaySuccessVCSource;
                            [self.navigationController pushViewController:paySuccessVC animated:YES];
                        }];
                    }];
                    break;
                }
                default:
                    break;
            }
        }
        default:
            break;
    }
}


#pragma mark - 使用赠品代理
- (void)employBtnDelegate:(UIButton *)button {
    CancellationViewController *cancellationVC = [[CancellationViewController alloc] init];
    cancellationVC.cancellationArray = (NSMutableArray *)self.cashierUserModel.available_order;
    cancellationVC.userInfo = self.cashierUserModel.user_info;
    [self.navigationController pushViewController:cancellationVC animated:YES];
}

#pragma mark - textField操作
// 手机号输入
- (void)phoneTFAction:(UITextField *)textField {
    // 当手机号输入框为空时
    if (textField.text.length == 0) {
        // 判断车牌号输入框是否也为空
        if (self.cashierView.plnTF.text.length == 0) {
            // 清除用户
            self.cashierUserModel = nil;
            // 清除用户名
            self.cashierView.userNameView.viceTextFiled.text = @"";
        }
    }else if ([CustomObject checkTel:textField.text]) {
        // 手机号
        [self foundationTextFieldInfoRequestUserInfo:textField.text textField:textField];
    }
}
// 车牌号输入
- (void)plnTFAction:(UITextField *)textField {
    // 拼接省份简称
    NSString *pln = [NSString stringWithFormat:@"%@%@", self.cashierView.caftaBtn.titleLabel.text, textField.text];
    // 当车牌号输入框为空时
    if (textField.text.length == 0) {
        // 判断手机号输入框是否也为空
        if (self.cashierView.phoneTF.text.length == 0) {
            // 清除用户
            self.cashierUserModel = nil;
            // 清除用户名
            self.cashierView.userNameView.viceTextFiled.text = @"";
        }
    }else if ([CustomObject isPlnNumber:pln]) {
        // 车牌号
        [self foundationTextFieldInfoRequestUserInfo:pln textField:textField];
    }
}

#pragma mark - 数量操作按钮点击代理
- (void)addSubBtnDelegate:(UIButton *)button {
    /** 修改商品价格和数量，商品信息赋值 */
    [self modifyCommodityPriceAssignment];
}
#pragma mark - 收银页面代理
/** 修改销售价 */
- (void)editPretiumDelegate {
    /** 修改商品价格和数量，商品信息赋值 */
    [self modifyCommodityPriceAssignment];
}

#pragma mark - 界面赋值
- (void)cashierAssignment {
    // 保存默认服务师傅
    self.serviceMasterModel = self.merchantInfo;
    /** 服务师傅 */
    self.cashierView.serviceMasterView.viceTextFiled.text = self.serviceMasterModel.user_name;
    // 初始化购物车商品数组
    self.shoppingCartCommodityArray = [[NSMutableArray alloc] init];
    // 初始化购物车商品字典
    self.shoppingCartGoodsDic = [[NSMutableDictionary alloc] init];
    // 车牌号
    if (self.plnPhoto) {
        NSString *pln = self.plnPhoto[@"车牌号"];
        NSString *province_CAFTA = [pln substringToIndex:1]; //截取掉下标1之前的字符串
        NSString *car_plate_num = [pln substringFromIndex:1]; //截取掉下标1之后的字符串
        self.cashierView.plnTF.text = car_plate_num;
        self.cashierView.caftaBtn.titleLabel.text = province_CAFTA;
        [self foundationTextFieldInfoRequestUserInfo:self.plnPhoto[@"车牌号"] textField:self.cashierView.plnTF];
    }
}
/** 更换商品，商品信息赋值 */
- (void)replaceCommodityInfoAssignment {
    /** 服务类别 */
    self.cashierView.classView.viceTextFiled.text = self.defaultService.name;
    /** 服务商品类别 */
    if (self.defaultCommodity.name) {
        self.cashierView.serviceView.viceTextFiled.text = self.defaultCommodity.name;
    }else {
        self.cashierView.serviceView.viceTextFiled.text = @"没有上架服务";
    }
    /** 商品数量 */
    self.cashierView.numberOperationBtn.numStr = @"1";
    /** 价格view */
    self.cashierView.priceView.viceLabel.text = [NSString stringWithFormat:@"%.2f元", self.defaultCommodity.price];
    /** 销售价view */
    self.cashierView.pretiumView.viceLabel.text = [NSString stringWithFormat:@"%.2f", self.defaultCommodity.sale_price];
    /** 总价view */
    self.cashierView.totalView.viceLabel.text = [NSString stringWithFormat:@"%.2f元", self.defaultCommodity.sale_price];
    // 判断销售价是否大于0
    if ([self.cashierView.pretiumView.viceLabel.text doubleValue] > 0) {
        // 支付按钮可以点击
        [self.cashierView.confirmationCollectionBtn setUserInteractionEnabled:YES];
        self.cashierView.confirmationCollectionBtn.backgroundColor = ThemeColor;
        // 挂单按钮可以点击
        [self.cashierView.placeOrderBtn setUserInteractionEnabled:YES];
        self.cashierView.placeOrderBtn.backgroundColor = BlueColor;
        // 判断会员卡支付是否可用
        [self judgeUserCardWhetherHaveAccess];
    }else {
        // 支付按钮不可以点击
        [self.cashierView.confirmationCollectionBtn setUserInteractionEnabled:NO];
        self.cashierView.confirmationCollectionBtn.backgroundColor = NotClick;
        // 挂单按钮不可以点击
        [self.cashierView.placeOrderBtn setUserInteractionEnabled:NO];
        self.cashierView.placeOrderBtn.backgroundColor = NotClick;
    }
}

/** 修改商品价格和数量，商品信息赋值 */
- (void)modifyCommodityPriceAssignment {
    // 计算商品总价
    // 商品数量
    NSInteger num = [self.cashierView.numberOperationBtn.numTF.text integerValue];
    // 总价
    float total = [self.cashierView.pretiumView.viceLabel.text doubleValue] * num;
    /** 总价view */
    self.cashierView.totalView.viceLabel.text = [NSString stringWithFormat:@"%.2f元", total];
    // 判断销售价是否大于0
    if (total > 0) {
        // 支付按钮可以点击
        [self.cashierView.confirmationCollectionBtn setUserInteractionEnabled:YES];
        self.cashierView.confirmationCollectionBtn.backgroundColor = ThemeColor;
        // 挂单按钮可以点击
        [self.cashierView.placeOrderBtn setUserInteractionEnabled:YES];
        self.cashierView.placeOrderBtn.backgroundColor = BlueColor;
        // 判断会员卡支付是否可用
        [self judgeUserCardWhetherHaveAccess];
    }else {
        // 支付按钮不可以点击
        [self.cashierView.confirmationCollectionBtn setUserInteractionEnabled:NO];
        self.cashierView.confirmationCollectionBtn.backgroundColor = NotClick;
        // 挂单按钮不可以点击
        [self.cashierView.placeOrderBtn setUserInteractionEnabled:NO];
        self.cashierView.placeOrderBtn.backgroundColor = NotClick;
    }
}

/** 购买用户信息赋值 */
- (void)purchaseUserInfoAssignment {
    // 用户名
    self.cashierView.userNameView.viceTextFiled.text = self.cashierUserModel.user_info.name;
    // 判断手机号格式
    if ([CustomObject checkTel:self.cashierUserModel.user_info.mobile]) {
        // 手机号
        self.cashierView.phoneTF.text = self.cashierUserModel.user_info.mobile;
        if ([CustomObject isPlnNumber:self.cashierUserModel.user_info.car_plate_no]) {
            // 车牌号
            self.cashierView.plnTF.text = self.cashierUserModel.user_info.car_plate_num;
            self.cashierView.caftaBtn.titleLabel.text = self.cashierUserModel.user_info.province_CAFTA;
        }
    }else if ([CustomObject isPlnNumber:self.cashierUserModel.user_info.car_plate_no]) {
        // 车牌号
        self.cashierView.plnTF.text = self.cashierUserModel.user_info.car_plate_num;
        self.cashierView.caftaBtn.titleLabel.text = self.cashierUserModel.user_info.province_CAFTA;
    }
    // 判断会员卡支付是否可用
    [self judgeUserCardWhetherHaveAccess];
}

/** 页面来源是挂单，对商品进行赋值 */
- (void)sourcePendOrderGoodsAssignment {
    ShoppingCartModel *shoppingGoodsModel = [self.goodsArray firstObject];
    // 保存商品类型
    self.defaultService = shoppingGoodsModel.goods_category;
    // 保存商品
    self.defaultCommodity = shoppingGoodsModel.goods;
    // 商品数量
    self.cashierView.numberOperationBtn.numTF.text = [NSString stringWithFormat:@"%ld", shoppingGoodsModel.buy_num];
    // 价格view
    self.cashierView.priceView.viceLabel.text = [NSString stringWithFormat:@"%.2f元", shoppingGoodsModel.goods.price];
    // 销售价view
    self.cashierView.pretiumView.viceLabel.text = [NSString stringWithFormat:@"%.2f", shoppingGoodsModel.goods.actual_sale_price];
    // 总价view
    self.cashierView.totalView.viceLabel.text = [NSString stringWithFormat:@"%.2f元", shoppingGoodsModel.goods.actual_sale_price * shoppingGoodsModel.buy_num];
    // 判断，如果是保养商品
    if (shoppingGoodsModel.goods_category.goods_category_id == 6) { // 保养
        [self.cashierView.mileageView setHidden:NO];
        [self.cashierView.nextTimeView setHidden:NO];
        self.cashierView.mileageView.viceTextFiled.text = self.mileage;
        self.cashierView.nextTimeView.viceTextFiled.text = self.nextMaintain;
    }else {
        [self.cashierView.mileageView setHidden:YES];
        [self.cashierView.nextTimeView setHidden:YES];
    }
    // 获取用户信息
    // 用户信息赋值
    self.cashierView.phoneTF.text = self.userPhone;
    self.cashierView.plnTF.text = self.userPln;
    // 判断是否有手机号
    if ([CustomObject checkTel:self.userPhone]) {
        [self foundationTextFieldInfoRequestUserInfo:self.userPhone textField:self.cashierView.phoneTF];
    }else if ([CustomObject isPlnNumber:self.userPln]){
        self.userPln = [self.userPln substringFromIndex:1]; //截取掉下标1之后的字符串
        [self foundationTextFieldInfoRequestUserInfo:self.userPln textField:self.cashierView.plnTF];
    }
    // 手机号输入框不可输入
    self.cashierView.phoneTF.enabled = NO;
    // 车牌号输入框不可输入
    self.cashierView.plnTF.enabled = NO;
    // 选择用户按钮不可点击
    self.cashierView.phoneBtn.enabled = NO;
    // 选择车辆按钮不可点击
    self.cashierView.plnBtn.enabled = NO;
    // 选择用户按钮不可点击
    self.cashierView.userNameView.usedCellBtn.enabled = NO;
}


#pragma mark - 布局nav
- (void)cashierLayoutNAV {
    self.navigationItem.title = @"收银";
}

#pragma mark - 布局视图
- (void)cashierLayoutView {
    /** 收银view */
    self.cashierView = [[CashierView alloc] init];
    /** 数量操作代理 */
    self.cashierView.numberOperationBtn.delegate = self;
    /** 收银代理 */
    self.cashierView.delegate = self;
    /** 确认收款 */
    [self.cashierView.confirmationCollectionBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 提交订单 */
    [self.cashierView.placeOrderBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 手机号 */
    [self.cashierView.phoneTF addTarget:self action:@selector(phoneTFAction:) forControlEvents:UIControlEventEditingChanged];
    [self.cashierView.phoneBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 车牌号 */
    [self.cashierView.plnTF addTarget:self action:@selector(plnTFAction:) forControlEvents:UIControlEventEditingChanged];
    [self.cashierView.plnBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 用户名 */
    [self.cashierView.userNameView.usedCellBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 类别view */
    [self.cashierView.classView.usedCellBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 服务view */
    [self.cashierView.serviceView.usedCellBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 添加商品 */
    [self.cashierView.addGoodsBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 购物车 */
    [self.cashierView.shoppingCartBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 服务师傅 */
    [self.cashierView.serviceMasterView.usedCellBtn addTarget:self action:@selector(cashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cashierView];
    @weakify(self)
    [self.cashierView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark -  根据输入信息，请求用户信息
- (void)foundationTextFieldInfoRequestUserInfo:(NSString *)tfText textField:(UITextField *)textField {
    // 初始化车牌号字符串，初始化手机号字符串，
    NSString *pln = [[NSString alloc] init];
    NSString *phone = [[NSString alloc] init];
    // 判断是车牌号输入框，还是手机号输入框
    if ([textField isEqual:self.cashierView.plnTF]) { // 车牌号
        pln = tfText;
        phone = self.cashierView.phoneTF.text;
    }else if ([textField isEqual:self.cashierView.phoneTF]) { // 手机号
        phone = tfText;
        pln = self.cashierView.plnTF.text;
    }
    // 判断搜索框输入手机号格式限制或搜索框输入车牌号格式限制
    if ([CustomObject checkTel:tfText] || [CustomObject isPlnNumber:tfText]) {
        /*/index.php?c=provider_user_card&a=list&v=1
         provider_id 	int 	是 	服务商id
         mobile 	string 	是 	手机号
         car_plate_no 	string 	是 	车牌号      */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"mobile"] = phone; // 手机号
        params[@"car_plate_no"] = pln; // 车牌号
        [CashierUserModel foundationUserPhoneObtainUserInfoParams:params success:^(CashierUserModel *cashierUserModel) {
            [MBProgressHUD hideHUD];
            // 回收键盘
            [self.cashierView endEditing:YES];
            // 保存收银用户信息用户信息
            self.cashierUserModel = cashierUserModel;
            // 判断是否有冲突用户
            if (cashierUserModel.conflict == 1) { // 有冲突用户
                [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"编辑" message:@"您输入的车牌号和手机号是两个用户，\n无法购买是否编辑用户信息！" admitBlock:nil noadmitBlock:^{
                    UserConflictViewController *userConflictVC = [[UserConflictViewController alloc] init];
                    userConflictVC.provider_user_id = cashierUserModel.provider_user_id;
                    [self.navigationController pushViewController:userConflictVC animated:YES];
                }];
                return;
            }
            // 判断是否有用户
            if (cashierUserModel.exist_user == -1) { // 没有用户
                [AlertAction determineStayLeft:self title:@"提示" admit:@"去添加" noadmit:@"暂不添加" message:@"还不是您的用户，是否添加！" admitBlock:^{
                    AddUserViewController *addUserVC = [[AddUserViewController alloc] init];
                    /** 手机号 */
                    addUserVC.userPhone = [CustomObject checkTel:self.cashierView.phoneTF.text] ? self.cashierView.phoneTF.text : @"";
                    /** 车牌号 */
                    addUserVC.userPln = [CustomObject isPlnNumber:[NSString stringWithFormat:@"%@%@", self.cashierView.caftaBtn.titleLabel.text, self.cashierView.plnTF.text]] ? [NSString stringWithFormat:@"%@%@", self.cashierView.caftaBtn.titleLabel.text, self.cashierView.plnTF.text] : @"";
                    [self.navigationController pushViewController:addUserVC animated:YES];
                } noadmitBlock:nil];
                return;
            }
            // 判断是否有赠品
            if (cashierUserModel.available_order.count != 0) { // 有赠品
                CashierPremiumView *premiumView = [[CashierPremiumView alloc] init];
                /** 使用 */
                premiumView.delegate = self;
                [self.view addSubview:premiumView];
                @weakify(self)
                [premiumView mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    make.top.equalTo(textField.mas_bottom).offset(-5);
                    make.left.equalTo(self.cashierView.mas_left).offset(16);
                    make.right.equalTo(self.cashierView.mas_right).offset(-16);
                    make.bottom.equalTo(premiumView.containerImage.mas_bottom);
                }];
            }
            /** 购买用户信息赋值 */
            [self purchaseUserInfoAssignment];
        }];
    }
}

#pragma mark -  遍历购物车数组数据，将相同商品数量累计在一起，并返回商品数据
- (NSString *)equalCommodityNumberCumulative {
    // 初始化一个字典
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    // 遍历所有购物车数据
    for (ShoppingCartModel *carComModel in self.shoppingCartCommodityArray) {
        // 获取当前商品ID，当前商品ID作为字典中的key
        NSString *goodsID = [NSString stringWithFormat:@"%ld", (long)carComModel.goods.goods_id];
        // 判断字典中是否有当前商品ID作为的key
        if ([dic.allKeys containsObject:goodsID]) {
            // 如果有，获取key对应的商品，将当前商品的数量和字典中商品数量相加，并重新放入字典中
            ShoppingCartModel *carCommodityModel = [dic objectForKey:goodsID];
            // 商品数量相加
            carCommodityModel.buy_num = carCommodityModel.buy_num + carComModel.buy_num;
            // 商品销售价，取最低价
            carCommodityModel.goods.actual_sale_price = carCommodityModel.goods.actual_sale_price < carComModel.goods.actual_sale_price ? carCommodityModel.goods.actual_sale_price : carComModel.goods.actual_sale_price;
            [dic setValue:carCommodityModel forKey:goodsID];
        }else {
            // 如果没有，在字典中，添加当前商品的健值对
            [dic setValue:carComModel forKey:goodsID];
        }
    }
    // 删除购物车商品数组数据
    [self.shoppingCartCommodityArray removeAllObjects];
    // 清除总价
    self.shoppingCartTotal = 0;
    // 初始化一个字符串，保存购物车商品数据
    NSString *goodsData = [[NSString alloc] init];
    // 取出字典中对应的商品，并保存在数组中
    for (NSString *goodid in dic.allKeys) {
        ShoppingCartModel *carCommodityModel = [dic objectForKey:goodid];
        [self.shoppingCartCommodityArray addObject:carCommodityModel];
        // 计算订单总价
        self.shoppingCartTotal = self.shoppingCartTotal + carCommodityModel.goods.actual_sale_price * carCommodityModel.buy_num;
        // 拼接商品数据
        NSString *goodsInfo = [NSString stringWithFormat:@"%ld_%ld_%ld_%.2f", carCommodityModel.goods_category.goods_category_id, carCommodityModel.goods.goods_id, carCommodityModel.buy_num, carCommodityModel.goods.actual_sale_price];
        if (goodsData.length == 0) {
            goodsData = [NSString stringWithFormat:@"%@", goodsInfo];
        }else {
            goodsData = [NSString stringWithFormat:@"%@,%@", goodsData, goodsInfo];
        }
    }
    return goodsData;
}

#pragma mark -  1.1.0用
// 挂单网络请求
- (void)placeOrderNetwork {
    // 判断有没有服务商品
    if (self.defaultCommodity.goods_id == 0) {
        [MBProgressHUD showError:@"请先选择商品"];
        return;
    }
    // 判断总价是否小于0
    if ([self.cashierView.totalView.viceLabel.text doubleValue] <= 0) {
        [MBProgressHUD showError:@"总价不能小于0"];
        return;
    }
    
    // 判断页面来源
    if (self.cashierVCSource == PendOrderCashierViewSource) { // 挂单页
        /** /index.php?c=cart&a=edit&v=1
         cart_id 	int 	是 	挂单列表id
         sale_user_id 	int 	是 	服务师傅
         mobile 	string 	是 	手机号
         car_plate_no 	string 	是 	车牌号
         goods_data 	string 	是 	商品数据,格式： 服务类别id_商品id_购买数量_售价， 多个商品用逗号分割
         total_price 	float 	是 	总价
         mileage 	float 	否 	行驶里程
         next_maintain 	string 	否 	下一次保养时间,   */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"cart_id"] = [NSString stringWithFormat:@"%ld", self.cartID]; // 挂单列表id
        params[@"sale_user_id"] = self.serviceMasterModel.staff_user_id; // 服务师傅
        params[@"mobile"] = self.cashierView.phoneTF.text; // 手机号
        NSString *pln = [NSString stringWithFormat:@"%@%@", self.cashierView.caftaBtn.titleLabel.text, self.cashierView.plnTF.text];
        params[@"car_plate_no"] = [CustomObject isPlnNumber:pln] ? pln : @""; // 车牌号
        params[@"total_price"] = [NSString stringWithFormat:@"%@", [CustomString getNumber:self.cashierView.totalView.viceLabel.text]]; // 总价
        params[@"mileage"] = self.cashierView.mileageView.viceTextFiled.text; // 行驶里程
        params[@"next_maintain"] = self.cashierView.nextTimeView.viceTextFiled.text; // 下一次保养时间
        params[@"goods_data"] = [NSString stringWithFormat:@"%ld_%ld_%@_%@", (long)self.defaultService.goods_category_id, (long)self.defaultCommodity.goods_id, self.cashierView.numberOperationBtn.numTF.text, self.cashierView.pretiumView.viceLabel.text]; // 商品数据
        [CashierPayNetwork editCartInfoAddNotCashier:params success:^{
            
        }];
    }else {
        /** /index.php?c=cart&a=add&v=1
         provider_id 	int 	是 	服务商id
         staff_user_id 	int 	是 	登录者id
         sale_user_id 	int 	是 	服务师傅
         mobile 	string 	是 	手机号
         car_plate_no 	string 	是 	车牌号
         goods_data 	string 	是 	商品数据,格式： 服务类别id_商品id_购买数量_售价， 多个商品用逗号分割
         total_price 	float 	是 	总价
         mileage 	float 	否 	行驶里程
         next_maintain 	string 	否 	下一次保养时间,  */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
        params[@"sale_user_id"] = self.serviceMasterModel.staff_user_id; // 服务师傅
        params[@"mobile"] = self.cashierView.phoneTF.text; // 手机号
        NSString *pln = [NSString stringWithFormat:@"%@%@", self.cashierView.caftaBtn.titleLabel.text, self.cashierView.plnTF.text];
        params[@"car_plate_no"] = [CustomObject isPlnNumber:pln] ? pln : @""; // 车牌号
        params[@"total_price"] = [NSString stringWithFormat:@"%@", [CustomString getNumber:self.cashierView.totalView.viceLabel.text]]; // 总价
        params[@"mileage"] = self.cashierView.mileageView.viceTextFiled.text; // 行驶里程
        params[@"next_maintain"] = self.cashierView.nextTimeView.viceTextFiled.text; // 下一次保养时间
        params[@"goods_data"] = [NSString stringWithFormat:@"%ld_%ld_%@_%@", (long)self.defaultService.goods_category_id, (long)self.defaultCommodity.goods_id, self.cashierView.numberOperationBtn.numTF.text, self.cashierView.pretiumView.viceLabel.text]; // 商品数据
        [CashierPayNetwork cartAddNotCashier:params success:^{
            
        }];
    }
}
// 1.1.0,确认收款网络请求
- (void)confirmationCollectionNetwork {
    
}
// 请求购买方式
- (void)requestPaymentMethodData {
    [PaymentMethodModel requestPaymentMethodSuccess:^(NSMutableArray *paymentMethodArray) {
        // 保存支付方式数据
        self.payMethodArray = paymentMethodArray;
    }];
}
// 拼接支付参数
- (NSMutableDictionary *)payNetwork {
    /*/index.php?c=order&a=add&v=2
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     sale_user_id 	int 	是 	服务师傅
     mobile 	string 	是 	手机号
     car_plate_no 	string 	是 	车牌号
     goods_data 	string 	是 	商品数据,格式： 服务类别id_商品id_购买数量_售价， 多个商品用逗号分割
     pay_amount 	string 	是 	支付方式:格式--支付方式_支付金额_卡号，(无卡的卡号为00000000) 1.支付宝 2.微信 3.次数 4.eb 5.账户余额 6.现金或刷卡 7-年卡
     mileage 	float 	否 	行驶里程
     next_maintain 	string 	否 	下一次保养时间,
     cart_id 	int 	否 	购物车记录[挂单列表] id (挂单界面直接收银时必传)       */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id，
    params[@"sale_user_id"] = self.serviceMasterModel.staff_user_id; //销售者id
    params[@"mobile"] = self.cashierUserModel.user_info.mobile ? self.cashierUserModel.user_info.mobile : @""; // 手机号
    NSString *pln = [NSString stringWithFormat:@"%@%@", self.cashierView.caftaBtn.titleLabel.text, self.cashierView.plnTF.text];
    params[@"car_plate_no"] = [CustomObject isPlnNumber:pln] ? pln : @""; // 车牌号
    params[@"goods_data"] = [NSString stringWithFormat:@"%ld_%ld_%@_%@", (long)self.defaultService.goods_category_id, (long)self.defaultCommodity.goods_id, self.cashierView.numberOperationBtn.numTF.text, self.cashierView.pretiumView.viceLabel.text]; // 商品数据
    params[@"pay_amount"] = [NSString stringWithFormat:@"%ld_%@_000000", self.payMethodModel.pay_method_id, [CustomString getNumber:self.cashierView.totalView.viceLabel.text]]; // 支付方式
    params[@"mileage"] = self.cashierView.mileageView.viceTextFiled.text; // 行驶里程
    params[@"next_maintain"] = self.cashierView.nextTimeView.viceTextFiled.text; // 下一次保养时间
    params[@"cart_id"] = [NSString stringWithFormat:@"%ld", self.cartID]; // 购物车记录
    return params;
}

// 判断会员卡是否可用
- (NSMutableArray *)judgeUserCardWhetherHaveAccess {
    // 初始化可用会员卡列表
    NSMutableArray *availableCardArray = [[NSMutableArray alloc] init];
    // 初始化不可用会员卡列表
    NSMutableArray *noAvailableCardArray = [[NSMutableArray alloc] init];
    // 初始化，用来保存分类后的用户会员卡
    NSMutableArray *userCareArray = [[NSMutableArray alloc] init];
    // 便利用户会员卡，按是否可用进行分类(判断流程：1、判断会员卡是否过期。2、未过期的会员卡判断是否有可用范围。3、)
    /**
     2、过期
     5、余额足够
     1、判断会员卡是否过期              4、没有可用范围（全范围）
     6、余额不够
     3、未过期                               8、不可用
     7、有可用范围。遍历可用范围                  10、余额足够
     9、可用
     11、余额不够
     **/
    for (UserMemberCardModel *userCard in self.cashierUserModel.cards) {
        // 判断是否过期
        if (userCard.is_expire == 0) { // 未过期
            // 判断是否有可用范围
            if (userCard.used_goods.count == 0) {
                // 获取商品购买的数量
                NSInteger num = [self.cashierView.numberOperationBtn.numTF.text integerValue];
                // 获取商品购买价格
                NSInteger priceMoney = [self.cashierView.priceView.viceTextFiled.text floatValue];
                // 判断会员卡的余额或者余次是否足够
                if (userCard.card_category_id == 3 || userCard.money > priceMoney || userCard.num > self.defaultCommodity.card_num_price * num) { // 足够
                    userCard.is_used = YES;
                    [availableCardArray addObject:userCard];
                }else { // 不足
                    userCard.is_used = NO;
                    [noAvailableCardArray addObject:userCard];
                }
            }else {
                // 便利会员卡可用分类
                for (NSString *isUser  in userCard.used_goods) {
                    // 判断会员卡是否可用
                    if ([[NSString stringWithFormat:@"%@", isUser] isEqualToString:[NSString stringWithFormat:@"%ld", self.defaultCommodity.goods_id]]) { // 适合改服务
                        // 获取商品购买的数量
                        NSInteger num = [self.cashierView.numberOperationBtn.numTF.text integerValue];
                        // 获取商品购买价格
                        NSInteger priceMoney = [self.cashierView.priceView.viceTextFiled.text floatValue];
                        // 判断会员卡的余额或者余次是否足够
                        if (userCard.card_category_id == 3 || userCard.money > priceMoney || userCard.num > self.defaultCommodity.card_num_price * num) {  // 足够
                            if ( ![availableCardArray containsObject:userCard]) {
                                userCard.is_used = YES;
                                [availableCardArray addObject:userCard];
                                [noAvailableCardArray removeObject:userCard];
                            }
                        }else {  // 不足
                            if (![availableCardArray containsObject:userCard] && ![noAvailableCardArray containsObject:userCard]) {
                                userCard.is_used = NO;
                                [noAvailableCardArray addObject:userCard];
                            }
                        }
                    }else {  // 不适合改服务
                        if (![availableCardArray containsObject: userCard] && ![noAvailableCardArray containsObject:userCard]) {
                            userCard.is_used = NO;
                            [noAvailableCardArray addObject:userCard];
                        }
                    }
                }
            }
        }else { // 过期
            if (![availableCardArray containsObject: userCard] && ![noAvailableCardArray containsObject:userCard]) {
                userCard.is_used = NO;
                [noAvailableCardArray addObject:userCard];
            }
        }
    }
    // 判断有没有可用会员卡
    if (availableCardArray.count == 0) { // 没有
        // 遍历支付方式数据
        for (PaymentMethodModel *payMethod in self.payMethodArray) {
            if (payMethod.pay_method_id == 3 || payMethod.pay_method_id == 4) {
                [self.payMethodArray removeObject:payMethod];
                break;
            }
        }
    }else { // 有
        [PaymentMethodModel requestPaymentMethodSuccess:^(NSMutableArray *paymentMethodArray) {
            // 保存支付方式数据
            self.payMethodArray = paymentMethodArray;
        }];
    }
    // 保存分类后的会员卡列表
    [userCareArray addObject:availableCardArray];
    [userCareArray addObject:noAvailableCardArray];
    return userCareArray;
}

- (void)dealloc {
    // 移除注册通知
    [[NSNotificationCenter defaultCenter] removeObserver:self.cashierView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
