//
//  GrantViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GrantViewController.h"
// view
#import "GrantView.h"
// 模型
#import "UserModel.h"
#import "GrantNetwork.h"

@interface GrantViewController ()

/** 发劵view */
@property (strong, nonatomic) GrantView *grantView;

@end

@implementation GrantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self grantLayoutNAV];
    // 布局视图
    [self grantLayoutView];
    // 网络请求
    [self userRequestData];
}

#pragma mark - 网络请求
- (void)userRequestData {
    // 初始化请求类
    UserModel *userModel = [[UserModel alloc] init];
    /*/index.php?c=provider_user&a=list&v=1
     provider_id 	int 	是 	服务商id
     user_input 	string 	否 	用户手机号(支持模糊输入)
     start 	int 	否 	查询开始位置，默认为0
     coupon_id 	int 	是 	优惠券id
     pageSize 	int 	否 	每页显示条数，默认为10   */
    // 下拉刷新
    @weakify(self)
    self.grantView.userTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
        params[@"coupon_id"] = [NSString stringWithFormat:@"%ld", self.couponGoverModel.coupon_id]; // 优惠券id
        params[@"user_input"] = self.grantView.grantUserSearchView.searchTF.text; // 用户手机号
        // 网络请求
        [userModel userRefreshRequestData:self.grantView.userTable params:params success:^(NSMutableArray *userArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.grantView.userArray removeAllObjects];
            // 判断是否有数据
            if (userArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.grantView.userTable.mas_centerX);
                        make.centerY.equalTo(self.grantView.userTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.grantView.userArray = userArray;
            }
            [self.grantView.userTable reloadData];
        }];
    }];
    // 上拉加载
    self.grantView.userTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
        params[@"coupon_id"] = [NSString stringWithFormat:@"%ld", self.couponGoverModel.coupon_id]; // 优惠券id
        params[@"user_input"] = self.grantView.grantUserSearchView.searchTF.text; // 用户手机号
        // 网络请求
        [userModel userLoadRequestData:self.grantView.userTable params:params success:^(NSMutableArray *userArray) {
            [self.grantView.userArray addObjectsFromArray:userArray];
            [self.grantView.userTable reloadData];
        }];
    }];
    // 马上进入刷新状态
    [self.grantView.userTable.mj_header beginRefreshing];
}
#pragma mark - 按钮点击
/** 确认发劵 */
- (void)grantBtnAction:(UIButton *)button {
    // 初始化字符串，用来保存用户ID
    NSString *userID = [[NSString alloc] init];
    // 发放的用户数量
    NSInteger userNmu = 0;
    // 便利用户列表
    for (UserModel *userModel in self.grantView.userArray) {
        if (userModel.checkMark) {
            // 拼接用户ID
            if (userID.length == 0) {
                userID = [NSString stringWithFormat:@"%ld", (long)userModel.provider_user_id];
            }else {
                userID = [NSString stringWithFormat:@"%@,%ld", userID, (long)userModel.provider_user_id];
            }
            // 发放的用户数量+1
            userNmu += 1;
        }
    }
    // 判断优惠劵剩余数量是否足够
    if (self.couponGoverModel.num != 0 && userNmu > self.couponGoverModel.available_num) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"该优惠劵最多只能发放给%ld一个用户", self.couponGoverModel.available_num]];
        return;
    }
    /*/index.php?c=coupon_grant_record&a=donate&v=1
     provider_user_id 	int 	是 	用户id
     coupon_id 	int 	是 	优惠券id       */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"coupon_id"] = [NSString stringWithFormat:@"%ld", (long)self.couponGoverModel.coupon_id]; // 优惠券id
    params[@"provider_user_id"] = userID; // 用户id
    [GrantNetwork grantCoupon:params success:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
/** 搜索用户 */
- (void)searchTFAction:(UITextField *)textField {
    // 判断输入框内容为空，不刷新
    if (textField.text.length == 0) {
        return;
    }
    // 马上刷新用户列表
    [self.grantView.userTable.mj_header beginRefreshing];
}
#pragma mark - 布局nav
- (void)grantLayoutNAV {
    self.navigationItem.title = self.couponGoverModel.name;
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_account_account_bank"] style:UIBarButtonItemStyleDone target:self action:@selector(bankCardManagement)];
}

#pragma mark - 布局视图
- (void)grantLayoutView {
    /** 发劵view */
    self.grantView = [[GrantView alloc] init];
    /** 确认发劵 */
    [self.grantView.grantBtn addTarget:self action:@selector(grantBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 搜索用户 */
    [self.grantView.grantUserSearchView.searchTF addTarget:self action:@selector(searchTFAction:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.grantView];
    @weakify(self)
    [self.grantView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
