//
//  DailyTurnoverViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailyTurnoverViewController.h"
#import "DailyTurnoverHeaderView.h"
// 网络请求
#import "DailyTurnoverModel.h"

@interface DailyTurnoverViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 日报表营业额头部view */
@property (strong, nonatomic) DailyTurnoverHeaderView *dailyTurnoverHeaderView;
/** 营业额tableviewArray */
@property (strong, nonatomic) NSMutableArray *dailyTurnoverArray;
/** 营业额tableview */
@property (strong, nonatomic) UITableView *turnoverTable;

@end

@implementation DailyTurnoverViewController

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
    [self dailyTurnoverLayoutNAV];
    // 布局视图
    [self dailyTurnoverLayoutView];
    // 网络请求
    [self dailyTurnoverRequest];
}
#pragma mark - 网络请求
- (void)dailyTurnoverRequest {
    /*/index.php?c=report&a=amount_list&v=1
     provider_id 	int 	是 	服务商id
     date 	string 	否 	报表日期，默认为当天数据     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
    params[@"date"] = self.dailyTurnoverHeaderView.detaChioceBtn.titleLabel.text; // 报表日期，默认为当天数据
    [DailyTurnoverModel requestDailyTurnoverModelDataParams:params success:^(NSMutableArray *dailyTurnoverArray, NSMutableDictionary *options) {
        /** 营业额数量 */
        NSString *amountStr = [NSString stringWithFormat:@"%@", options[@"amount"]];
        double amount = [amountStr doubleValue];
        self.dailyTurnoverHeaderView.turnoverNum.text = [NSString stringWithFormat:@"%.2f", amount];
        /** 营业额tableviewArray */
        self.dailyTurnoverArray = dailyTurnoverArray;
        // 刷新
        [self.turnoverTable reloadData];
    }];
}

#pragma mark - 按钮点击方法
// 日期选择
- (void)detaChioceBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置时间范围    
    datePicker.maximumDate= [NSDate date];//今天
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        [self.dailyTurnoverHeaderView.detaChioceBtn setTitle:timestamp forState:UIControlStateNormal];
        // 网络请求,请求日用户数量
        [self dailyTurnoverRequest];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}

#pragma mark - 界面赋值
- (void)dailyTurnoverAssignment {
    
}
#pragma mark - 布局nav
- (void)dailyTurnoverLayoutNAV {
    self.navigationItem.title = @"营业额报表";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(dailyTurnoverNavLeftBtnAction)];
}
#pragma mark - 布局视图
- (void)dailyTurnoverLayoutView {
    @weakify(self)
    /** 营业额tableview */
    self.turnoverTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.turnoverTable.delegate = self;
    self.turnoverTable.dataSource = self;
    self.turnoverTable.backgroundColor = CLEARCOLOR;
    self.turnoverTable.rowHeight = 50;
    [self.view addSubview:self.turnoverTable];
    // tableview高度随数据高度变化而变化
    [self.turnoverTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    /** 营业额tableview */
    [self.turnoverTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
    }];
    /** 日报表营业额头部view */
    self.dailyTurnoverHeaderView = [[DailyTurnoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 313.5)];
    self.dailyTurnoverHeaderView.backgroundColor = ThemeColor;
    [self.dailyTurnoverHeaderView.detaChioceBtn addTarget:self action:@selector(detaChioceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.turnoverTable.tableHeaderView = self.dailyTurnoverHeaderView;
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dailyTurnoverArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"turnoverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    DailyTurnoverModel *dailyTurnoverModel = [self.dailyTurnoverArray objectAtIndex:indexPath.row];
    cell.textLabel.text = dailyTurnoverModel.goods_category_name;
    cell.textLabel.textColor = Black;
    cell.textLabel.font = FifteenTypeface;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f元", dailyTurnoverModel.amount];
    cell.detailTextLabel.textColor = Black;
    cell.detailTextLabel.font = FifteenTypeface;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
