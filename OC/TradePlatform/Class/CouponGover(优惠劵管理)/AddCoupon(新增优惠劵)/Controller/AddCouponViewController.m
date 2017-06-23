//
//  AddCouponViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCouponViewController.h"
// view
#import "AddCouponView.h"
// 网络请求
#import "AddCouponNetwork.h"
// 下级控制器
#import "CardApplyViewController.h"

@interface AddCouponViewController ()

/** 新增优惠劵view */
@property (strong, nonatomic) AddCouponView *addCouponView;
/** 适用范围ID */
@property (copy, nonatomic) NSString *applyID;
/** 选中的商品 */
@property (strong, nonatomic) NSMutableArray *chooseCommodityArray;
/** 选中的服务 */
@property (strong, nonatomic) NSMutableArray *chooseServiceArray;
/** 全部服务商品 */
@property (strong, nonatomic) NSMutableArray *wholeCommodityArray;

@end

@implementation AddCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self addCouponLayoutNAV];
    // 布局视图
    [self addCouponLayoutView];
}

#pragma mark - 按钮点击
// nav右边按钮，保存
- (void)addCouponNavRightBtnAction {
    /*/index.php?c=coupon&a=add&v=1
     provider_id 	int 	是 	服务商id
     name 	string 	是 	优惠券名称
     description 	string 	否 	描述
     money 	float 	是 	面值
     full_money 	float 	否 	满多少钱可用
     grant_start_time 	string 	是 	发放开始时间
     grant_end_time 	string 	否 	发放结束时间，默认为0000-00-00 00:00
     num 	int 	否 	发放总数量，默认为0，不限制
     limit_num_type 	int 	否 	发放限制：0-不限制，一人可领多张 1-限制一人只能领一张 ,默认为0
     expire_day 	int 	否 	领取之后可以可使用天数,默认为0，不限制
     rules 	string 	是 	适用服务，默认为‘’，格式： goods_id=1,goods_id=2,goods_category_id=1..        */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
    params[@"name"] = self.addCouponView.couponNameView.viceTF.text; // 优惠券名称
    params[@"description"] = self.addCouponView.descContentTV.text; // 描述
    params[@"money"] = self.addCouponView.couponPoundView.viceTF.text; // 面值
    params[@"full_money"] = self.addCouponView.couponUseCondView.viceTF.text; // 满多少钱可用
    params[@"grant_start_time"] = self.addCouponView.couponOpenTimeView.rightViceLabel.text; // 发放开始时间
    params[@"grant_end_time"] = self.addCouponView.couponEndTimeView.rightViceLabel.text; // 发放结束时间
    params[@"num"] = self.addCouponView.couponTotalView.viceTF.text; // 发放总数量
    params[@"limit_num_type"] = self.addCouponView.isOnlySwitch.on ? @1 : @0; // 发放限制
    params[@"expire_day"] = self.addCouponView.couponExpiryDateView.viceTF.text; // 发放总数量
    params[@"rules"] = self.applyID; // 适用服务
    [AddCouponNetwork addCoupon:params success:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
/** 优惠卷适用服务 */
- (void)couponApplyBtnAction:(UIButton *)button {
    CardApplyViewController *cardApplyVC = [[CardApplyViewController alloc] init];
    cardApplyVC.cardApplyUseType = AddCardUseType;
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
            self.addCouponView.couponApplyLabel.text = @"全部服务";
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
            self.addCouponView.couponApplyLabel.text = apply;
        }
    };
    /** 选中的商品 */
    cardApplyVC.chooseCommodityArray = self.chooseCommodityArray;
    /** 选中的服务 */
    cardApplyVC.chooseServiceArray = self.chooseServiceArray;
    /** 全部服务商品 */
    cardApplyVC.wholeCommodityArray = self.wholeCommodityArray;
    [self.navigationController pushViewController:cardApplyVC animated:YES];
}

#pragma mark - 布局nav
- (void)addCouponLayoutNAV {
    self.navigationItem.title = @"新增优惠劵";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(addCouponNavRightBtnAction)];
}

#pragma mark - 布局视图
- (void)addCouponLayoutView {
    /** 新增优惠劵view */
    self.addCouponView = [[AddCouponView alloc] init];
    /** 优惠卷适用服务 */
    [self.addCouponView.couponApplyView.mainBtn addTarget:self action:@selector(couponApplyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addCouponView];
    @weakify(self)
    [self.addCouponView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
