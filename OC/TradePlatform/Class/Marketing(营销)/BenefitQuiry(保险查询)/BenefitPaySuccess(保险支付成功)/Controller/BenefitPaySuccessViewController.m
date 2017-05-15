//
//  BenefitPaySuccessViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitPaySuccessViewController.h"
// view
#import "BenefitPaySuccessView.h"
// 上级控制器
#import "InquiryRecordViewController.h"

@interface BenefitPaySuccessViewController ()

/** 保险支付成功view */
@property (strong, nonatomic) BenefitPaySuccessView *benefitPaySuccessView;

@end

@implementation BenefitPaySuccessViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self benefitPaySuccessLayoutNAV];
    // 布局视图
    [self benefitPaySuccessLayoutView];
}
#pragma mark - 网络请求


#pragma mark - 按钮点击方法
// nav右边按钮
- (void)benefitPaySuccessRightBarBtnAction {
    
}

// 继续询价
- (void)continueQuiryBtnAction:(UIButton *)button {
    [CustomObject returnAppointController:[InquiryRecordViewController class] currentVC:self];
}

// 返回首页
- (void)returnHomeBtnAction:(UIButton *)button {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 界面赋值
- (void)benefitPaySuccessAssignment {
    
    
}


#pragma mark - 布局nav
- (void)benefitPaySuccessLayoutNAV {
    self.navigationItem.title = @"支付结果";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(benefitPaySuccessRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(benefitPaySuccessRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)benefitPaySuccessLayoutView {
    /** 保险支付成功view */
    self.benefitPaySuccessView = [[BenefitPaySuccessView alloc] init];
    /** 继续询价 */
    [self.benefitPaySuccessView.continueQuiryBtn addTarget:self action:@selector(continueQuiryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 返回首页 */
    [self.benefitPaySuccessView.returnHomeBtn addTarget:self action:@selector(returnHomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.benefitPaySuccessView];
    @weakify(self)
    [self.benefitPaySuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
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
