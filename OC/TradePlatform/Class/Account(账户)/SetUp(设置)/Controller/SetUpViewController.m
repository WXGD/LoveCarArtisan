//
//  SetUpViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SetUpViewController.h"
// view
#import "SetUpView.h"
// 下级控制器
#import "FeedbackViewController.h"
// 更新提醒模型
#import "UpdateReminderModel.h"
#import "CityModel.h"

@interface SetUpViewController ()
/** 设置view */
@property (strong, nonatomic) SetUpView *setUpView;

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self setUpLayoutNAV];
    // 布局视图
    [self setUpLayoutView];
    // 界面赋值
    [self setUpAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
- (void)setUpBtnAction:(UIButton *)button {
    switch (button.tag) {
        /** 清除缓存 */
        case ClearCacheBtnAction: {
            [[SDImageCache sharedImageCache] clearDisk];
            self.setUpView.clearCacheView.describeLabel.text = [CustomString checkTmpSize];
            // 网络请求，更新城市数据
            CityModel *cityModel = [[CityModel alloc] init];
            [cityModel networkRequestWholeCityData];
            break;
        }
        /** 当前版本 */
        case CurrentVersionBtnAction: {
            // 版本更新
            //[UpdateReminderModel updateReminderAlreadyNewest:^{
            //    [MBProgressHUD showSuccess:@"已经是最新版本了"];
            //}];
            break;
        }
        /** 意见反馈 */
        case FeedbackBtnAction: {
            FeedbackViewController *loginVC = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            break;
        }
        /** 关于我们 */
        case AboutUsBtnAction: {
            
            break;
        }
        /** 客服电话 */
        case ServiceNumBtnAction: {
            [AlertAction determineStayLeft:self title:@"拨号" message:[NSString stringWithFormat:@"是否允许拨打电话到%@", SERVICENUM] determineBlock:^{
                /** 调用系统电话 */
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", SERVICENUM]]];
            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 界面赋值
- (void)setUpAssignment {
    // 展示当前版本号
    self.setUpView.currentVersionView.describeLabel.text = VERSION;
    /** 缓存数据 */
    self.setUpView.clearCacheView.describeLabel.text = [CustomString checkTmpSize];
}
#pragma mark - 布局nav
- (void)setUpLayoutNAV {
    self.navigationItem.title = @"设置";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)setUpLayoutView {
    /** 设置view */
    self.setUpView = [[SetUpView alloc] init];
    /** 清除缓存 */
    [self.setUpView.clearCacheView.usedCellBtn addTarget:self action:@selector(setUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 当前版本 */
    [self.setUpView.currentVersionView.usedCellBtn addTarget:self action:@selector(setUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 意见反馈 */
    [self.setUpView.feedbackView.usedCellBtn addTarget:self action:@selector(setUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 关于我们 */
    [self.setUpView.aboutUsView.usedCellBtn addTarget:self action:@selector(setUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 客服电话 */
    [self.setUpView.serviceNumView.usedCellBtn addTarget:self action:@selector(setUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.setUpView];
    @weakify(self)
    [self.setUpView mas_makeConstraints:^(MASConstraintMaker *make) {
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
