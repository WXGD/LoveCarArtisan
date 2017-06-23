//
//  GrantRecordViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GrantRecordViewController.h"
// view
#import "GrantRecordView.h"
#import "MemberCardNavBtn.h"
#import "CashierServiceChoiceView.h"

@interface GrantRecordViewController ()<CashierServiceChoiceDelegate>

/** 发劵记录view */
@property (strong, nonatomic) GrantRecordView *grantRecordView;
/** 优惠卷种类切换 */
@property (strong, nonatomic) MemberCardNavBtn *cutCouponBtn;

@end

@implementation GrantRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self grantRecordLayoutNAV];
    // 布局视图
    [self grantRecordLayoutView];
    // 界面赋值
    [self editCouponAssignment];
    // 网络请求 请求发劵记录
    [self grantRecordRequestData];
    // 网络请求 请求所有优惠劵种类
    [self requesWholeCouponType];
}

#pragma mark - 网络请求
/** 请求所有优惠劵种类 */
- (void)requesWholeCouponType {
    /*/index.php?c=coupon&a=all_list&v=1
     provider_id 	int 	是 	服务商id
     start 	int 	否 	记录位置,默认0
     status 	int 	否 	优惠券状态: 0-禁用 1-启用 2-过期
     pageSize 	int 	否 	每页显示条数,默认0,显示全部       */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
    // 网络请求
    [CouponGoverModel requesWholeCouponType:params success:^(NSMutableArray *couponListArray) {
        /** 优惠劵数据 */
        self.couponArray = couponListArray;
    }];
}
/** 请求发劵记录 */
- (void)grantRecordRequestData {
    // 初始化请求模型
    GrantRecordModel *grantRecordModel = [[GrantRecordModel alloc] init];
    // 下拉刷新
    @weakify(self)
    self.grantRecordView.grantRecordTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        /*/index.php?c=coupon_grant_record&a=grant_list&v=1
         provider_id 	string 	是 	服务商id
         coupon_id 	int 	否 	优惠券id，全部为0
         user_input 	string 	否 	用户输入的手机号或车牌号       */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"coupon_id"] = [NSString stringWithFormat:@"%ld", self.couponGoverModel.coupon_id]; // 优惠券id
        params[@"user_input"] = self.grantRecordView.couponSearchView.searchTF.text; // 用户输入的手机号或车牌号
        // 网络请求
        [grantRecordModel grantRecordRefresh:self.grantRecordView.grantRecordTable params:params success:^(NSMutableArray *grantRecordArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.grantRecordView.grantRecordArray removeAllObjects];
            // 判断是否有数据
            if (grantRecordArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.grantRecordView.grantRecordTable.mas_centerX);
                        make.centerY.equalTo(self.grantRecordView.grantRecordTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.grantRecordView.grantRecordArray = grantRecordArray;
            }
            [self.grantRecordView.grantRecordTable reloadData];
        }];
    }];
    // 上拉加载
    self.grantRecordView.grantRecordTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /*/index.php?c=coupon_grant_record&a=grant_list&v=1
         provider_id 	string 	是 	服务商id
         coupon_id 	int 	否 	优惠券id，全部为0
         user_input 	string 	否 	用户输入的手机号或车牌号       */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务id
        params[@"coupon_id"] = [NSString stringWithFormat:@"%ld", self.couponGoverModel.coupon_id]; // 优惠券id
        params[@"user_input"] = self.grantRecordView.couponSearchView.searchTF.text; // 用户输入的手机号或车牌号
        // 网络请求
        [grantRecordModel grantRecordLoad:self.grantRecordView.grantRecordTable params:params success:^(NSMutableArray *grantRecordArray) {
            [self.grantRecordView.grantRecordArray addObjectsFromArray:grantRecordArray];
            [self.grantRecordView.grantRecordTable reloadData];
        }];
    }];
    // 马上进入刷新状态
    [self.grantRecordView.grantRecordTable.mj_header beginRefreshing];
}



#pragma mark - 按钮点击方法
/** 搜索发劵记录 */
- (void)searchTFAction:(UITextField *)textField {
    // 判断输入框内容为空，不刷新
    if (textField.text.length == 0) {
        return;
    }
    // 马上刷新发劵记录列表
    [self.grantRecordView.grantRecordTable.mj_header beginRefreshing];
}
/** 优惠卷种类切换 */
- (void)cutCouponBtnAction:(UIButton *)button {
    // 遍历所有优惠劵类型，找到当前选中的优惠劵类型
    for (CouponGoverModel *couponTypeModel in self.couponArray) {
        couponTypeModel.checkMark = NO;
        if (couponTypeModel.coupon_id == self.couponGoverModel.coupon_id) {
            couponTypeModel.checkMark = YES;
        }
    }
    // 弹出支付方式选择
    CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
    payChoiceBoxView.choiceArray = self.couponArray;
    payChoiceBoxView.serviceChoice = CouponTyoeChoiceBtnAction;
    payChoiceBoxView.delegate = self;
    [payChoiceBoxView show];
}
#pragma mark - 切换优惠劵类型
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    self.couponGoverModel = [choiceArray objectAtIndex:indexPath.row];
    // 界面赋值
    [self editCouponAssignment];
    // 优惠卷名称
    self.cutCouponBtn.cardNameLabel.text = self.couponGoverModel.name;
    // 马上进入刷新状态
    [self.grantRecordView.grantRecordTable.mj_header beginRefreshing];
}
#pragma mark - 界面赋值
- (void)editCouponAssignment {
    /** 优惠金额 */
    self.grantRecordView.couponInfoView.couponSumLabel.text = [NSString stringWithFormat:@"%.2f", self.couponGoverModel.money];
    /** 使用条件 */
    if (self.couponGoverModel.full_money == 0) {
        self.grantRecordView.couponInfoView.useConditionLabel.text = [NSString stringWithFormat:@"满%.2f可用", self.couponGoverModel.full_money];
    }
    /** 优惠券名称 */
    self.grantRecordView.couponInfoView.couponNameLabel.text = self.couponGoverModel.name;
    /** 优惠券使用周期 */
    if (self.couponGoverModel.grant_end_time.length == 0) {
        self.grantRecordView.couponInfoView.couponTimeLabel.text = @"不限期";
    }else {
        self.grantRecordView.couponInfoView.couponTimeLabel.text = [NSString stringWithFormat:@"限%@至%@使用", self.couponGoverModel.grant_start_time, self.couponGoverModel.grant_end_time];
    }
}


#pragma mark - 布局nav
- (void)grantRecordLayoutNAV {
    /** 优惠卷种类切换 */
    self.cutCouponBtn = [[MemberCardNavBtn alloc] init];
    // 优惠卷名称
    self.cutCouponBtn.cardNameLabel.text = self.couponGoverModel.name;
    [self.cutCouponBtn addTarget:self action:@selector(cutCouponBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.cutCouponBtn;
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_account_account_bank"] style:UIBarButtonItemStyleDone target:self action:@selector(bankCardManagement)];
}

#pragma mark - 布局视图
- (void)grantRecordLayoutView {
    /** 发劵记录view */
    self.grantRecordView = [[GrantRecordView alloc] init];
    /** 搜索发劵记录 */
    [self.grantRecordView.couponSearchView.searchTF addTarget:self action:@selector(searchTFAction:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.grantRecordView];
    @weakify(self)
    [self.grantRecordView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
