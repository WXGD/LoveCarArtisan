//
//  SurplusLackViewController.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

// 页面类型
typedef NS_ENUM(NSInteger, SurplusLackViewType) {
    /** 余额不足 */
    BalanceNotEnoughType,
    /** 余次不足 */
    NumNotEnoughType,
};


#import "SurplusLackViewController.h"
// view
#import "SurplusLackView.h"
#import "CashierServiceChoiceView.h"
// 模型
#import "ExpireModel.h"
#import "ExpircUserModel.h"
// 控制器
#import "ReviseRangeViewController.h"

@interface SurplusLackViewController ()<SurplusLackDelegate, CashierServiceChoiceDelegate>

/** 余额／余次view */
@property (strong, nonatomic) SurplusLackView *surplusLackView;
/** 余额区间数据 */
@property (strong, nonatomic) NSMutableArray *balanceSectionArray;
/** 余额列表数据 */
@property (strong, nonatomic) NSMutableArray *balanceSectionListArray;
/** 余次区间数据 */
@property (strong, nonatomic) NSMutableArray *leaveSecondSectionArray;
/** 余次列表数据 */
@property (strong, nonatomic) NSMutableArray *leaveSecondSectionListArray;
/** 当前选中余额区间 */
@property (strong, nonatomic) ExpireModel *defaultBalanceSection;
/** 当前选中余额区间 */
@property (strong, nonatomic) ExpireModel *defaultLeaveSecondSection;

@end

@implementation SurplusLackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self surplusLackLayoutNAV];
    // 布局视图
    [self surplusLackLayoutView];
    // 请求余额区间用户数据
    [self balanceExpireUserRepuestData];
    // 请求余次区间用户数据
    [self leaveSecondExpireUserRepuestData];
    // 数据请求
    [self surplusLackRepuestData:BalanceNotEnoughType];
}
#pragma mark - 网络请求
- (void)surplusLackRepuestData:(SurplusLackViewType)viewType {
    /* /index.php?c=user_track&a=section&v=1
     provider_id 	int 	是 	服务商id
     type 	int 	是 	获取区间的类型 1-会员卡到期区间 2-会员卡余额不足区间 3-会员卡余次不足区间 4-会员长期未到店区间 5-用户消费区间  */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"type"] = viewType == BalanceNotEnoughType ? @2 : @3; // 区间的类型
    [ExpireModel requestDataSection:params success:^(NSMutableArray *sectionArray) {
            switch (viewType) {
                    /** 余额不足 */
                case BalanceNotEnoughType: {
                    // 保存余额区间数据
                    self.balanceSectionArray = [NSMutableArray arrayWithArray:sectionArray];
                    // 保存余额列表数据
                    self.balanceSectionListArray = [NSMutableArray arrayWithArray:sectionArray];
                    // 添加自定义按钮
                    ExpireModel *expireModel = [[ExpireModel alloc] init];
                    expireModel.max_value = @"自定义";
                    [self.balanceSectionArray addObject:expireModel];
                    // 保存当前选择区间
                    self.defaultBalanceSection = [sectionArray firstObject];
                    if (self.defaultBalanceSection.min_value.length == 0 && self.defaultBalanceSection.max_value.length == 0) {
                        // 展示当前选择区间
                        self.surplusLackView.balanceView.expireHeaderView.seleAreaLabel.text = @"请添加查询区间";
                    }else {
                        // 展示当前选择区间
                        self.surplusLackView.balanceView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~%@%@", self.defaultBalanceSection.min_value, self.defaultBalanceSection.unit, self.defaultBalanceSection.max_value, self.defaultBalanceSection.unit];
                    }
                    // 马上刷新
                    [self.surplusLackView.balanceView.expireTable.mj_header beginRefreshing];
                    break;
                }
                    /** 余次不足 */
                case NumNotEnoughType: {
                    // 保存余次区间数据
                    self.leaveSecondSectionArray = [NSMutableArray arrayWithArray:sectionArray];
                    // 保存余次列表数据
                    self.leaveSecondSectionListArray = [NSMutableArray arrayWithArray:sectionArray];
                    // 添加自定义按钮
                    ExpireModel *expireModel = [[ExpireModel alloc] init];
                    expireModel.max_value = @"自定义";
                    [self.leaveSecondSectionArray addObject:expireModel];
                    // 保存当前选择区间
                    self.defaultLeaveSecondSection = [sectionArray firstObject];
                    if (self.defaultLeaveSecondSection.min_value.length == 0 && self.defaultLeaveSecondSection.max_value.length == 0) {
                        // 展示当前选择区间
                        self.surplusLackView.leaveSecondView.expireHeaderView.seleAreaLabel.text = @"请添加查询区间";
                    }else {
                        // 展示当前选择区间
                        self.surplusLackView.leaveSecondView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~%@%@", self.defaultLeaveSecondSection.min_value, self.defaultLeaveSecondSection.unit, self.defaultLeaveSecondSection.max_value, self.defaultLeaveSecondSection.unit];
                    }
                    // 马上刷新
                    [self.surplusLackView.leaveSecondView.expireTable.mj_header beginRefreshing];
                    break;
                }
                default:
                    break;
            }
    }];
}



