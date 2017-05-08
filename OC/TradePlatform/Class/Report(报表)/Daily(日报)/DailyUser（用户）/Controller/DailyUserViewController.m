//
//  DailyUserViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailyUserViewController.h"
#import "DailyUserView.h"
// 网络请求
#import "DailyUserModel.h"

@interface DailyUserViewController ()

/** 日报表用户view */
@property (strong, nonatomic) DailyUserView *dailyUserView;

@end

@implementation DailyUserViewController

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
    [self dailyUserLayoutNAV];
    // 布局视图
    [self dailyUserLayoutView];
    // 网络请求
    [self dailyUserRequest];
}
#pragma mark - 网络请求
- (void)dailyUserRequest {
    /*/index.php?c=report&a=user_list&v=1
     provider_id 	int 	是 	服务商id
     date 	string 	否 	报表日期，默认为当天数据      */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"date"] = self.dailyUserView.detaChioceBtn.titleLabel.text; // 报表日期，默认为当天数据
    /* 请求日用户数据 */
    [DailyUserModel requestDailyUserDataParams:params success:^(DailyUserModel *dailyUserModel) {
        [self dailyUserAssignment:dailyUserModel];
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
        [self.dailyUserView.detaChioceBtn setTitle:timestamp forState:UIControlStateNormal];
        // 网络请求,请求日用户数量
        [self dailyUserRequest];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}

#pragma mark - 界面赋值
- (void)dailyUserAssignment:(DailyUserModel *)dailyUserModel {
    /** 总用户数量 */
    self.dailyUserView.userNum.text = [NSString stringWithFormat:@"%ld", dailyUserModel.count];
    /** 男 */
    self.dailyUserView.maleSexLabel.viceLabel.text = [NSString stringWithFormat:@"%ld", dailyUserModel.man_count];
    /** 女 */
    self.dailyUserView.femaleSexLabel.viceLabel.text = [NSString stringWithFormat:@"%ld", dailyUserModel.woman_count];
    /** 未知 */
    self.dailyUserView.unknownSexLabel.viceLabel.text = [NSString stringWithFormat:@"%ld", dailyUserModel.unknown];
}
#pragma mark - 布局nav
- (void)dailyUserLayoutNAV {
    self.navigationItem.title = @"用户报表";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(dailyUserNavLeftBtnAction)];
}
#pragma mark - 布局视图
- (void)dailyUserLayoutView {
    /** 日报表用户view */
    self.dailyUserView = [[DailyUserView alloc] init];
    [self.dailyUserView.detaChioceBtn addTarget:self action:@selector(detaChioceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dailyUserView];
    @weakify(self)
    [self.dailyUserView mas_makeConstraints:^(MASConstraintMaker *make) {
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
