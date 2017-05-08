//
//  AnalysisViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AnalysisViewController.h"
#import "AnalysisView.h"

@interface AnalysisViewController ()

/** 统计分析view */
@property (strong, nonatomic) AnalysisView *analysisView;

@end

@implementation AnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self analysisLayoutNAV];
    // 布局视图
    [self analysisLayoutView];
    // 界面赋值
    [self analysisAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
- (void)analysisNavLeftBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 界面赋值
- (void)analysisAssignment {
    
}
#pragma mark - 布局nav
- (void)analysisLayoutNAV {
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(analysisNavLeftBtnAction)];
}
#pragma mark - 布局视图
- (void)analysisLayoutView {
    /** 统计分析view */
    self.analysisView = [[AnalysisView alloc] init];
    [self.view addSubview:self.analysisView];
    @weakify(self)
    [self.analysisView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(15);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
