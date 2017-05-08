//
//  MonthsViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MonthsViewController.h"
#import "DateReportView.h"

@interface MonthsViewController ()

/** 日期报表view */
@property (strong, nonatomic) DateReportView *dateReportView;

@end

@implementation MonthsViewController

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
    [self monthsLayoutNAV];
    // 布局视图
    [self monthsLayoutView];
    // 网络请求
    [self monthsRequest];
}
#pragma mark - 网络请求
- (void)monthsRequest {
    /*/index.php?c=report&a=list&v=1
     prov_no 	string 	是 	服务商编号
     type 	int 	是 	报表类型 1-日报 2-周报 3-月报
     start 	int 	否 	第几页， 默认为0
     pageSize 	int 	否 	每页显示条数，默认为10    */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
    params[@"type"] = @"3"; // 报表类型 1-日报 2-周报 3-月报
    // 下拉刷新
    @weakify(self)
    self.dateReportView.orderListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求
        [self.dateReportView.detaReportDataSource detaReportDropRequestData:self.dateReportView.orderListTable params:params viewController:self success:^(NSInteger arrayCount, ReportModel *current, ReportModel *last) {
            // 移除无数据视图
            [self removeNoDataView];
            // 界面赋值
            [self monthsAssignment:current yestoday:last];
            // 判断是否有订单数据
            if (arrayCount == 0) {
                // 判断是否有数据
                if (arrayCount == 0) {
                    [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                        [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(self.dateReportView.orderListTable.mas_centerX);
                            make.centerY.equalTo(self.dateReportView.orderListTable.mas_centerY).offset(30);
                        }];
                    }];
                }
            }
        }];
    }];
    // 上拉加载
    self.dateReportView.orderListTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [self.dateReportView.detaReportDataSource detaReportLoadRequestData:self.dateReportView.orderListTable params:params viewController:self success:^{
            
        }];
    }];
    // 马上进入刷新状态
    [self.dateReportView.orderListTable.mj_header beginRefreshing];
}

#pragma mark - 按钮点击方法
- (void)monthsNavLeftBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 界面赋值
- (void)monthsAssignment:(ReportModel *)today yestoday:(ReportModel *)yestoday {
    /** 报表头部view */
    /** 报表头部view标题 */
    self.dateReportView.reportHeaderView.pageTitleLabel.text = @"本月";
    /** 客户数量 */
    self.dateReportView.reportHeaderView.customerView.viceLabel.text = [NSString stringWithFormat:@"%ld", (long)yestoday.count];
    self.dateReportView.reportHeaderView.customerView.mainLabel.text = @"上月新增：";
    /** 交易额 */
    self.dateReportView.reportHeaderView.turnoverByView.viceLabel.text = [NSString stringWithFormat:@"%.2f", yestoday.amount];
    self.dateReportView.reportHeaderView.turnoverByView.mainLabel.text = @"上月交易额：";
    /** 客户数环比 */
    self.dateReportView.reportHeaderView.customerMomView.viceLabel.text = [NSString stringWithFormat:@"%ld", (long)today.count];
    self.dateReportView.reportHeaderView.customerMomView.mainLabel.text = @"本月新增：";
    /** 交易额环比 */
    self.dateReportView.reportHeaderView.turnoverByMomView.viceLabel.text = [NSString stringWithFormat:@"%.2f", today.amount];
    self.dateReportView.reportHeaderView.turnoverByMomView.mainLabel.text = @"本月交易额：";
}
#pragma mark - 布局nav
- (void)monthsLayoutNAV {
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(monthsNavLeftBtnAction)];
}
#pragma mark - 布局视图
- (void)monthsLayoutView {
    /** 日期报表view */
    self.dateReportView = [[DateReportView alloc] init];
    [self.view addSubview:self.dateReportView];
    @weakify(self)
    [self.dateReportView mas_makeConstraints:^(MASConstraintMaker *make) {
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
