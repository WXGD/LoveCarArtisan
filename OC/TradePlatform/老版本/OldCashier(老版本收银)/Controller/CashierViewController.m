//
//  CashierViewController.m
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierViewController.h"
// view
#import "CashierView.h"
#import "CashierServiceChoiceView.h"
#import "CashierPremiumView.h"
// 下级控制器
#import "CardChoiceViewController.h"
#import "PayQRCodeViewController.h"
#import "PaySuccessViewController.h"
#import "PaySuccessViewController.h"
#import "PhotographViewController.h"
#import "CancellationViewController.h"
#import "SearchUserViewController.h"
#import "UserInfoViewController.h"
// 网络请求
#import "CashierPayNetwork.h"
#import "ServiceCategoryHandle.h"
#import "CashierUserModel.h"
#import "ServiceMasterHandle.h"

@interface CashierViewController ()<CashierServiceChoiceDelegate, UITextFieldDelegate, AddSubBtnDelegate, CashierPremiumDelegate>

/** 收银view */
@property (strong, nonatomic) CashierView *cashierView;
/** 用户会员卡 */
@property (strong, nonatomic) NSMutableArray *userCardListArray;
/** 保存收银用户信息用户信息 */
@property (strong, nonatomic) CashierUserModel *cashierUserModel;
/** 服务列表数据 */
@property (strong, nonatomic) NSMutableArray *serviceListArray;
/** 默认选择服务类型 */
@property (strong, nonatomic) ServiceProviderModel *defaultService;
/** 商品列表数据 */
@property (strong, nonatomic) NSMutableArray *commodityListArray;
/** 默认选择商品类型 */
@property (strong, nonatomic) CommodityShowStyleModel *defaultCommodity;
/** 支付方式数据 */
@property (strong, nonatomic) NSMutableArray *payMethodArray;
/** 选择的支付方式 */
@property (strong, nonatomic) PaymentMethodModel *payMethodModel;
/** 服务师傅 */
@property (strong, nonatomic) MerchantInfoModel *serviceMasterModel;

@end

@implementation CashierViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self cashierLayoutNAV];
    // 布局视图
    [self cashierLayoutView];
    // 网络请求
    [self requestServiceProvidersData];
    // 请求购买方式
    [self requestPaymentMethodData];
}
#pragma mark - 网络请求
// 请求服务项目
- (void)requestServiceProvidersData {
    /** 服务列表数据 */
    self.serviceListArray = [ServiceCategoryHandle sharedInstance].serviceCategoryArray;
    /** 默认选择服务类型 */
    self.defaultService = [self.serviceListArray firstObject];
    // 请求服务商品
    [self requestServiceCommodityData];
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (self.serviceListArray.count == 0) {
        [ServiceCategoryHandle sharedInstance].requestCategorySuccessBlock = ^ () {
            /** 服务列表数据 */
            self.serviceListArray = [ServiceCategoryHandle sharedInstance].serviceCategoryArray;
            /** 默认选择服务类型 */
            self.defaultService = [self.serviceListArray firstObject];
            // 请求服务商品
            [self requestServiceCommodityData];
        };
    }
    
//    /*/index.php?c=goods_category&a=list&v=1
//     provider_id 	int 	是 	服务商id
//     start 	int 	否 	记录开始位置,默认为0
//     pageSize 	int 	否 	每页显示条数，默认为0 (代表全部)     */
//    // 网络请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
//    [ServiceProviderModel requesServiceListDataParams:params success:^(NSMutableArray *serviceList) {
//        /** 默认选择服务类型 */
//        self.defaultService = [serviceList firstObject];
//        /** 服务列表数据 */
//        self.serviceListArray = serviceList;
//        // 请求服务商品
//        [self requestServiceCommodityData];
//    }];
}

