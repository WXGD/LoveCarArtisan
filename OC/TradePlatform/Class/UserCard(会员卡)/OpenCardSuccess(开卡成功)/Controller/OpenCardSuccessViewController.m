//
//  OpenCardSuccessViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OpenCardSuccessViewController.h"
// view
#import "OpenCardSuccessView.h"

@interface OpenCardSuccessViewController ()

/** 开卡成功view */
@property (strong, nonatomic) OpenCardSuccessView *openCardSuccessView;

@end

@implementation OpenCardSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self openCardSuccessLayoutNAV];
    // 布局视图
    [self openCardSuccessLayoutView];
    // 界面赋值
    [self openCardSuccessAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
// nav右边按钮
- (void)openCardSuccessRightBarBtnAction {
    
}
#pragma mark - 首页功能选择按钮
- (void)openCardSuccessBtnAvtion:(UIButton *)button {
    switch (button.tag) {
        case ContinueOpenCardBtnAction: {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
            /** 返回首页 */
        case ReturnHomeBtnAction: {
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 界面赋值
- (void)openCardSuccessAssignment {
    /** 开卡页使用，充值页使用 */
    switch (self.openCardSuccessType) {
            /** 开卡页使用 */
        case OpenCardUseType:{
            /** 成功提示 */
            self.openCardSuccessView.sucPromptLabel.text = @"开卡成功";
            /** 继续开卡 */
            [self.openCardSuccessView.continueOpenCardBtn setTitle:@"继续开卡" forState:UIControlStateNormal];
            break;
        }
            /** 充值页使用 */
        case RechargeUseType:{
            /** 成功提示 */
            self.openCardSuccessView.sucPromptLabel.text = @"充值成功";
            /** 继续开卡 */
            [self.openCardSuccessView.continueOpenCardBtn setTitle:@"继续充值" forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}


#pragma mark - 布局nav
- (void)openCardSuccessLayoutNAV {
    self.navigationController.title = @"开卡成功";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openCardSuccessRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(openCardSuccessRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)openCardSuccessLayoutView {
    /** 开卡成功view */
    self.openCardSuccessView = [[OpenCardSuccessView alloc] init];
    /** 继续开卡 */
    [self.openCardSuccessView.continueOpenCardBtn addTarget:self action:@selector(openCardSuccessBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 返回首页 */
    [self.openCardSuccessView.returnHomeBtn addTarget:self action:@selector(openCardSuccessBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.openCardSuccessView];
    @weakify(self)
    [self.openCardSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
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
