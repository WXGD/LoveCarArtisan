//
//  EditCouponViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCouponViewController.h"
// view
#import "EditCouponView.h"
// 请求优惠劵可用服务
#import "AllGoodsHandle.h"
// 网络请求
#import "EditCouponNetwork.h"
// 下级控制器
#import "CardApplyViewController.h"

@interface EditCouponViewController ()

/** 编辑优惠劵view */
@property (strong, nonatomic) EditCouponView *editCouponView;
/** 适用范围ID */
@property (copy, nonatomic) NSString *applyID;
/** 选中的商品 */
@property (strong, nonatomic) NSMutableArray *chooseCommodityArray;
/** 选中的服务 */
@property (strong, nonatomic) NSMutableArray *chooseServiceArray;
/** 全部服务商品 */
@property (strong, nonatomic) NSMutableArray *wholeCommodityArray;

@end

@implementation EditCouponViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self editCouponLayoutNAV];
    // 布局视图
    [self editCouponLayoutView];
    // 界面赋值
    [self editCouponAssignment];
}
#pragma mark - 按钮点击
// nav右边按钮，保存
- (void)editCouponNavRightBtnAction {
    /*/index.php?c=coupon&a=edit&v=1
     provider_id 	int 	是 	服务商id
     coupon_id 	int 	是 	优惠券id
     description 	string 	是 	描述
     grant_start_time 	string 	是 	发放开始时间
     grant_end_time 	string 	是 	发放结束时间
     num 	int 	是 	发放总数量
     limit_num_type 	int 	是 	发放限制：0-不限制，一人可领多张 1-限制一人只能领一张
     expire_day 	int 	是 	领取之后可以可使用天数,默认为0，不限制
     rules 	string 	是 	适用服务，默认为‘’，格式： goods_id=1,goods_id=2,goods_category_id=1..        */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
    params[@"coupon_id"] = [NSString stringWithFormat:@"%ld", self.couponGoverModel.coupon_id]; // 优惠券id
    params[@"description"] = self.editCouponView.descContentTV.text; // 描述
    params[@"grant_start_time"] = self.editCouponView.couponOpenTimeView.rightViceLabel.text; // 发放开始时间
    params[@"grant_end_time"] = [self.editCouponView.couponEndTimeView.rightViceLabel.text isEqualToString:@"不限期"] ? @"" : self.editCouponView.couponEndTimeView.rightViceLabel.text; // 发放结束时间
    params[@"num"] = [NSString stringWithFormat:@"%ld", [self.editCouponView.couponTotalView.viceTF.text integerValue]]; // 发放总数量
    params[@"limit_num_type"] = self.editCouponView.isOnlySwitch.on ? @1 : @0; // 发放限制
    params[@"expire_day"] = [NSString stringWithFormat:@"%ld", [self.editCouponView.couponExpiryDateView.viceTF.text integerValue]]; // 发放总数量
    params[@"rules"] = self.applyID ? self.applyID: @""; // 适用服务
    [EditCouponNetwork editCoupon:params success:^{
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
            self.editCouponView.couponApplyLabel.text = @"全部服务";
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
            self.editCouponView.couponApplyLabel.text = apply;
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


#pragma mark - 界面赋值
- (void)editCouponAssignment {
    /** 优惠卷名称 */
    self.editCouponView.couponNameView.rightViceLabel.text = self.couponGoverModel.name;
    /** 优惠卷面值 */
    self.editCouponView.couponPoundView.rightViceLabel.text = [NSString stringWithFormat:@"%.2f", self.couponGoverModel.money];
    /** 优惠卷是否只能领一张开关 */
    self.editCouponView.isOnlySwitch.on = self.couponGoverModel.limit_num_type;
    /** 优惠卷开放时间 */
    self.editCouponView.couponOpenTimeView.rightViceLabel.text = self.couponGoverModel.grant_start_time;
    /** 优惠卷结束时间 */
    if (self.couponGoverModel.grant_end_time.length == 0) {
        self.editCouponView.couponEndTimeView.rightViceLabel.text = @"不限期";
    }else {
        self.editCouponView.couponEndTimeView.rightViceLabel.text = self.couponGoverModel.grant_end_time;
    }
    /** 优惠卷发放数量 */
    if (self.couponGoverModel.num == 0) {
        self.editCouponView.couponTotalView.viceTF.text = @"不限制";
    }else {
        self.editCouponView.couponTotalView.viceTF.text = [NSString stringWithFormat:@"%ld", self.couponGoverModel.num];
    }
    /** 优惠卷有效天数 */
    if (self.couponGoverModel.expire_day == 0) {
        self.editCouponView.couponExpiryDateView.viceTF.text = @"不限制";
    }else {
        self.editCouponView.couponExpiryDateView.viceTF.text = [NSString stringWithFormat:@"%ld", self.couponGoverModel.expire_day];
    }
    /** 优惠卷描述内容 */
    self.editCouponView.descContentTV.text = self.couponGoverModel.descri;
    self.editCouponView.descContentTV.textColor = GrayH1;
    /** 优惠卷适用服务 */
    [self obtainCouponAppropriateServiceAddGoodsName];
}
#pragma mark - 布局nav
- (void)editCouponLayoutNAV {
    self.navigationItem.title = @"编辑优惠劵";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(editCouponNavRightBtnAction)];
}

#pragma mark - 布局视图
- (void)editCouponLayoutView {
    /** 编辑优惠劵view */
    self.editCouponView = [[EditCouponView alloc] init];
    /** 优惠卷适用服务 */
    [self.editCouponView.couponApplyView.mainBtn addTarget:self action:@selector(couponApplyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editCouponView];
    @weakify(self)
    [self.editCouponView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


#pragma mark - 封装方法
// 获取优惠卷对应服务和商品名称
- (void)obtainCouponAppropriateServiceAddGoodsName {
    // 初始化服务数组
    self.chooseServiceArray = [[NSMutableArray alloc] init];
    // 初始化商品数组
    self.chooseCommodityArray = [[NSMutableArray alloc] init];
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    [AllGoodsHandle sharedInstance].requestSuccessBlock = ^ (NSMutableArray *allGoodsArray) {
        // 判断卡可用服务ID是否为空
        if (self.couponGoverModel.all_service.goods_category_id.count == 0 && self.couponGoverModel.all_service.goods_id.count == 0) {
            self.editCouponView.couponApplyLabel.text = @"全部服务";
        }else {
            // 初始化两个字符串
            NSString *apply = [[NSString alloc] init];
            NSString *applyID = [[NSString alloc] init];
            // 遍历该卡对应的服务商品，拼接适用范围ID
            for (ServiceProviderModel *serviceModel in allGoodsArray) {
                // 遍历保存的服务ID
                for (NSString *serviceID  in self.couponGoverModel.all_service.goods_category_id) {
                    if ([serviceID integerValue] == serviceModel.goods_category_id) {
                        /** 选中标记 */
                        serviceModel.checkMark = YES;
                        // 保存选中服务
                        [self.chooseServiceArray addObject:serviceModel];
                        // 拼接适用服务字段
                        apply = [apply stringByAppendingFormat:@"%@,", serviceModel.name];
                        // 拼接适用服务id
                        applyID = [applyID stringByAppendingFormat:@"goods_category_id=%ld,", serviceModel.goods_category_id];
                    }
                }
                for (CommodityShowStyleModel *goodsModel in serviceModel.goods) {
                    for (NSString *goodsID in self.couponGoverModel.all_service.goods_id) {
                        // 判断是否包含本服务
                        if ([goodsID integerValue] == goodsModel.goods_id) {
                            /** 选中标记 */
                            goodsModel.checkMark = YES;
                            // 保存选中商品
                            [self.chooseCommodityArray addObject:goodsModel];
                            // 拼接适用服务字段
                            apply = [apply stringByAppendingFormat:@"%@,", goodsModel.name];
                            // 拼接适用服务id
                            applyID = [applyID stringByAppendingFormat:@"goods_id=%ld,", goodsModel.goods_id];
                        }
                    }
                }
            }
            // 保护，避免因为字符串为空，崩溃
            if (apply.length != 0) {
                apply = [apply substringToIndex:[apply length]-1];
                self.editCouponView.couponApplyLabel.text = apply;
            }
            // 保护，避免因为字符串为空，崩溃
            if (applyID.length != 0) {
                applyID = [applyID substringToIndex:[applyID length]-1];
                self.applyID = applyID;
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