// 请求余额区间用户数据
- (void)balanceExpireUserRepuestData {
    ExpircUserModel *expircUserModel = [[ExpircUserModel alloc] init];
    // 下拉刷新
    @weakify(self)
    self.surplusLackView.balanceView.expireTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        /* /index.php?c=user_track&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_track_id 	int 	是 	区间列表id
         start 	int 	否 	开始位置，默认为0
         pageSize 	int 	否 	每页显示条数，默认为10    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"user_track_id"] = [NSString stringWithFormat:@"%ld", (long)self.defaultBalanceSection.user_track_id]; // 区间列表id
        @strongify(self)
        [expircUserModel expircUserRefreshRequestData:params tableView:self.surplusLackView.balanceView.expireTable success:^(NSMutableArray *expircUserArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.surplusLackView.balanceView.expireArray removeAllObjects];
            // 判断是否有数据
            if (expircUserArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.surplusLackView.balanceView.expireTable.mas_centerX);
                        make.centerY.equalTo(self.surplusLackView.balanceView.expireTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.surplusLackView.balanceView.expireArray = expircUserArray;
            }
            [self.surplusLackView.balanceView.expireTable reloadData];
        }];
    }];
    // 上拉加载
    self.surplusLackView.balanceView.expireTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /* /index.php?c=user_track&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_track_id 	int 	是 	区间列表id
         start 	int 	否 	开始位置，默认为0
         pageSize 	int 	否 	每页显示条数，默认为10    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"user_track_id"] = [NSString stringWithFormat:@"%ld", (long)self.defaultBalanceSection.user_track_id]; // 区间列表id
        // 网络请求
        [expircUserModel expircUserLoadRequestData:self.surplusLackView.balanceView.expireTable params:params viewController:self success:^(NSMutableArray *expircUserArray) {
            [self.surplusLackView.balanceView.expireArray addObjectsFromArray:expircUserArray];
            [self.surplusLackView.balanceView.expireTable reloadData];
        }];
    }];
}

// 请求余次区间用户数据
- (void)leaveSecondExpireUserRepuestData {
    ExpircUserModel *expircUserModel = [[ExpircUserModel alloc] init];
    // 下拉刷新
    @weakify(self)
    self.surplusLackView.leaveSecondView.expireTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        /* /index.php?c=user_track&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_track_id 	int 	是 	区间列表id
         start 	int 	否 	开始位置，默认为0
         pageSize 	int 	否 	每页显示条数，默认为10    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"user_track_id"] = [NSString stringWithFormat:@"%ld", (long)self.defaultLeaveSecondSection.user_track_id]; // 区间列表id
        @strongify(self)
        [expircUserModel expircUserRefreshRequestData:params tableView:self.surplusLackView.leaveSecondView.expireTable success:^(NSMutableArray *expircUserArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.surplusLackView.leaveSecondView.expireArray removeAllObjects];
            // 判断是否有数据
            if (expircUserArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.surplusLackView.leaveSecondView.expireTable.mas_centerX);
                        make.centerY.equalTo(self.surplusLackView.leaveSecondView.expireTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.surplusLackView.leaveSecondView.expireArray = expircUserArray;
            }
            [self.surplusLackView.leaveSecondView.expireTable reloadData];
        }];
    }];
    // 上拉加载
    self.surplusLackView.leaveSecondView.expireTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /* /index.php?c=user_track&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_track_id 	int 	是 	区间列表id
         start 	int 	否 	开始位置，默认为0
         pageSize 	int 	否 	每页显示条数，默认为10    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"user_track_id"] = [NSString stringWithFormat:@"%ld", (long)self.defaultLeaveSecondSection.user_track_id]; // 区间列表id
        // 网络请求
        [expircUserModel expircUserLoadRequestData:self.surplusLackView.leaveSecondView.expireTable params:params viewController:self success:^(NSMutableArray *expircUserArray) {
            [self.surplusLackView.leaveSecondView.expireArray addObjectsFromArray:expircUserArray];
            [self.surplusLackView.leaveSecondView.expireTable reloadData];
        }];
    }];
}


#pragma mark - 余额:余次不足功能选择按钮
- (void)surplusLackBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 余额不足 */
        case BalanceNotEnoughBtnAction: {
            // 遍历所有服务，找到当前选中的服务
            for (ExpireModel *expireModel in self.balanceSectionArray) {
                expireModel.checkMark = NO;
                if (expireModel.user_track_id == self.defaultBalanceSection.user_track_id) {
                    expireModel.checkMark = YES;
                }
            }
            // 弹出
            CashierServiceChoiceView *classChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            classChoiceBoxView.choiceArray = self.balanceSectionArray;
            classChoiceBoxView.serviceChoice = BalanceScreenServiceBtnAction;
            classChoiceBoxView.delegate = self;
            [classChoiceBoxView show];
            break;
        }
            /** 余次不足 */
        case NumNotEnoughBtnAction: {
            // 遍历所有服务，找到当前选中的服务
            for (ExpireModel *expireModel in self.leaveSecondSectionArray) {
                expireModel.checkMark = NO;
                if (expireModel.user_track_id == self.defaultLeaveSecondSection.user_track_id) {
                    expireModel.checkMark = YES;
                }
            }
            // 弹出
            CashierServiceChoiceView *classChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            classChoiceBoxView.choiceArray = self.leaveSecondSectionArray;
            classChoiceBoxView.serviceChoice = ThanTimesScreenServiceBtnAction;
            classChoiceBoxView.delegate = self;
            [classChoiceBoxView show];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 区间选择代理方法
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    switch (serviceChoice) {
            /** 余额筛选区间 */
        case BalanceScreenServiceBtnAction: {
            /** 获取选择区间 */
            ExpireModel *expireModel = [choiceArray objectAtIndex:indexPath.row];
            // 判断是不是自定义按钮
            if ([expireModel.max_value isEqualToString:@"自定义"]) {
                ReviseRangeViewController *reviseRangeVC = [[ReviseRangeViewController alloc] init];
                reviseRangeVC.reviseRangeType = BalanceShowType;
                reviseRangeVC.rangeArray = self.balanceSectionListArray;
                reviseRangeVC.AddDataSectionBlock = ^{
                    // 数据请求
                    [self surplusLackRepuestData:BalanceNotEnoughType];
                };
                [self.navigationController pushViewController:reviseRangeVC animated:YES];
                return;
            }
            // 保存当前选择区间
            self.defaultBalanceSection = expireModel;
            // 展示当前选择区间
            if ([self.defaultBalanceSection.max_value doubleValue] == 0) {
                self.surplusLackView.balanceView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~最大值", self.defaultBalanceSection.min_value, self.defaultBalanceSection.unit];
            }else {
                self.surplusLackView.balanceView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~%@%@", self.defaultBalanceSection.min_value, self.defaultBalanceSection.unit, self.defaultBalanceSection.max_value, self.defaultBalanceSection.unit];
            }
            // 马上刷新
            [self.surplusLackView.balanceView.expireTable.mj_header beginRefreshing];
            break;
        }
            /** 余次筛选区间 */
        case ThanTimesScreenServiceBtnAction: {
            /** 获取选择区间 */
            ExpireModel *expireModel = [choiceArray objectAtIndex:indexPath.row];
            // 判断是不是自定义按钮
            if ([expireModel.max_value isEqualToString:@"自定义"]) {
                ReviseRangeViewController *reviseRangeVC = [[ReviseRangeViewController alloc] init];
                reviseRangeVC.reviseRangeType = LeaveSecondShowType;
                reviseRangeVC.rangeArray = self.leaveSecondSectionListArray;
                reviseRangeVC.AddDataSectionBlock = ^{
                    // 数据请求
                    [self surplusLackRepuestData:NumNotEnoughType];
                };
                [self.navigationController pushViewController:reviseRangeVC animated:YES];
                return;
            }
            // 保存当前选择区间
            self.defaultLeaveSecondSection = expireModel;
            // 展示当前选择区间
            if ([self.defaultLeaveSecondSection.max_value doubleValue] == 0) {
                self.surplusLackView.leaveSecondView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~最大值", self.defaultLeaveSecondSection.min_value, self.defaultLeaveSecondSection.unit];
            }else {
                self.surplusLackView.leaveSecondView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~%@%@", self.defaultLeaveSecondSection.min_value, self.defaultLeaveSecondSection.unit, self.defaultLeaveSecondSection.max_value, self.defaultLeaveSecondSection.unit];
            }
            // 马上刷新
            [self.surplusLackView.leaveSecondView.expireTable.mj_header beginRefreshing];
            break;
        }
        default:
            break;
    }
}


#pragma mark - 选项卡选择代理
- (void)cardSurplusTabChoiceDelegate:(NSInteger)bntTag {
    
    if (bntTag==5010) {
        if (self.surplusLackView.balanceView.expireArray.count==0||!self.surplusLackView.balanceView.expireArray) {
            [self removeNoDataView];
            [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.surplusLackView.balanceView.expireTable.mas_centerX);
                    make.centerY.equalTo(self.surplusLackView.balanceView.expireTable.mas_centerY);
                    make.top.equalTo(noImage.mas_top);
                    make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                    make.width.mas_equalTo(ScreenW);
                }];
            }];
        }
    }else{
        if (self.surplusLackView.leaveSecondView.expireArray.count==0||!self.surplusLackView.leaveSecondView.expireArray) {
            [self removeNoDataView];
            [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.surplusLackView.leaveSecondView.expireTable.mas_centerX);
                    make.centerY.equalTo(self.surplusLackView.leaveSecondView.expireTable.mas_centerY);
                    make.top.equalTo(noImage.mas_top);
                    make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                    make.width.mas_equalTo(ScreenW);
                }];
            }];
        }
        if (self.leaveSecondSectionArray.count == 0) {
            // 数据请求
            [self surplusLackRepuestData:NumNotEnoughType];
        }
    }
}


#pragma mark - 布局nav
- (void)surplusLackLayoutNAV {
    self.navigationItem.title = @"会员卡余额不足";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add_user"] style:UIBarButtonItemStyleDone target:self action:@selector(UserRightBarButtonItmeAction)];
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(UserRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)surplusLackLayoutView {
    @weakify(self)
    /** 余额／余次view */
    self.surplusLackView = [[SurplusLackView alloc] init];
    self.surplusLackView.delegate = self;
    /** 余额View */
    [self.surplusLackView.balanceView.expireHeaderView.seleAreaBtn addTarget:self action:@selector(surplusLackBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 余次View */
    [self.surplusLackView.leaveSecondView.expireHeaderView.seleAreaBtn addTarget:self action:@selector(surplusLackBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.surplusLackView];
    [self.surplusLackView mas_makeConstraints:^(MASConstraintMaker *make) {
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
