//
//  AloneInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AloneInfoViewController.h"
#import "AloneInfoView.h"
// 下级控制器
#import "ChangeInfoViewController.h"
#import "LoginViewController.h"
#import "NavigationViewController.h"
// 推送设置别名
#import "JPUSHService.h"
// 单利
#import "OrderFilterHandle.h"
#import "OrderClassHandle.h"
#import "UsedCarBrandHandle.h"
#import "AllGoodsHandle.h"
#import "ServiceMasterHandle.h"
#import "ServiceCategoryHandle.h"

@interface AloneInfoViewController ()

/** 个人信息view */
@property (strong, nonatomic) AloneInfoView *aloneInfoView;

@end

@implementation AloneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self aloneInfoLayoutNAV];
    // 布局视图
    [self aloneInfoLayoutView];
    // 界面赋值
    [self aloneInfoAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
//  个人信息页面按钮点击方法
- (void)aloneInfoBtnAction:(UIButton *)button {
    switch (button.tag) {
        /** 名字 */
        case AccountNameBtnAction: {
            
            break;
        }
        /** 修改密码 */
        case DelPasswordBtnAction: {
            ChangeInfoViewController *changeInfoVC = [[ChangeInfoViewController alloc] init];
            changeInfoVC.changeInfoExhibitionType = ChangeUserDelPasswordAssignment;
            [self.navigationController pushViewController:changeInfoVC animated:YES];
            break;
        }
            /** 退出当前账户 */
        case SignOutBtnAction: {
            [AlertAction determineStayLeft:self title:@"退出登录" message:@"确定要退出登录吗?" determineBlock:^{
                // 设置标签和(或)别名
                [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    PDLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
                }];
                // 清空用户信息数据
                MerchantInfoModel *merchantInfo = [[MerchantInfoModel alloc] init];
                // 储存商家信息
                [NSKeyedArchiver archiveRootObject:merchantInfo toFile:AccountPath];
                // 销毁单利
                [OrderFilterHandle destroyHandle];
                [OrderClassHandle destroyHandle];
                [UsedCarBrandHandle destroyHandle];
                [AllGoodsHandle destroyHandle];
                [ServiceMasterHandle destroyHandle];
                [ServiceCategoryHandle destroyHandle];
                // 跳转到登录界面
                UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                keyWindow.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
            }];
            break;
        }
        default:
            break;
    }
    
}
#pragma mark - 界面赋值
- (void)aloneInfoAssignment {
    /** 名字 */
    self.aloneInfoView.accountName.cellLabel.text = self.merchantInfo.user_name;

}
#pragma mark - 布局nav
- (void)aloneInfoLayoutNAV {
    self.navigationItem.title = @"个人信息";
    // 左边
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)aloneInfoLayoutView {
    /** 个人信息view */
    self.aloneInfoView = [[AloneInfoView alloc] init];
    /** 修改密码 */
    [self.aloneInfoView.delPassword.usedCellBtn addTarget:self action:@selector(aloneInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 退出当前账户 */
    [self.aloneInfoView.signOutView addTarget:self action:@selector(aloneInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.aloneInfoView];
    @weakify(self)
    [self.aloneInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
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
