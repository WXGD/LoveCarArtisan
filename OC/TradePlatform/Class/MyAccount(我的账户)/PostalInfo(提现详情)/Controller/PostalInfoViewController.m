//
//  PostalInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PostalInfoViewController.h"
// view
#import "PostalInfoView.h"

@interface PostalInfoViewController ()

/** 提现详情 */
@property (strong, nonatomic) PostalInfoView *postalInfoView;

@end

@implementation PostalInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self postalInfoLayoutNAV];
    // 布局视图
    [self postalInfoLayoutView];
    // 界面赋值
    [self postalInfoAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
- (void)postalInfoBtnAvtion:(UIButton *)button {
    
}
// 提现记录cell点击
- (void)postalRecordCellDidSelect {
    
}

#pragma mark - 界面赋值
- (void)postalInfoAssignment {
    /** 申请时间 */
    self.postalInfoView.applyTimeView.describeLabel.text = self.postalInfoModel.create_time;
    /** 提现金额 */
    self.postalInfoView.postalMoneyView.describeLabel.text = [NSString stringWithFormat:@"%.2f", self.postalInfoModel.withdraw_money];
    /** 提现状态 */
    // 判断提现订单状态
    if (self.postalInfoModel.withdraw_status != 1) {
        self.postalInfoView.postalStateView.describeLabel.text = @"未结算";
    }else {
        self.postalInfoView.postalStateView.describeLabel.text = @"已结算";
    }
    /** 处理时间 */
    self.postalInfoView.handleTimeView.describeLabel.text = self.postalInfoModel.withdraw_time;
    /** 处理人 */
    self.postalInfoView.handleManView.describeLabel.text = self.postalInfoModel.operator_name;
    /** 提现时间段 */
    self.postalInfoView.applyStartLabel.text = self.postalInfoModel.withdraw_start_time;
    self.postalInfoView.applyEndLabel.text = self.postalInfoModel.withdraw_end_time;
    /** 回执单 */
    [self.postalInfoView.receiptImg setImageWithImageUrl:self.postalInfoModel.receipt_url perchImage:@""];
}
#pragma mark - 布局nav
- (void)postalInfoLayoutNAV {
    self.navigationItem.title = @"提现详情";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(postalInfoLeftBtnAction)];
// 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postalInfoRightBarBtnAction)];
}
#pragma mark - 布局视图
- (void)postalInfoLayoutView {
    /** 提现详情 */
    self.postalInfoView = [[PostalInfoView alloc] init];
    self.postalInfoView.withdraw_status = self.postalInfoModel.withdraw_status;
    [self.view addSubview:self.postalInfoView];
    @weakify(self)
    [self.postalInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
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
