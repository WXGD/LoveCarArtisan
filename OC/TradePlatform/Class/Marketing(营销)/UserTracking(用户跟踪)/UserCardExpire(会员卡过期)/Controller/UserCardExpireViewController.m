//
//  UserCardExpireViewController.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import "UserCardExpireViewController.h"
// view
#import "ExpireTableView.h"
#import "CashierServiceChoiceView.h"
// 控制器
#import "ReviseRangeViewController.h"
// 模型
#import "ExpireModel.h"
#import "ExpircUserModel.h"

@interface UserCardExpireViewController ()<ExpireTableDelegate, CashierServiceChoiceDelegate>

/** 会员卡过期table */
@property (strong, nonatomic) ExpireTableView *expireTableView;
/** 会员卡过期区间数据 */
@property (strong, nonatomic) NSMutableArray *expireSectionArray;
/** 过期区间列表数据 */
@property (strong, nonatomic) NSMutableArray *sectionListArray;
/** 当前选中区间 */
@property (strong, nonatomic) ExpireModel *defaultSection;

@end

@implementation UserCardExpireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self userCardExpireLayoutNAV];
    // 布局视图
    [self userCardExpireLayoutView];
    // 请求区间用户数据
    [self userCardExpireUserRepuestData];
    // 请求区间数据
    [self userCardExpireRepuestData];
}
#pragma mark - 网络请求
// 请求区间数据
- (void)userCardExpireRepuestData {
    /* /index.php?c=user_track&a=section&v=1
     provider_id 	int 	是 	服务商id
     type 	int 	是 	获取区间的类型 1-会员卡到期区间 2-会员卡余额不足区间 3-会员卡余次不足区间 4-会员长期未到店区间 5-用户消费区间  */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"type"] = self.expireViewType == UserCardExpireType ? @1 : @4; // 区间的类型
    [ExpireModel requestDataSection:params success:^(NSMutableArray *sectionArray) {
        // 保存会员卡过期区间数据
        self.expireSectionArray = [NSMutableArray arrayWithArray:sectionArray];
        // 保存过期区间列表数据
        self.sectionListArray = [NSMutableArray arrayWithArray:sectionArray];
        // 添加自定义按钮
        ExpireModel *expireModel = [[ExpireModel alloc] init];
        expireModel.max_value = @"自定义";
        [self.expireSectionArray addObject:expireModel];
        // 保存当前选择区间
        self.defaultSection = [sectionArray firstObject];
        if (self.defaultSection.min_value.length == 0 && self.defaultSection.max_value.length == 0) {
            // 展示当前选择区间
            self.expireTableView.expireHeaderView.seleAreaLabel.text = @"请添加查询区间";
        }else {
            // 展示当前选择区间
            if ([self.defaultSection.max_value doubleValue] == 0) {
                self.expireTableView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~最大值", self.defaultSection.min_value, self.defaultSection.unit];
            }else {
                self.expireTableView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~%@%@", self.defaultSection.min_value, self.defaultSection.unit, self.defaultSection.max_value, self.defaultSection.unit];
            }
        }
        // 马上刷新
        [self.expireTableView.expireTable.mj_header beginRefreshing];
    }];
}
// 请求区间用户数据
- (void)userCardExpireUserRepuestData {
    ExpircUserModel *expircUserModel = [[ExpircUserModel alloc] init];
    // 下拉刷新
    @weakify(self)
    self.expireTableView.expireTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /* /index.php?c=user_track&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_track_id 	int 	是 	区间列表id
         start 	int 	否 	开始位置，默认为0
         pageSize 	int 	否 	每页显示条数，默认为10    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"user_track_id"] = [NSString stringWithFormat:@"%ld", (long)self.defaultSection.user_track_id]; // 区间列表id
        @strongify(self)
        [expircUserModel expircUserRefreshRequestData:params tableView:self.expireTableView.expireTable success:^(NSMutableArray *expircUserArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.expireTableView.expireArray removeAllObjects];
            // 判断是否有数据
            if (expircUserArray.count == 0) {
                [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.expireTableView.expireTable.mas_centerX);
                        make.centerY.equalTo(self.expireTableView.expireTable.mas_centerY);
                    }];
                }];
            }else {
                self.expireTableView.expireArray = expircUserArray;
            }
            [self.expireTableView.expireTable reloadData];
        }];
    }];
    // 上拉加载
    self.expireTableView.expireTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /* /index.php?c=user_track&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_track_id 	int 	是 	区间列表id
         start 	int 	否 	开始位置，默认为0
         pageSize 	int 	否 	每页显示条数，默认为10    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"user_track_id"] = [NSString stringWithFormat:@"%ld", (long)self.defaultSection.user_track_id]; // 区间列表id
        // 网络请求
        [expircUserModel expircUserLoadRequestData:self.expireTableView.expireTable params:params viewController:self success:^(NSMutableArray *expircUserArray) {
            [self.expireTableView.expireArray addObjectsFromArray:expircUserArray];
            [self.expireTableView.expireTable reloadData];
        }];
    }];
}

#pragma mark - table头部点击代理
- (void)seleAreaBtnAction {
    // 遍历所有服务，找到当前选中的服务
    for (ExpireModel *expireModel in self.expireSectionArray) {
        expireModel.checkMark = NO;
        if (expireModel.user_track_id == self.defaultSection.user_track_id) {
            expireModel.checkMark = YES;
        }
    }
    // 弹出
    CashierServiceChoiceView *classChoiceBoxView = [[CashierServiceChoiceView alloc] init];
    classChoiceBoxView.choiceArray = self.expireSectionArray;
    classChoiceBoxView.serviceChoice = UserScreenServiceBtnAction;
    classChoiceBoxView.delegate = self;
    [classChoiceBoxView show];
}
#pragma mark - 区间选择代理方法
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    /** 获取选择区间 */
    ExpireModel *expireModel = [choiceArray objectAtIndex:indexPath.row];
    // 判断是不是自定义按钮
    if ([expireModel.max_value isEqualToString:@"自定义"]) {
        ReviseRangeViewController *reviseRangeVC = [[ReviseRangeViewController alloc] init];
        switch (self.expireViewType) {
                /** 会员卡过期 */
            case UserCardExpireType: {
                reviseRangeVC.reviseRangeType = UserCardExpireShowType;
                break;
            }
                /** 长期未到店  */
            case longNotShopType: {
                reviseRangeVC.reviseRangeType = longNotShopShowType;
                break;
            }
            default:
                break;
        }
        reviseRangeVC.rangeArray = self.sectionListArray;
        reviseRangeVC.AddDataSectionBlock = ^{
            // 数据请求
            [self userCardExpireRepuestData];
        };
        [self.navigationController pushViewController:reviseRangeVC animated:YES];
        return;
    }
    // 保存当前选择区间
    self.defaultSection = expireModel;
    if ([self.defaultSection.max_value doubleValue] == 0) {
        self.expireTableView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~最大值", self.defaultSection.min_value, self.defaultSection.unit];
    }else {
    // 展示当前选择区间
        self.expireTableView.expireHeaderView.seleAreaLabel.text = [NSString stringWithFormat:@"%@%@~%@%@", self.defaultSection.min_value, self.defaultSection.unit, self.defaultSection.max_value, self.defaultSection.unit];
    }
    // 马上刷新
    [self.expireTableView.expireTable.mj_header beginRefreshing];
}

#pragma mark - 布局nav
- (void)userCardExpireLayoutNAV {
    switch (self.expireViewType) {
            /** 会员卡过期 */
        case UserCardExpireType: {
            self.navigationItem.title = @"会员卡到期用户";
            break;
        }
            /** 长期未到店  */
        case longNotShopType: {
            self.navigationItem.title = @"长期未到店用户";
            break;
        }
        default:
            break;
    }
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add_user"] style:UIBarButtonItemStyleDone target:self action:@selector(UserRightBarButtonItmeAction)];
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(UserRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)userCardExpireLayoutView {
    @weakify(self)
    /** 会员卡过期table */
    self.expireTableView = [[ExpireTableView alloc] init];
    self.expireTableView.delegate = self;
    // 判断当前控制器类型
    if (self.expireViewType == UserCardExpireType) { // 会员卡过期
        self.expireTableView.expireCellType = UserCardExpireCellShowType;
    }else if (self.expireViewType == longNotShopType) { // 长期未到店
        self.expireTableView.expireCellType = longNotShopExpireCellShowType;
    }
    [self.view addSubview:self.expireTableView];
    [self.expireTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
