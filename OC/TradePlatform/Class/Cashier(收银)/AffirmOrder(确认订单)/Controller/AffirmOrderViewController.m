//
//  AffirmOrderViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AffirmOrderViewController.h"
// view
#import "AffirmOrderView.h"
#import "CashierServiceChoiceView.h"
// 下级控制器
#import "CardChoiceViewController.h"
#import "PayQRCodeViewController.h"
#import "PaySuccessViewController.h"
// 网络请求
#import "CashierPayNetwork.h"
#import "ShoppingCartModel.h"

@interface AffirmOrderViewController ()<CashierServiceChoiceDelegate>

/** 确认订单view */
@property (strong, nonatomic) AffirmOrderView *affirmOrderView;
/** 支付方式数据 */
@property (strong, nonatomic) NSMutableArray *payMethodArray;
/** 选择的支付方式 */
@property (strong, nonatomic) PaymentMethodModel *payMethodModel;
/** 默认选择服务类型 */
@property (strong, nonatomic) ServiceProviderModel *defaultService;
/** 默认选择商品类型 */
@property (strong, nonatomic) CommodityShowStyleModel *defaultCommodity;

@end

@implementation AffirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self affirmOrderLayoutNAV];
    // 布局视图
    [self affirmOrderLayoutView];
    // 界面赋值
    [self affirmOrderAssignment];
    // 请求购买方式
    [self requestPaymentMethodData];
    // 判断页面来源
    if (self.viewSource == PendOrderAffirmOrderViewSource) { // 挂单
        // 请求收银用户信息和收银商品信息
        [self requestCashierUserGoodsData];
    }
}
#pragma mark - 网络请求
// 请求购买方式
- (void)requestPaymentMethodData {
    [PaymentMethodModel requestPaymentMethodSuccess:^(NSMutableArray *paymentMethodArray) {
        // 保存支付方式数据
        self.payMethodArray = paymentMethodArray;
    }];
}

// 请求收银用户信息
- (void)requestCashierUserGoodsData {
    /*/index.php?c=provider_user_card&a=list&v=1
     provider_id 	int 	是 	服务商id
     mobile 	string 	是 	手机号
     car_plate_no 	string 	是 	车牌号      */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"mobile"] = self.userPhone; // 手机号
    params[@"car_plate_no"] = self.userPln; // 车牌号
    [CashierUserModel foundationUserPhoneObtainUserInfoParams:params success:^(CashierUserModel *cashierUserModel) {
        [MBProgressHUD hideHUD];
        // 保存收银用户模型
        self.cashierUserModel = cashierUserModel;
        // 界面赋值
        [self affirmOrderAssignment];
    }];
    // 获取收银商品模型
    ShoppingCartModel *shoppingGoodsModel = [self.goodsArray firstObject];
    // 保存商品类型
    self.defaultService = shoppingGoodsModel.goods_category;
    // 保存商品
    self.defaultCommodity = shoppingGoodsModel.goods;
}


// 服务，服务商品，服务师傅，支付方式，选择代理方法
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
        /** 支付方式选择 */
        self.payMethodModel = [choiceArray objectAtIndex:indexPath.row];
        switch (self.payMethodModel.pay_method_id) {
            case 1: { // 支付宝支付
                NSMutableDictionary *params = [self payNetwork];
                [CashierPayNetwork v2CashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                    PayQRCodeViewController *qr = [[PayQRCodeViewController alloc] init];
                    if (self.viewSource == PendOrderAffirmOrderViewSource) { // 挂单页
                        qr.paySuccessVCSource = PendOrderPaySuccessVCSource;
                    }else if (self.viewSource == PendOrderAffirmOrderViewSource) { // 收银页
                        qr.paySuccessVCSource = CashierAffirmOrderViewSource;
                    }
                    qr.payQRCodePageType = CashierUseVCPageType;
                    // 添加支付金额
                    [responseObject setObject:[NSString stringWithFormat:@"%.2f", self.orderTotal] forKey:@"price_money"];
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
                    if (self.viewSource == PendOrderAffirmOrderViewSource) { // 挂单页
                        qr.paySuccessVCSource = PendOrderPaySuccessVCSource;
                    }else if (self.viewSource == PendOrderAffirmOrderViewSource) { // 收银页
                        qr.paySuccessVCSource = CashierAffirmOrderViewSource;
                    }
                    qr.payQRCodePageType = CashierUseVCPageType;
                    // 添加支付金额
                    [responseObject setObject:[NSString stringWithFormat:@"%.2f", self.orderTotal] forKey:@"price_money"];
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
                cardChoiceVC.defaultCommodity.num = self.defaultCommodity.buy_num;
                /** 成交价格 */
                cardChoiceVC.defaultCommodity.actual_sale_price = self.defaultCommodity.actual_sale_price;
                /** 支付金额 */
                cardChoiceVC.defaultCommodity.total = self.defaultCommodity.buy_num * self.defaultCommodity.actual_sale_price;
                /** 挂单ID */
                cardChoiceVC.cartID = self.cartID;
                /** 行驶里程 */
                cardChoiceVC.mileage = self.mileage;
                /** 下一次保养时间 */
                cardChoiceVC.nextMaintain = self.nextMaintain;
                /** 支付成功页面来源 */
                if (self.viewSource == PendOrderAffirmOrderViewSource) { // 挂单页
                    cardChoiceVC.paySuccessVCSource = PendOrderPaySuccessVCSource;
                }else if (self.viewSource == PendOrderAffirmOrderViewSource) { // 收银页
                    cardChoiceVC.paySuccessVCSource = CashierAffirmOrderViewSource;
                }
                [self.navigationController pushViewController:cardChoiceVC animated:YES];
                break;
            }
            case 6: { // 现金支付
                [AlertAction determineStayLeft:self title:@"现金支付" message:@"请确认您已收到用户的现金/刷卡支付" determineBlock:^{
                    NSMutableDictionary *params = [self payNetwork];
                    [CashierPayNetwork v2CashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                        PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
                        paySuccessVC.userInfo = self.cashierUserModel.user_info;
                        if (self.viewSource == PendOrderAffirmOrderViewSource) { // 挂单页
                            paySuccessVC.paySuccessVCSource = PendOrderPaySuccessVCSource;
                        }else if (self.viewSource == PendOrderAffirmOrderViewSource) { // 收银页 
                            paySuccessVC.paySuccessVCSource = CashierAffirmOrderViewSource;
                        }
                        [self.navigationController pushViewController:paySuccessVC animated:YES];
                    }];
                }];
                break;
            }
            default:
                break;
        }
}
#pragma mark - 首页功能选择按钮
// 确认收银
- (void)affirmCashierBtnAction:(UIButton *)button {
    // 判断会员卡支付是否可用
    [self judgeUserCardWhetherHaveAccess];
    // 弹出支付方式选择
    CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
    payChoiceBoxView.choiceArray = self.payMethodArray;
    payChoiceBoxView.serviceChoice = PayMethodChoiceBtnAction;
    payChoiceBoxView.delegate = self;
    [payChoiceBoxView show];
}

