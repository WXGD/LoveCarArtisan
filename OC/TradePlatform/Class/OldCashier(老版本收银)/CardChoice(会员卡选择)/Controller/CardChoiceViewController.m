//
//  CardChoiceViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardChoiceViewController.h"
#import "CardChoiceView.h"
#import "UserMemberCardModel.h"
// 网络请求
#import "CashierPayNetwork.h"
// 下级控制器
#import "PaySuccessViewController.h"

@interface CardChoiceViewController ()<CardChoicedidSelectDelegate>

/** 会员卡选择View */
@property (strong, nonatomic) CardChoiceView *cardChoiceView;

@end

@implementation CardChoiceViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self cardChoiceLayoutNAV];
    // 布局视图
    [self cardChoiceLayoutView];
    // 网络请求
    [self cardChoiceRequestData];
}
#pragma mark - 网络请求
- (void)cardChoiceRequestData {
    // 判断是否从外部传入了会员卡
    if (self.userCardListArray) {
        self.cardChoiceView.cardArray = self.userCardListArray;
        [self.cardChoiceView.cardTableView reloadData];
    }
}
#pragma mark - 按钮点击方法
- (void)cardChoiceBtnAction:(UIButton *)button {
    
    
}
// 会员卡选中
- (void)cardChoicedidSelectAction:(NSIndexPath *)indexPath {
    UserMemberCardModel *userCard =self.userCardListArray[indexPath.section][indexPath.row];
    if (self.userCardListArray) {
        if (userCard.is_used) {
            [AlertAction determineStayLeft:self title:@"会员卡支付" message:@"订单生成后无法撤消，您确认要支付吗？" determineBlock:^{
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
                params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userInfo.provider_user_id]; // 用户id
                params[@"goods_name"] = self.defaultCommodity.name; // 商品名称
                params[@"buy_num"] = [NSString stringWithFormat:@"%ld", (long)self.defaultCommodity.num]; // 购买数量
                params[@"save_amount"] = [NSString stringWithFormat:@"%.2f", self.defaultCommodity.saveAmount]; // 优惠金额
                if (userCard.card_category_id == 1) { // 次卡
                    params[@"pay_amount"] = [NSString stringWithFormat:@"3_%ld_%@", self.defaultCommodity.num * self.defaultCommodity.card_num_price, userCard.card_no]; // 支付方式
                }else if (userCard.card_category_id == 2) { // 金额卡
                    params[@"pay_amount"] = [NSString stringWithFormat:@"4_%.2f_%@", self.defaultCommodity.total, userCard.card_no]; // 支付方式
                }else if (userCard.card_category_id == 3) { // 年卡
                    params[@"pay_amount"] = [NSString stringWithFormat:@"7_%.2f_%@", self.defaultCommodity.total, userCard.card_no]; // 支付方式
                }
                [CashierPayNetwork cashierPayParams:params success:^(NSMutableDictionary *responseObject) {
                    PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
                    paySuccessVC.userInfo = self.userInfo;
                    [self.navigationController pushViewController:paySuccessVC animated:YES];
                    // 删除会员卡列表界面
                    NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                    [navViews removeObject:self];
                    [self.navigationController setViewControllers:navViews animated:YES];
                }];
            }];
        }
    }
}

#pragma mark - 界面赋值
- (void)cardChoiceAssignment {
    
}
#pragma mark - 布局nav
- (void)cardChoiceLayoutNAV {
    self.navigationItem.title = @"会员卡列表";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)cardChoiceLayoutView {
    @weakify(self)
    /** 会员卡选择View */
    self.cardChoiceView = [[CardChoiceView alloc] init];
    self.cardChoiceView.delegate = self;
    [self.view addSubview:self.cardChoiceView];
    [self.cardChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
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
