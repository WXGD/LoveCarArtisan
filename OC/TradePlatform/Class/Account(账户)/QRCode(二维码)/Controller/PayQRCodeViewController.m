//
//  PayQRCodeViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PayQRCodeViewController.h"
#import "UIImage+Extension.h"
#import "CashierPayNetwork.h"
// 下级控制器
#import "OpenCardSuccessViewController.h"
// 模型
#import "PayQRModel.h"
// Socket
@import SocketIO;

@interface PayQRCodeViewController ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *homePageScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *homePageView;


/** 支付金额 */
@property (strong, nonatomic) UILabel *payMoneyLabel;
/** 二维码 */
@property (strong, nonatomic) UIImageView *qrImage;
/** 支付按钮 */
@property (strong, nonatomic) UIButton *payBtn;
/** SocketIO */
@property (strong, nonatomic) SocketIOClient *socket;

@end

@implementation PayQRCodeViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self payQRCodeLayoutNAV];
    // 布局视图
    [self payQRCodeLayoutView];
    // 界面赋值
    [self payQRCodeAssignment];
    // 建立socket链接
    [self establishSocketLink];
}
#pragma mark - 网络请求
// 建立socket链接
- (void)establishSocketLink {
    NSURL* url = [[NSURL alloc] initWithString:@"http://139.196.213.202:9990"];
    self.socket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @NO, @"forcePolling": @YES}];
    [self.socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSString *orderID = [NSString stringWithFormat:@"appOrderPay_%@", self.payParams[@"order_id"]];
        [self.socket emit:@"identify" with:@[orderID]];
    }];
    [self.socket on:@"appOrderPay_success" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [self payBtnAction:nil];
    }];
    [self.socket connect];
}
#pragma mark - 按钮点击方法
// 确认支付
- (void)payBtnAction:(UIButton *)button {
    /** /index.php?c=order&a=order_status&v=1
     order_id 	int 	是 	订单id  */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"order_id"] = self.payParams[@"order_id"]; // 订单id
    [CashierPayNetwork requestThirdPartyQRCodeParams:params success:^(NSMutableDictionary *responseObject) {
        PayQRModel *payQRModel = [PayQRModel mj_objectWithKeyValues:responseObject[@"data"]];
        if (payQRModel.order_status == 1) { // 未支付
            [MBProgressHUD showError:@"订单未支付"];
        }else { // 已完成， 待评价
            // 断开socket链接
            [self.socket disconnect];
            switch (self.payQRCodePageType) {
                    /** 收银页使用 */
                case CashierUseVCPageType: {
                    PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
                    paySuccessVC.userInfo = self.userInfo;
                    paySuccessVC.paySuccessVCSource = self.paySuccessVCSource;
                    [self.navigationController pushViewController:paySuccessVC animated:YES];
                    break;
                }
                    /** 开卡页使用 */
                case OpenCardUseVCPageType: {
                    OpenCardSuccessViewController *openCardSuccessVC = [[OpenCardSuccessViewController alloc] init];
                    openCardSuccessVC.openCardSuccessType = OpenCardUseType;
                    [self.navigationController pushViewController:openCardSuccessVC animated:YES];
                    break;
                }
                    /** 充值页使用 */
                case RechargeUseVCPageType: {
                    OpenCardSuccessViewController *openCardSuccessVC = [[OpenCardSuccessViewController alloc] init];
                    openCardSuccessVC.openCardSuccessType = RechargeUseType;
                    [self.navigationController pushViewController:openCardSuccessVC animated:YES];
                    break;
                }
                default:
                    break;
            }
            // 删除扫一扫界面列表界面
            NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [navViews removeObject:self];
            [self.navigationController setViewControllers:navViews animated:YES];
        }
    }];
}
// nav左边按钮
- (void)payQRCodeNavLeftBtnAction {
    // 断开socket链接
    [self.socket disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 界面赋值
- (void)payQRCodeAssignment {
    self.view.backgroundColor = ThemeColor;
    /** 支付金额 */
    self.payMoneyLabel.text = [NSString stringWithFormat:@"%@元", self.payParams[@"price_money"]];
    /** 二维码 */
    [self.qrImage setImageWithImageUrl:self.payParams[@"url"] perchImage:@"placeholder_logo"];
}


#pragma mark - 布局nav
- (void)payQRCodeLayoutNAV {
    self.navigationItem.title = self.navTitle;
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(payQRCodeNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)payQRCodeLayoutView {
    /** 背景scrollview */
    self.homePageScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.homePageScrollView];
    @weakify(self)
    [self.homePageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    /** 填充scrollview的view */
    self.homePageView = [[UIView alloc] init];
    [self.homePageScrollView addSubview:self.homePageView];
    /** 填充scrollview的view */
    [self.homePageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.homePageScrollView.mas_top);
        make.left.equalTo(self.homePageScrollView.mas_left);
        make.bottom.equalTo(self.homePageScrollView.mas_bottom);
        make.right.equalTo(self.homePageScrollView.mas_right);
        make.width.equalTo(self.homePageScrollView.mas_width);
    }];
    
    
    
    // 背景包裹view
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = WhiteColor;
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    [self.homePageView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.homePageView.mas_left).offset(16);
        make.right.equalTo(self.homePageView.mas_right).offset(-16);
        make.top.equalTo(self.homePageView.mas_top).offset(49);
    }];
    // 头部支付金额view
    UIView *headerPayMondyView = [[UIView alloc] init];
    headerPayMondyView.backgroundColor = VCBackgroundTwo;
    [backView addSubview:headerPayMondyView];
    [headerPayMondyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.top.equalTo(backView.mas_top);
        make.height.mas_equalTo(@(80 * HScale));
    }];
    /** 支付金额 */
    self.payMoneyLabel = [[UILabel alloc] init];
    self.payMoneyLabel.textColor = ThemeColor;
    self.payMoneyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];;
    [headerPayMondyView addSubview:self.payMoneyLabel];
    [self.payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerPayMondyView.mas_centerX);
        make.centerY.equalTo(headerPayMondyView.mas_centerY);
    }];
    /** 二维码 */
    self.qrImage = [[UIImageView alloc] init];
    self.qrImage.image = [UIImage imageNamed:@"placeholder_logo"];
    [backView addSubview:self.qrImage];
    [self.qrImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.homePageView.mas_centerX);
        make.top.equalTo(headerPayMondyView.mas_bottom).offset(48);
        make.size.mas_equalTo(CGSizeMake(230, 230));
    }];
    // 底部分割线view
    UIView *bomDividingLineView = [[UIView alloc] init];
    bomDividingLineView.backgroundColor = DividingLine;
    [backView addSubview:bomDividingLineView];
    [bomDividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.top.equalTo(self.qrImage.mas_bottom).offset(84);
        make.height.mas_equalTo(@0.5);
    }];
    /** 支付按钮 */
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.payBtn setTitle:@"确认收款" forState:UIControlStateNormal];
    [self.payBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.payBtn.titleLabel.font = FifteenTypeface;
    [self.payBtn setBackgroundColor:WhiteColor];
    [self.payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.top.equalTo(bomDividingLineView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 填充scrollview的view的高度 */
    [self.homePageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.payBtn.mas_bottom).offset(25);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