#pragma mark - 界面赋值
- (void)affirmOrderAssignment {
    /** 用户手机号 */
    self.affirmOrderView.userPhoneLabel.text = self.cashierUserModel.user_info.mobile;
    /** 用户车牌号 */
    self.affirmOrderView.userPlnLabel.text = self.cashierUserModel.user_info.car_plate_no;
    // 判断页面来源
    if (self.viewSource == PendOrderAffirmOrderViewSource) { // 挂单
        /** 订单时间 */
        self.affirmOrderView.orderTimeLabel.text = self.orderTime;
    }else {
        /** 订单时间 */
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateTime = [formatter stringFromDate:date];
        self.affirmOrderView.orderTimeLabel.text = dateTime;
    }
    /** 服务信息table数据 */
    self.affirmOrderView.serviceInfoArray = self.goodsArray;
    /** 订单总价 */
    self.affirmOrderView.orderTotalLabel.text = [NSString stringWithFormat:@"%.2f元", self.orderTotal];
    /** 销售价view */
    self.affirmOrderView.pretiumView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.orderTotal];
}


#pragma mark - 布局nav
- (void)affirmOrderLayoutNAV {
    self.navigationItem.title = @"确认收银";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(affirmOrderRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(affirmOrderRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)affirmOrderLayoutView {
    /** 确认订单view */
    self.affirmOrderView = [[AffirmOrderView alloc] init];
    [self.affirmOrderView.affirmCashierBtn addTarget:self action:@selector(affirmCashierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.affirmOrderView];
    @weakify(self)
    [self.affirmOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


#pragma mark - 封装方法
#pragma mark -  生成支付参数
- (NSMutableDictionary *)payNetwork {
    // 初始化一个字符串，保存购物车商品数据
    NSString *goodsData = [[NSString alloc] init];
    // 遍历商品，拼接goods_data
    for (ShoppingCartModel *goodsModel in self.goodsArray) {
        // 拼接商品数据
        NSString *goodsInfo = [NSString stringWithFormat:@"%ld_%ld_%ld_%.2f", goodsModel.goods_category.goods_category_id, goodsModel.goods.goods_id, goodsModel.buy_num, goodsModel.goods.actual_sale_price];
        if (goodsData.length == 0) {
            goodsData = [NSString stringWithFormat:@"%@", goodsInfo];
        }else {
            goodsData = [NSString stringWithFormat:@"%@,%@", goodsData, goodsInfo];
        }
    }
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
    params[@"car_plate_no"] = self.cashierUserModel.user_info.car_plate_no ? self.cashierUserModel.user_info.car_plate_no : @""; // 车牌号
    params[@"goods_data"] = goodsData; // 商品数据
    params[@"pay_amount"] = [NSString stringWithFormat:@"%ld_%.2f_000000", self.payMethodModel.pay_method_id, self.orderTotal]; // 支付方式
    params[@"mileage"] = self.mileage; // 行驶里程
    params[@"next_maintain"] = self.nextMaintain; // 行驶里程
    params[@"cart_id"] = [NSString stringWithFormat:@"%ld", self.cartID]; // 行驶里程
    return params;
}
#pragma mark -  判断会员卡是否可用
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
                NSInteger num = self.defaultCommodity.buy_num;
                // 获取商品购买价格
                NSInteger priceMoney = self.defaultCommodity.actual_sale_price;
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
                        NSInteger num = self.defaultCommodity.buy_num;
                        // 获取商品购买价格
                        NSInteger priceMoney = self.defaultCommodity.actual_sale_price;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
