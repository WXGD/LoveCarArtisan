//
//  orderInfoInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "OrderInfoView.h"
// 下级控制器
#import "UserInfoViewController.h"

@interface OrderInfoViewController ()

/** 订单view */
@property (strong, nonatomic) OrderInfoView *orderInfoView;
/** 订单信息模型 */
@property (strong, nonatomic) OrderInfoModel *orderInfoModel;

@end

@implementation OrderInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self orderInfoLayoutNAV];
    // 网络请求
    [self orderInfoRequestData];
}
#pragma mark - 网络请求
- (void)orderInfoRequestData {
    [OrderInfoModel requestOrderInfoOrderNo:self.orderID success:^(OrderInfoModel *orderModel) {
        /** 订单信息模型 */
        self.orderInfoModel = orderModel;
        // 布局视图
        [self orderInfoLayoutViewOrderModel:orderModel];
        // 界面赋值
        [self orderInfoAssignmentOrderModel:orderModel];
    }];
}
#pragma mark - 按钮点击方法
// 客户信息按钮点击方法
- (void)userInfoBtnAvtion:(UIButton *)button {
    // 判断用户是否被删除
    if (self.orderInfoModel.user_info.status == -1) {

    }else {
        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
        userInfoVC.providerUserId = [NSString stringWithFormat:@"%ld", self.orderInfoModel.user_info.provider_user_id];
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }
}
#pragma mark - 界面赋值
- (void)orderInfoAssignmentOrderModel:(OrderInfoModel *)orderModel {
    /*================== 订单信息  ================*/
    /** 服务师傅 */
    self.orderInfoView.serveMasterView.describeLabel.text = orderModel.order_info.sale_user;
    /*================== 头部 ================*/
    /** 状态 */
    /** 订单状态(1未支付，2待使用，3待评价，4已完成 6退款) */
    switch (orderModel.order_info.order_status) {
        case 1: {
            self.orderInfoView.orderType.text = @"未支付";
            /** 实收 */
            self.orderInfoView.thePaidView.cellLabel.text = @"需付款";
            break;
        }
        case 2: {
            self.orderInfoView.orderType.text = @"待使用";
            /** 服务师傅 */
            self.orderInfoView.serveMasterView.describeLabel.text = @"无";
            break;
        }
        case 3: {
            self.orderInfoView.orderType.text = @"待评价";
            break;
        }
        case 4: {
            self.orderInfoView.orderType.text = @"已完成";
            break;
        }
        case 6: {
            self.orderInfoView.orderType.text = @"退款";
            break;
        }
        default:
            break;
    }
    /** 订单号 */
    self.orderInfoView.orderNum.rightText.text = orderModel.order_info.order_no;
    /*================== 客户信息  ================*/
    /** 客户信息view */
    // 判断用户是否被删除
    if (self.orderInfoModel.user_info.status == -1) {
        [self.orderInfoView.delUserSign setHidden:NO];
    }
    self.orderInfoView.userInfo.cellLabel.text = orderModel.user_info.name;
    self.orderInfoView.userInfo.viceLabel.text = orderModel.user_info.mobile;
    /** 车牌号 */
    if (orderModel.user_info.car_plate_no.length == 0) {
        [self.orderInfoView.plnView setHidden:YES];
    }
    self.orderInfoView.plnLabel.text = orderModel.user_info.car_plate_no;
    /*================== 服务详情  ================*/
    /** 总价 */
    self.orderInfoView.priceView.describeLabel.text = [NSString stringWithFormat:@"%.2f元", orderModel.order_info.total_price];
    /** 优惠 */
    self.orderInfoView.discountView.describeLabel.text = [NSString stringWithFormat:@"%.2f元", orderModel.order_info.save_amount];
    /** 实收 */
    self.orderInfoView.thePaidView.describeLabel.text = [NSString stringWithFormat:@"%@", orderModel.order_pay_info.pay_amount_text];
    /*================== 订单信息  ================*/
    /** 支付方式 */
    self.orderInfoView.paymentView.describeLabel.text = orderModel.order_pay_info.pay_method_text;
    /** 交易号 */
    self.orderInfoView.tradeNumView.describeLabel.text = orderModel.order_pay_info.pay_no;
    // 1  #支付方式 1-支付宝 2-微信 3或4-卡支付 6-现金
    switch (orderModel.order_info.pay_method_id) {
        case 3: {
            /** 交易号 */
            self.orderInfoView.tradeNumView.cellLabel.text = @"会员卡号";
            break;
        }
        case 4: {
            /** 交易号 */
            self.orderInfoView.tradeNumView.cellLabel.text = @"会员卡号";
            break;
        }
        default:
            break;
    }
    /** 收银员 */
    self.orderInfoView.cashierView.describeLabel.text = orderModel.order_info.staff_user;
    /** 下单时间 */
    self.orderInfoView.placeOrderTimeView.describeLabel.text = orderModel.order_info.create_time;
    /** 付款时间 */
    self.orderInfoView.payTimeView.describeLabel.text = orderModel.order_info.pay_time;
    /*================== 用户评价  ================*/
    // 判断有订单评论信息
    if (orderModel.order_comment) { // 有评论信息
        /** 评分 */
        self.orderInfoView.ratedScoreLabel.text = [NSString stringWithFormat:@"%.1f分", orderModel.order_comment.score];
        /** 评星 */
        self.orderInfoView.atedStarView.scorePercent = orderModel.order_comment.score / 5.0;
        /** 评价内容 */
        self.orderInfoView.contentLabel.text = [NSString stringWithFormat:@"%@ ", orderModel.order_comment.content];
    }else { // 没有支付信息
        // 删除评论view
        /** 订单分割线 */
        [self.orderInfoView.orderLineView removeFromSuperview];
        [self.orderInfoView.orderInfoBackView removeArrangedSubview:self.orderInfoView.orderLineView];
        /** 用户评价标题 */
        [self.orderInfoView.ratedTitleView removeFromSuperview];
        [self.orderInfoView.orderInfoBackView removeArrangedSubview:self.orderInfoView.ratedTitleView];
        /** 用户评价View */
        [self.orderInfoView.ratedView removeFromSuperview];
        [self.orderInfoView.orderInfoBackView removeArrangedSubview:self.orderInfoView.ratedView];
    }
}
#pragma mark - 布局nav
- (void)orderInfoLayoutNAV {
    self.navigationItem.title = @"订单详情";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsorderInfoRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)orderInfoLayoutViewOrderModel:(OrderInfoModel *)orderModel {
    /** 账户view */
    self.orderInfoView = [[OrderInfoView alloc] init];
    /** 服务内容数据 */
    self.orderInfoView.serviceTableArray = (NSMutableArray *)orderModel.order_detail;
    /** 客户信息view */
    [self.orderInfoView.userInfo.usedCellBtn addTarget:self action:@selector(userInfoBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.orderInfoView];
    @weakify(self)
    [self.orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
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
