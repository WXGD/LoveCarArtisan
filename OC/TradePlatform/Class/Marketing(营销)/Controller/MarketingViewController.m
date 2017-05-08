//
//  MarketingViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MarketingViewController.h"
// view
#import "MarketingView.h"
// 下级控制器
#import "BenefitQuiryViewController.h"
#import "UsedCarViewController.h"
#import "UserCardExpireViewController.h"
#import "SurplusLackViewController.h"

@interface MarketingViewController ()

/** 营销 */
@property (strong, nonatomic) MarketingView *marketingView;

@end

@implementation MarketingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self marketingLayoutNAV];
    // 布局视图
    [self marketingLayoutView];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
- (void)marketingBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 保险 */
        case BenefitBtnAction:{
            BenefitQuiryViewController *benefitQuiryVC = [[BenefitQuiryViewController alloc] init];
            [self.navigationController pushViewController:benefitQuiryVC animated:YES];
            break;
        }
            /** 二手车 */
        case UsedCarBtnAction:{
            UsedCarViewController *usedCarVC = [[UsedCarViewController alloc] init];
            [self.navigationController pushViewController:usedCarVC animated:YES];
            break;
        }
            /** 会员卡到期 */
        case CardExpireBtnAction:{
            UserCardExpireViewController *userCardExpireVC = [[UserCardExpireViewController alloc] init];
            userCardExpireVC.expireViewType = UserCardExpireType;
            [self.navigationController pushViewController:userCardExpireVC animated:YES];
            break;
        }
            /** 会员卡余额不足 */
        case BalanceNotEnoughBtnAction:{
            SurplusLackViewController *surplusLackVC = [[SurplusLackViewController alloc] init];
            [self.navigationController pushViewController:surplusLackVC animated:YES];
            break;
        }
            /** 长期未到店 */
        case LongNotShopBtnAction:{
            UserCardExpireViewController *userCardExpireVC = [[UserCardExpireViewController alloc] init];
            userCardExpireVC.expireViewType = longNotShopType;
            [self.navigationController pushViewController:userCardExpireVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 界面赋值
- (void)marketingAssignment {
    
}
#pragma mark - 布局nav
- (void)marketingLayoutNAV {
    self.navigationItem.title = @"营销";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(marketingLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(marketingRightBarBtnAction)];
}
#pragma mark - 布局视图
- (void)marketingLayoutView {
    /** 营销 */
    self.marketingView = [[MarketingView alloc] init];
    /** 保险 */
    [self.marketingView.benefitView.marketingBtn addTarget:self action:@selector(marketingBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 二手车 */
    [self.marketingView.usedCarView.marketingBtn addTarget:self action:@selector(marketingBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 用户跟踪 */
//    [self.marketingView.userTrackingView.marketingBtn addTarget:self action:@selector(marketingBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 会员卡到期 */
    [self.marketingView.cardExpireBtn addTarget:self action:@selector(marketingBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 会员卡余额不足 */
    [self.marketingView.balanceNotEnoughBtn addTarget:self action:@selector(marketingBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 长期未到店 */
    [self.marketingView.longNotShopBtn addTarget:self action:@selector(marketingBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.marketingView];
    @weakify(self)
    [self.marketingView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    switch (indexPath.row) {
//        case 0:{ // 保险
//            BenefitQuiryViewController *benefitQuiryVC = [[BenefitQuiryViewController alloc] init];
//            [self.navigationController pushViewController:benefitQuiryVC animated:YES];
//            break;
//        }
//        case 1:{ // 二手车
//            UsedCarViewController *usedCarVC = [[UsedCarViewController alloc] init];
//            [self.navigationController pushViewController:usedCarVC animated:YES];
//            break;
//        }
//        default:
//            break;
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
