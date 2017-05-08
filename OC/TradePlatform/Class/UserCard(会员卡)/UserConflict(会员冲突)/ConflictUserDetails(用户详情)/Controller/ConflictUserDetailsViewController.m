//
//  ConflictUserDetailsViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConflictUserDetailsViewController.h"
// view
#import "ConflictUserDetailsView.h"
// 网络请求
#import "ConflictUserDetailsModel.h"

@interface ConflictUserDetailsViewController ()

/** 冲突会员详情view */
@property (strong, nonatomic) ConflictUserDetailsView *conflictUserDetailsView;
/** 冲突会员详情model */
@property (strong, nonatomic) ConflictUserDetailsModel *conflictUserDetails;

@end

@implementation ConflictUserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self conflictUserDetailsLayoutNAV];
    // 网络请求
    [self conflictUserDetailsRequestData];
}
#pragma mark - 网络请求
- (void)conflictUserDetailsRequestData {
    /*/index.php?c=provider_user&a=merge_user_detail&v=1
     provider_user_id 	int 	是 	用户id     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.conflictUserModel.provider_user_id]; // 用户id
    [ConflictUserDetailsModel requstConflictUserDetailsParams:params success:^(ConflictUserDetailsModel *conflictUserDetails) {
        self.conflictUserDetails = conflictUserDetails;
        // 布局视图
        [self conflictUserDetailsLayoutView];
        // 界面赋值
        [self conflictUserDetailsAssignment];
    }];
}

#pragma mark - 按钮点击方法

#pragma mark - 首页功能选择按钮
- (void)conflictUserDetailsBtnAvtion:(UIButton *)button {
    
}

#pragma mark - 界面赋值
- (void)conflictUserDetailsAssignment {
    /** 姓名 */
    self.conflictUserDetailsView.userNameView.describeLabel.text = self.conflictUserModel.name;
    /** 电话 */
    self.conflictUserDetailsView.userPhoneView.describeLabel.text = self.conflictUserModel.mobile;
    /** 会员卡列表数量 */
    self.conflictUserDetailsView.userCardCountLabel.text = [NSString stringWithFormat:@"%ld", self.conflictUserDetails.user_card_count];
    /**  车辆列表数量 */
    self.conflictUserDetailsView.userCarCountLabel.text = [NSString stringWithFormat:@"%ld", self.conflictUserDetails.user_car_count];
    // 判断没有会员卡
    if (self.conflictUserDetails.user_card_count == 0) {
        [self.conflictUserDetailsView.userCardView removeFromSuperview];
        [self.conflictUserDetailsView.conflictUserDetailsView removeArrangedSubview:self.conflictUserDetailsView.userCardView];
    }
    // 判断没有会员车辆
    if (self.conflictUserDetails.user_car_count == 0) {
        [self.conflictUserDetailsView.userCarView removeFromSuperview];
        [self.conflictUserDetailsView.conflictUserDetailsView removeArrangedSubview:self.conflictUserDetailsView.userCarView];
    }
}


#pragma mark - 布局nav
- (void)conflictUserDetailsLayoutNAV {
    self.navigationController.title = @"用户详情";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(conflictUserDetailsRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(conflictUserDetailsRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)conflictUserDetailsLayoutView {
    /** 冲突会员详情view */
    self.conflictUserDetailsView = [[ConflictUserDetailsView alloc] init];
    /** 会员卡模型数组 */
    self.conflictUserDetailsView.userCardArray = self.conflictUserDetails.user_card;
    /** 车辆模型数组 */
    self.conflictUserDetailsView.userCarArray = self.conflictUserDetails.user_car;
    [self.view addSubview:self.conflictUserDetailsView];
    @weakify(self)
    [self.conflictUserDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
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
