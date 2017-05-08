//
//  DailyViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailyViewController.h"
#import "DailyView.h"
// 请求今天报表营业额和用户数据
#import "DetaReportDataSource.h"
// 下级控制器
#import "DailyTurnoverViewController.h"
#import "DailyUserViewController.h"

@interface DailyViewController ()

/** 日报表view */
@property (strong, nonatomic) DailyView *dailyView;
/** 订单列表数据 */
@property (strong, nonatomic) DetaReportDataSource *detaReportDataSource;

@end

@implementation DailyViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局nav
    [self dailyLayoutNAV];
    // 布局视图
    [self dailyLayoutView];
    // 网络请求
    [self dailyRequest];
}
#pragma mark - 网络请求
- (void)dailyRequest {
    /*/index.php?c=report&a=list&v=1
     provider_id 	int 	是 	服务商id
     type 	int 	是 	报表类型 1-日报 2-周报 3-月报
     start 	int 	否 	第几页， 默认为0
     pageSize 	int 	否 	每页显示条数，默认为10     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
    params[@"type"] = @"1"; // 报表类型 1-日报 2-周报 3-月报
    // 网络请求
    [DetaReportDataSource requestReportDataParams:params success:^(ReportModel *current, ReportModel *last) {
        // 界面赋值
        [self dailyAssignmentCurrent:current last:last];
    }];
}

#pragma mark - 按钮点击方法、
// 日报页面按钮点击方法
- (void)dailyBtnAction:(UIButton *)button {
    switch (button.tag) {
            /** 用户 */
        case UserBtnAction: {
            DailyUserViewController *dailyUserVC = [[DailyUserViewController alloc] init];
            [self.navigationController pushViewController:dailyUserVC animated:YES];
            break;
        }
            /** 营业额 */
        case TurnoverBtnAction: {
            DailyTurnoverViewController *dailyTurnoverVC = [[DailyTurnoverViewController alloc] init];
            [self.navigationController pushViewController:dailyTurnoverVC animated:YES];
            break;
        }
        default:
            break;
    }
}


// nav按钮点击方法
- (void)dailyNavLeftBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 界面赋值
- (void)dailyAssignmentCurrent:(ReportModel *)current last:(ReportModel *)last {
    /** 客户数量 */
    self.dailyView.todayUser.viceLabel.text = [NSString stringWithFormat:@"%ld", (long)current.count];
    self.dailyView.yesterdayUser.viceLabel.text = [NSString stringWithFormat:@"%ld", (long)last.count];
    // 计算客户数量增长率
    double userGrowthRate = (current.count - last.count) / (double)last.count * 100;
    // 判断增长率是否大于0
    if (last.count == 0) {
        self.dailyView.todayUserGrowthRate.viceLabel.text = [NSString stringWithFormat:@"+100%%"];
    }else if (userGrowthRate > 0) {
        self.dailyView.todayUserGrowthRate.viceLabel.text = [NSString stringWithFormat:@"+%.2f%%", userGrowthRate];
    }else if (userGrowthRate < 0) {
        self.dailyView.todayUserGrowthRate.viceLabel.text = [NSString stringWithFormat:@"%.2f%%", userGrowthRate];
    }
    /** 交易额 */
    self.dailyView.todayTurnover.viceLabel.text = [NSString stringWithFormat:@"%.2f", current.amount];
    self.dailyView.yesterdayTurnover.viceLabel.text = [NSString stringWithFormat:@"%.2f", last.amount];
    // 计算交易额增长率
    double turnoverGrowthRate = (current.amount - last.amount) / last.amount * 100;
    // 判断增长率是否大于0
    if (last.amount == 0) {
        self.dailyView.todayTurnoverGrowthRate.viceLabel.text = [NSString stringWithFormat:@"+100%%"];
    }else if (turnoverGrowthRate > 0) {
        self.dailyView.todayTurnoverGrowthRate.viceLabel.text = [NSString stringWithFormat:@"+%.2f%%", turnoverGrowthRate];
    }else if (turnoverGrowthRate < 0) {
        self.dailyView.todayTurnoverGrowthRate.viceLabel.text = [NSString stringWithFormat:@"%.2f%%", turnoverGrowthRate];
    }
}
#pragma mark - 布局nav
- (void)dailyLayoutNAV {
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(dailyNavLeftBtnAction)];
}
#pragma mark - 布局视图
- (void)dailyLayoutView {
    /** 日报表view */
    self.dailyView = [[DailyView alloc] init];
    /** 用户 */
    [self.dailyView.userViewBtn addTarget:self action:@selector(dailyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 营业额 */
    [self.dailyView.turnoverViewBtn addTarget:self action:@selector(dailyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dailyView];
    @weakify(self)
    [self.dailyView mas_makeConstraints:^(MASConstraintMaker *make) {
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
