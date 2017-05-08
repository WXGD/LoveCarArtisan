//
//  UserConflictViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserConflictViewController.h"
// view
#import "UserConflictView.h"
// 下级控制器
#import "ConflictUserDetailsViewController.h"
// 网络请求
#import "UserConflictNetwork.h"

@interface UserConflictViewController ()<UserConflictViewDelegate>

/** 会员冲突view */
@property (strong, nonatomic) UserConflictView *userConflictView;

@end

@implementation UserConflictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self userConflictLayoutNAV];
    // 布局视图
    [self userConflictLayoutView];
    // 网络请求
    [self userConflictRequestData];
}
#pragma mark - 网络请求
- (void)userConflictRequestData {
    /*/index.php?c=provider_user&a=merge_user_info&v=1
     provider_user_id 	string 	是 	冲突用户集合,字符串表示(用逗号分割)    */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_user_id"] = self.provider_user_id; // 冲突用户集合
    [UserConflictNetwork queryConflictUserParams:params success:^(NSMutableArray *userArray) {
        self.userConflictView.conflictUserArray = userArray;
        [self.userConflictView.conflictUserTableView reloadData];
    }];
}

#pragma mark - 按钮点击方法
// cell点击代理方法
- (void)userCellSelectIndexPath:(NSIndexPath *)indexPath {
    ConflictUserDetailsViewController *userDetailsVC = [[ConflictUserDetailsViewController alloc] init];
    userDetailsVC.conflictUserModel = [self.userConflictView.conflictUserArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:userDetailsVC animated:YES];
}
// 删除按钮点击
- (void)deleteUserBtnAction:(UIButton *)button {
    /*/index.php?c=provider_user&a=merge&v=1
     provider_user_id 	int 	是 	用户id(保留的用户)
     merged_provider_user_id 	int 	是 	被合并的用户id
     is_merge_card 	int 	是 	是否合并卡
     is_merge_car 	int 	是 	是否合并车辆     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userConflictView.userUnSelectedModel.provider_user_id]; // 用户id(保留的用户)
    params[@"merged_provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userConflictView.userSelectedModel.provider_user_id]; // 被合并的用户id
    params[@"is_merge_card"] = self.userConflictView.mergeUserCardBtn.selected ? @"1" : @"0"; // 是否合并卡
    params[@"is_merge_car"] = self.userConflictView.mergeUserCarBtn.selected ? @"1" : @"0"; // 是否合并车辆
    [UserConflictNetwork mergeConflictUserParams:params success:^{
        [AlertAction determineStayLeft:self title:@"提示" admit:@"取消" noadmit:@"重新开卡" message:@"是否继续开卡" admitBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        } noadmitBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}


#pragma mark - 界面赋值
- (void)userConflictAssignment {
    
}


#pragma mark - 布局nav
- (void)userConflictLayoutNAV {
    self.navigationController.title = @"删除冲突用户";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(userConflictRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(userConflictRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)userConflictLayoutView {
    /** 会员冲突view */
    self.userConflictView = [[UserConflictView alloc] init];
    self.userConflictView.delegate = self;
    /** 删除按钮 */
    [self.userConflictView.deleteBtn addTarget:self action:@selector(deleteUserBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.userConflictView];
    @weakify(self)
    [self.userConflictView mas_makeConstraints:^(MASConstraintMaker *make) {
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