// 请求服务商品
- (void)requestServiceCommodityData {
    // 请求服务商品
    /*/index.php?c=goods&a=list&v=1
     provider_id 	int 	是 	服务id
     goods_category_id 	int 	否 	商品分类id，(获取某类商品中必传)  */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
    params[@"goods_category_id"] = [NSString stringWithFormat:@"%ld", self.defaultService.goods_category_id]; // 商品分类id
    // 请求商品列表
    [CommodityShowStyleModel requesCommodityListDataParams:params success:^(NSMutableArray *commodityList) {
        [MBProgressHUD hideHUD];
        /** 商品列表数据 */
        self.commodityListArray = commodityList;
        /** 默认选择商品类型 */
        self.defaultCommodity = [commodityList firstObject];
        // 界面赋值
        [self cashierAssignment];
        // 车牌号
        if (self.plnPhoto) {
            self.cashierView.queryTF.text = self.plnPhoto[@"车牌号"];
            [self accordingToPlnPerhapsPhoneRequestUserInfoReplacementString:@"车牌号"];
        }
    }];
}
// 请求购买方式
- (void)requestPaymentMethodData {
    [PaymentMethodModel requestPaymentMethodSuccess:^(NSMutableArray *paymentMethodArray) {
        // 保存支付方式数据
        self.payMethodArray = paymentMethodArray;
    }];
}
#pragma mark - 按钮点击方法
- (void)cashierBtnAvtion:(UIButton *)button {
    // 回收键盘
    [self.cashierView cashierTapAction];
    switch (button.tag) {
            /** 查询用户 */
        case QueryUserBtnAction: {
            SearchUserViewController *searchUserVC = [[SearchUserViewController alloc] init];
            searchUserVC.ChoiceUserBlock = ^(UserModel *userModel) {
                self.cashierView.queryTF.text = userModel.mobile;
                // 判断如果没有手机号填车牌号
                if (userModel.mobile.length == 0) {
                    self.cashierView.queryTF.text = userModel.car_plate_no;
                }
                // 根据输入信息，请求用户信息
                [self foundationTextFieldInfoRequestUserInfo:self.cashierView.queryTF.text];
            };
            [self.navigationController pushViewController:searchUserVC animated:YES];
            break;
        }
            /** 用户信息完善 */
        case PerfectUserInfoBtnAction: {
            // 判断会员卡信息是否完善
            if (self.cashierUserModel.user_info.is_completed == 1) {
                UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
                userInfoVC.providerUserId = [NSString stringWithFormat:@"%ld", self.cashierUserModel.user_info.provider_user_id];
                [self.navigationController pushViewController:userInfoVC animated:YES];
            }
            break;
        }
            /** 用户信息不完善 */
        case NoPerfectUserInfoBtnAction: {
            
            break;
        }
            /** 类别 */
        case ClassBtnAction: {
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
            /** 数量操作 */
        case NumberOperationBtnAction: {
            
            break;
        }
            /** 服务师傅 */
        case ServiceMasterBtnAction: {
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
            /** 总价view */
        case PriceBtnAction: {

            break;
        }
            /** 确认收款 */
        case ConfirmationCollectionBtnAction: {
            // 判断是否有客户
            if (!self.cashierUserModel.user_info.provider_user_id) {
                [MBProgressHUD showError:@"请添加购买客户"];
                return;
            }
            // 判断总价是否小于0
            if ([self.cashierView.priceView.viceTextFiled.text doubleValue] == 0) {
                [MBProgressHUD showError:@"总价不能为0"];
                return;
            }
            // 弹出支付方式选择
            CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            payChoiceBoxView.choiceArray = self.payMethodArray;
            payChoiceBoxView.serviceChoice = PayMethodChoiceBtnAction;
            payChoiceBoxView.delegate = self;
            [payChoiceBoxView show];
            break;
        }
        default:
            break;
    }
}
// 服务，服务商品，服务师傅，支付方式，选择代理方法
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    switch (serviceChoice) {
            /** 服务类型选择 */
        case ServiceTypeChoiceBtnAction:{
            /** 默认选择服务类型 */
            self.defaultService = [choiceArray objectAtIndex:indexPath.row];
            // 请求服务商品
            [self requestServiceCommodityData];
            break;
        }
            /** 服务商品选择 */
        case ServiceGoodsChoiceBtnAction:{
            /** 默认选择商品类型 */
            self.defaultCommodity = [choiceArray objectAtIndex:indexPath.row];
            // 界面赋值
            [self cashierAssignment];
            break;
        }
            /** 服务师傅选择 */
        case ServiceMasterChoiceBtnAction:{
            // 更换当前服务师傅
            self.serviceMasterModel = [choiceArray objectAtIndex:indexPath.row];
            // 界面赋值
            [self cashierAssignment];
            break;
        }
            /** 支付方式选择 */
        case PayMethodChoiceBtnAction:{
            self.payMethodModel = [choiceArray objectAtIndex:indexPath.row];
            switch (self.payMethodModel.pay_method_id) {
                case 1: { // 支付宝支付
                    NSMutableDictionary *params = [self payNetwork];
                    [CashierPayNetwork cashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                        PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                        qr.payQRCodePageType = CashierUseVCPageType;
                        // 添加支付金额
                        [responseObject setObject:self.cashierView.priceView.viceTextFiled.text forKey:@"price_money"];
                        qr.payParams = responseObject;
                        qr.navTitle = @"支付宝支付";
                        qr.userInfo = self.cashierUserModel.user_info;
                        [self.navigationController pushViewController:qr animated:YES];
                    }];
                    break;
                }
                case 2: { // 微信支付
                    NSMutableDictionary *params = [self payNetwork];
                    [CashierPayNetwork cashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                        PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                        qr.payQRCodePageType = CashierUseVCPageType;
                        // 添加支付金额
                        [responseObject setObject:self.cashierView.priceView.viceTextFiled.text forKey:@"price_money"];
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
                    /** 支付金额 */
                    cardChoiceVC.defaultCommodity.total = [self.cashierView.priceView.viceTextFiled.text floatValue];
                    /** 优惠金额 */
                    // 计算优惠金额
                    double discountMoney = self.defaultCommodity.sale_price *  [self.cashierView.numberOperationBtn.numTF.text integerValue] - [self.cashierView.priceView.viceTextFiled.text doubleValue];
                    cardChoiceVC.defaultCommodity.saveAmount = discountMoney;
                    [self.navigationController pushViewController:cardChoiceVC animated:YES];
                    break;
                }
                case 6: { // 现金支付
                    [AlertAction determineStayLeft:self title:@"现金支付" message:@"请确认您已收到用户的现金/刷卡支付" determineBlock:^{
                        NSMutableDictionary *params = [self payNetwork];
                        [CashierPayNetwork cashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                            PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
                            paySuccessVC.userInfo = self.cashierUserModel.user_info;
                            [self.navigationController pushViewController:paySuccessVC animated:YES];
                        }];
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

/** 使用赠品 */
- (void)employBtnDelegate:(UIButton *)button {
    CancellationViewController *cancellationVC = [[CancellationViewController alloc] init];
    cancellationVC.cancellationArray = (NSMutableArray *)self.cashierUserModel.available_order;
    cancellationVC.userInfo = self.cashierUserModel.user_info;
    [self.navigationController pushViewController:cancellationVC animated:YES];
}


#pragma mark - textField输入代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self accordingToPlnPerhapsPhoneRequestUserInfoReplacementString:string];
    return YES;
}
#pragma mark - 加减按钮点击代理
// 按钮点击代理
- (void)addSubBtnDelegate:(UIButton *)button {
    // 购买数量
    NSInteger commodityNum = [self.cashierView.numberOperationBtn.numTF.text integerValue];
    // 商品总价
    self.cashierView.priceView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.defaultCommodity.sale_price * commodityNum];
    double commodityTotal = [self.cashierView.priceView.viceTextFiled.text doubleValue];
    // 判断商品总价是否大于0
    if (commodityTotal > 0) {
        // 支付按钮可以点击
        [self.cashierView.confirmationCollectionBtn setUserInteractionEnabled:YES];
        self.cashierView.confirmationCollectionBtn.backgroundColor = ThemeColor;
        // 判断会员卡支付是否可用
        [self judgeUserCardWhetherHaveAccess];
    }else {
        // 支付按钮不可以点击
        [self.cashierView.confirmationCollectionBtn setUserInteractionEnabled:NO];
        self.cashierView.confirmationCollectionBtn.backgroundColor = NotClick;
    }
}
// nav右边按钮
- (void)cashierRightBarButtonItmeAction {
    PhotographViewController *photographVC = [[PhotographViewController alloc] init];
    photographVC.photographViewType = CashierAssignment;
    [self.navigationController pushViewController:photographVC animated:YES];
    // 删除当前界面
    NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [navViews removeObject:self];
    [self.navigationController setViewControllers:navViews animated:YES];
}


#pragma mark - 界面赋值
- (void)cashierAssignment {
    /** 服务类别 */
    self.cashierView.classView.describeLabel.text = self.defaultService.name;
    /** 服务商品类别 */
    if (self.defaultCommodity.name) {
        self.cashierView.serviceView.describeLabel.text = self.defaultCommodity.name;
    }else {
        self.cashierView.serviceView.describeLabel.text = @"没有上架服务";
    }
    /** 用户姓名 */
    self.cashierView.userNameLabel.rightText.text = self.cashierUserModel.user_info.name;
    /** 用户车牌 */
    self.cashierView.userPlnLabel.rightText.text = self.cashierUserModel.user_info.car_plate_no;
    /** 用户手机号 */
    self.cashierView.userPhoneLabel.rightText.text = self.cashierUserModel.user_info.mobile;
    /** 服务师傅 */
    self.cashierView.serviceMasterView.describeLabel.text = self.serviceMasterModel.user_name;
    // 计算商品总价
    /** 总价 */
    // 商品数量
    NSInteger num = [self.cashierView.numberOperationBtn.numTF.text integerValue];
    // 总价
    float total = self.defaultCommodity.sale_price * num;
    self.cashierView.priceView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", total];
    // 判断总价是否大于0
    if (total > 0) {
        // 支付按钮可以点击
        [self.cashierView.confirmationCollectionBtn setUserInteractionEnabled:YES];
        self.cashierView.confirmationCollectionBtn.backgroundColor = ThemeColor;
        // 判断会员卡支付是否可用
        [self judgeUserCardWhetherHaveAccess];
    }else {
        // 支付按钮不可以点击
        [self.cashierView.confirmationCollectionBtn setUserInteractionEnabled:NO];
        self.cashierView.confirmationCollectionBtn.backgroundColor = NotClick;
    }
}


#pragma mark - 布局nav
- (void)cashierLayoutNAV {
    self.navigationItem.title = @"收银";
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cashier_nav_scan"] style:UIBarButtonItemStyleDone target:self action:@selector(cashierRightBarButtonItmeAction)];
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(queryUserRightBarButtonItmeAction)];
}

#pragma mark - 布局视图
- (void)cashierLayoutView {
    /** 收银view */
    self.cashierView = [[CashierView alloc] init];
    // 遵守textfield代理
    self.cashierView.queryTF.delegate = self;
    // 遵守商品数量修改代理
    self.cashierView.numberOperationBtn.delegate = self;
    /** 查询用户 */
    [self.cashierView.queryBtn addTarget:self action:@selector(cashierBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 用户信息不完善 */
    [self.cashierView.noPerfectUserInfoBtn addTarget:self action:@selector(cashierBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 用户信息完善 */
    [self.cashierView.perfectUserInfoBtn addTarget:self action:@selector(cashierBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 类别view */
    [self.cashierView.classView.usedCellBtn addTarget:self action:@selector(cashierBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 服务view */
    [self.cashierView.serviceView.usedCellBtn addTarget:self action:@selector(cashierBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 服务师傅 */
    [self.cashierView.serviceMasterView.usedCellBtn addTarget:self action:@selector(cashierBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 总价view */
    [self.cashierView.priceView.usedCellBtn addTarget:self action:@selector(cashierBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 确认收款 */
    [self.cashierView.confirmationCollectionBtn addTarget:self action:@selector(cashierBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cashierView];
    @weakify(self)
    [self.cashierView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    // 保存默认服务师傅
    self.serviceMasterModel = self.merchantInfo;
}

#pragma mark - 自定义方法
// 按照车牌号或者手机号，请求用户信息
- (void)accordingToPlnPerhapsPhoneRequestUserInfoReplacementString:(NSString *)string {
    // 判断是输入内容,不是删除内容
    if (string && string.length != 0) {
        // 拼接textField内容和输入内容
        PDLog(@"%@", self.cashierView.queryTF.text);
        NSString *tfText = [[NSString alloc] init];
        if (self.plnPhoto) { // 判断是不是扫描
            tfText = self.cashierView.queryTF.text;
        }else {
            tfText = [self.cashierView.queryTF.text stringByAppendingString:string];
        }
        // 根据输入信息，请求用户信息
        [self foundationTextFieldInfoRequestUserInfo:tfText];
    }
}

// 根据输入信息，请求用户信息
- (void)foundationTextFieldInfoRequestUserInfo:(NSString *)tfText {
    // 判断搜索框输入手机号格式限制或搜索框输入车牌号格式限制
    if ([CustomObject checkTel:tfText] || [CustomObject isPlnNumber:tfText]) {
        /*/index.php?c=provider_user_card&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_input 	string 	否 	用户输入的值(支付时获取卡信息必传)     */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"user_input"] = tfText; // 用户输入的值
        [CashierUserModel foundationUserPhoneObtainUserInfoParams:params success:^(CashierUserModel *cashierUserModel) {
            [MBProgressHUD hideHUD];
            // 保存收银用户信息用户信息
            self.cashierUserModel = cashierUserModel;
            // 保存用户会员卡列表
            self.userCardListArray = (NSMutableArray *)cashierUserModel.cards;
            // 判断会员卡信息是否完善
            if (self.cashierUserModel.user_info.is_completed == 0) {
                [self.cashierView.userInfoView setHidden:YES];
            }else {
                [self.cashierView.userInfoView setHidden:NO];
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
                    make.top.equalTo(self.cashierView.textFieldView.mas_bottom).offset(-5);
                    make.left.equalTo(self.cashierView.mas_left).offset(16);
                    make.right.equalTo(self.cashierView.mas_right).offset(-16);
                    make.bottom.equalTo(premiumView.containerImage.mas_bottom);
                }];
            }
            // 界面赋值
            [self cashierAssignment];
        }];
    }
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
    for (UserMemberCardModel *userCard in self.userCardListArray) {
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
// 生成支付参数
- (NSMutableDictionary *)payNetwork {
    /*/index.php?c=order&a=add&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	否 	登陆者id， APP 必传,微信不传
     sale_user_id 	int 	否 	销售者id， APP 必传,微信不传
     goods_category_id 	int 	是 	商品分类id
     goods_id 	int 	是 	商品id
     provider_user_id 	int 	是 	用户id
     goods_name 	string 	是 	商品名称
     buy_num 	int 	是 	购买数量
     pay_amount 	string 	是 	支付方式:格式--支付方式_支付金额_卡号，(无卡的卡号为00000000) 1.支付宝 2.微信 3.次数 4.eb 5.账户余额 6.现金或刷卡 7-年卡
     save_amount 	string 	是 	优惠金额      */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id，
    params[@"sale_user_id"] = self.serviceMasterModel.staff_user_id; //销售者id
    params[@"goods_category_id"] = [NSString stringWithFormat:@"%ld", self.defaultService.goods_category_id]; // 商品分类id
    params[@"goods_id"] = [NSString stringWithFormat:@"%ld", self.defaultCommodity.goods_id]; // 商品id
    params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.cashierUserModel.user_info.provider_user_id]; // 用户id
    params[@"goods_name"] = self.defaultCommodity.name; // 商品名称
    params[@"buy_num"] = self.cashierView.numberOperationBtn.numTF.text; // 购买数量
    params[@"pay_amount"] = [NSString stringWithFormat:@"%ld_%@_000000", self.payMethodModel.pay_method_id, self.cashierView.priceView.viceTextFiled.text]; // 支付方式
    // 计算优惠金额
    double discountMoney = self.defaultCommodity.sale_price *  [self.cashierView.numberOperationBtn.numTF.text integerValue] - [self.cashierView.priceView.viceTextFiled.text doubleValue];
    params[@"save_amount"] = [NSString stringWithFormat:@"%.2f", discountMoney]; // 优惠金额
    return params;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
