//
//  SearchViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchViewController.h"
// view
#import "SearchView.h"
#import "SearchVCView.h"
// 网络请求
#import "SearchUserNetwork.h"
#import "SearchUserCarNetwork.h"
#import "SearchUserCardNetwork.h"
// 下级控制器
#import "UserInfoViewController.h"
#import "ChangeInfoViewController.h"
//#import "EditUserCardViewController.h"
//#import "UserCardRechargeViewController.h"

@interface SearchViewController () <UITextFieldDelegate, SearchVCDelegate, UserTableViewDelegate, UserCarTableViewDelegate, UserCardTabelDelegate>

/** 搜索输入框 */
@property (strong, nonatomic) SearchView *searchTFView;
/** 搜索view */
@property (strong, nonatomic) SearchVCView *searchVCView;

@end

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self searchLayoutNAV];
    // 布局视图
    [self searchLayoutView];
    // 输入框成为第一响应者
    [self.searchTFView.searchTF becomeFirstResponder];
    // 请求查询用户
    [self userRequestData];
    // 请求查询车辆
    [self userCarRequestData];
    // 请求查询用户卡
    [self userCardRequestData];
}
#pragma mark - 网络请求
// 请求查询用户
- (void)userRequestData {
    SearchUserNetwork *searchUser = [[SearchUserNetwork alloc] init];
    // 下拉刷新
    @weakify(self)
    self.searchVCView.userTableView.userTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if (self.searchTFView.searchTF.text.length == 0) {
            // 结束下拉刷新
            [self.searchVCView.userTableView.userTable.mj_header endRefreshing];
            return;
        }
        /*/index.php?c=provider_user&a=search&v=1
         provider_id 	int 	是 	服务商id
         type 	int 	否 	查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
         search_value 	string 	否 	查询值
         start 	int 	否 	记录位置
         pageSize 	int 	否 	每页显示条数    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"search_value"] = self.searchTFView.searchTF.text; // 查询值
        // 网络请求
        [searchUser searchUserRefreshRequestData:self.searchVCView.userTableView.userTable params:params success:^(NSMutableArray *userArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 判断是否有数据
            if (userArray.count == 0) {
                // 移除数据，刷新table
                [self.searchVCView.userTableView.userArray removeAllObjects];
                [self.searchVCView.userTableView.userTable reloadData];
                // 展示无数据占位
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.searchVCView.userTableView.userTable.mas_centerX);
                        make.centerY.equalTo(self.searchVCView.userTableView.userTable.mas_centerY).offset(-20);
                    }];
                }];
            }else {
                self.searchVCView.userTableView.userArray = userArray;
                [self.searchVCView.userTableView.userTable reloadData];
            }
        }];
    }];
    // 上拉加载
    self.searchVCView.userTableView.userTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if (self.searchTFView.searchTF.text.length == 0) {
            // 结束下拉刷新
            [self.searchVCView.userTableView.userTable.mj_footer endRefreshing];
            return;
        }
        /*/index.php?c=provider_user&a=search&v=1
         provider_id 	int 	是 	服务商id
         type 	int 	否 	查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
         search_value 	string 	否 	查询值
         start 	int 	否 	记录位置
         pageSize 	int 	否 	每页显示条数    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"search_value"] = self.searchTFView.searchTF.text; // 查询值
        // 网络请求
        [searchUser searchUserLoadRequestData:self.searchVCView.userTableView.userTable params:params success:^(NSMutableArray *userArray) {
            [self.searchVCView.userTableView.userArray addObjectsFromArray:userArray];
            [self.searchVCView.userTableView.userTable reloadData];
        }];
    }];
}
// 请求查询车辆
- (void)userCarRequestData {
    SearchUserCarNetwork *searchUserCar = [[SearchUserCarNetwork alloc] init];
    // 下拉刷新
    @weakify(self)
    self.searchVCView.userCarTableView.userCarTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if (self.searchTFView.searchTF.text.length == 0) {
            // 结束下拉刷新
            [self.searchVCView.userCarTableView.userCarTable.mj_header endRefreshing];
            return;
        }
        /*/index.php?c=provider_user&a=search&v=1
         provider_id 	int 	是 	服务商id
         type 	int 	否 	查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
         search_value 	string 	否 	查询值
         start 	int 	否 	记录位置
         pageSize 	int 	否 	每页显示条数    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"search_value"] = self.searchTFView.searchTF.text; // 查询值
        // 网络请求
        [searchUserCar searchUserCarRefreshRequestData:self.searchVCView.userCarTableView.userCarTable params:params success:^(NSMutableArray *userArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 判断是否有数据
            if (userArray.count == 0) {
                // 移除数据，刷新table
                [self.searchVCView.userCarTableView.userCarArray removeAllObjects];
                [self.searchVCView.userCarTableView.userCarTable reloadData];
                // 展示无数据占位
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.searchVCView.userCarTableView.userCarTable.mas_centerX);
                        make.centerY.equalTo(self.searchVCView.userCarTableView.userCarTable.mas_centerY).offset(-20);
                    }];
                }];
            }else {
                self.searchVCView.userCarTableView.userCarArray = userArray;
                [self.searchVCView.userCarTableView.userCarTable reloadData];
            }
        }];
    }];
    // 上拉加载
    self.searchVCView.userCarTableView.userCarTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if (self.searchTFView.searchTF.text.length == 0) {
            // 结束下拉刷新
            [self.searchVCView.userCarTableView.userCarTable.mj_footer endRefreshing];
            return;
        }
        /*/index.php?c=provider_user&a=search&v=1
         provider_id 	int 	是 	服务商id
         type 	int 	否 	查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
         search_value 	string 	否 	查询值
         start 	int 	否 	记录位置
         pageSize 	int 	否 	每页显示条数    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"search_value"] = self.searchTFView.searchTF.text; // 查询值
        // 网络请求
        [searchUserCar searchUserCarLoadRequestData:self.searchVCView.userCarTableView.userCarTable params:params success:^(NSMutableArray *userArray) {
            [self.searchVCView.userCarTableView.userCarArray addObjectsFromArray:userArray];
            [self.searchVCView.userCarTableView.userCarTable reloadData];
        }];
    }];
}
// 请求查询用户卡
- (void)userCardRequestData {
    SearchUserCardNetwork *searchUserCard = [[SearchUserCardNetwork alloc] init];
    // 下拉刷新
    @weakify(self)
    self.searchVCView.userCardTableView.userCardTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if (self.searchTFView.searchTF.text.length == 0) {
            // 结束下拉刷新
            [self.searchVCView.userCardTableView.userCardTable.mj_header endRefreshing];
            return;
        }
        /*/index.php?c=provider_user&a=search&v=1
         provider_id 	int 	是 	服务商id
         type 	int 	否 	查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
         search_value 	string 	否 	查询值
         start 	int 	否 	记录位置
         pageSize 	int 	否 	每页显示条数    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"search_value"] = self.searchTFView.searchTF.text; // 查询值
        // 网络请求
        [searchUserCard searchUserCardRefreshRequestData:self.searchVCView.userCardTableView.userCardTable params:params success:^(NSMutableArray *userArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 判断是否有数据
            if (userArray.count == 0) {
                // 移除数据，刷新table
                [self.searchVCView.userCardTableView.userCardArray removeAllObjects];
                [self.searchVCView.userCardTableView.userCardTable reloadData];
                // 展示无数据占位
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.searchVCView.userCardTableView.userCardTable.mas_centerX);
                        make.centerY.equalTo(self.searchVCView.userCardTableView.userCardTable.mas_centerY).offset(-20);
                    }];
                }];
            }else {
                self.searchVCView.userCardTableView.userCardArray = userArray;
                [self.searchVCView.userCardTableView.userCardTable reloadData];
            }
        }];
    }];
    // 上拉加载
    self.searchVCView.userCardTableView.userCardTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if (self.searchTFView.searchTF.text.length == 0) {
            // 结束下拉刷新
            [self.searchVCView.userCardTableView.userCardTable.mj_footer endRefreshing];
            return;
        }
        /*/index.php?c=provider_user&a=search&v=1
         provider_id 	int 	是 	服务商id
         type 	int 	否 	查询类型 1-用户信息 2-车辆信息 3-卡信息 ，默认为1
         search_value 	string 	否 	查询值
         start 	int 	否 	记录位置
         pageSize 	int 	否 	每页显示条数    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        params[@"search_value"] = self.searchTFView.searchTF.text; // 查询值
        // 网络请求
        [searchUserCard searchUserCardLoadRequestData:self.searchVCView.userCardTableView.userCardTable params:params success:^(NSMutableArray *userArray) {
            [self.searchVCView.userCardTableView.userCardArray addObjectsFromArray:userArray];
            [self.searchVCView.userCardTableView.userCardTable reloadData];
        }];
    }];
}

#pragma mark - 按钮点击方法
// nav右边按钮点击方法
- (void)searchRightBarBtnAction {
    [self.searchTFView endEditing:YES];
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - textField输入代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断输入框内容为空，不刷新
    NSString *tfText = [self.searchTFView.searchTF.text stringByAppendingString:string];
    if (tfText.length == 0) {
        return YES;
    }
    NSInteger page = self.searchVCView.backScrollView.contentOffset.x / ScreenW;
    switch (page) {
        case 0: {
            // 马上刷新用户列表
            [self.searchVCView.userTableView.userTable.mj_header beginRefreshing];
            break;
        }
        case 1: {
            // 马上刷新车辆列表
            [self.searchVCView.userCarTableView.userCarTable.mj_header beginRefreshing];
            break;
        }
        case 2: {
            // 马上刷新卡列表
            [self.searchVCView.userCardTableView.userCardTable.mj_header beginRefreshing];
            break;
        }
        default:
            break;
    }
    return YES;
}
#pragma mark - 切换搜索类型代理
- (void)searchVCbuttonAction:(UIButton *)button {
    // 判断输入框内容为空，不刷新
    if (self.searchTFView.searchTF.text.length == 0) {
        // 移除无数据视图
        [self removeNoDataView];
        return;
    }
    NSInteger page = button.tag - 2010;
    switch (page) {
        case 0: {
            // 马上刷新用户列表
            [self.searchVCView.userTableView.userTable.mj_header beginRefreshing];
            break;
        }
        case 1: {
            // 马上刷新车辆列表
            [self.searchVCView.userCarTableView.userCarTable.mj_header beginRefreshing];
            break;
        }
        case 2: {
            // 马上刷新卡列表
            [self.searchVCView.userCardTableView.userCardTable.mj_header beginRefreshing];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 点击用户tablecell代理
- (void)userTableDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *userBasicInfo = self.searchVCView.userTableView.userArray[indexPath.row];
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    userInfoVC.providerUserId = [NSString stringWithFormat:@"%ld", userBasicInfo.provider_user_id];
    [self.navigationController pushViewController:userInfoVC animated:YES];
}
#pragma mark - 点击用户车辆tablecell代理
- (void)userCarTableDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取车辆模型
    UserCarModel *carModel = self.searchVCView.userCarTableView.userCarArray[indexPath.row];
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    userInfoVC.providerUserId = carModel.provider_user_id;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}
#pragma mark - 点击用户卡编辑、充值代理
///** 编辑 */
//- (void)userCardCellEditBtnAction:(UIButton *)button {
//    // 获取当前点击的订单模型
//    UserCardModel *userCard = [self.searchVCView.userCardTableView.userCardArray objectAtIndex:button.tag];
//    EditUserCardViewController *editUserCardVC = [[EditUserCardViewController alloc] init];
//    editUserCardVC.userCard = userCard;
//    editUserCardVC.EditUserCardSuccessBlock = ^(UserCardModel *userCard) {
//        [self.searchVCView.userCardTableView.userCardTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:button.tag inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
//    };
//    [self.navigationController pushViewController:editUserCardVC animated:YES];
//}
///** 充值 */
//- (void)userCardCellRechargeBtnAction:(UIButton *)button {
//    // 获取当前点击的订单模型
//    UserCardModel *userCard = [self.searchVCView.userCardTableView.userCardArray objectAtIndex:button.tag];
//    UserCardRechargeViewController *userCardRechargeVC = [[UserCardRechargeViewController alloc] init];
//    userCardRechargeVC.userCard = userCard;
//    userCardRechargeVC.UserCardRechargeSuccessBlock = ^(UserCardModel *userCard) {
//        [self.searchVCView.userCardTableView.userCardTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:button.tag inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
//    };
//    [self.navigationController pushViewController:userCardRechargeVC animated:YES];
//}

#pragma mark - 界面赋值
- (void)searchAssignment {
    
}


#pragma mark - 布局nav
- (void)searchLayoutNAV {
    /** 搜索输入框 */
    self.searchTFView = [[SearchView alloc] init];
    self.searchTFView.isSearch = YES;
    self.searchTFView.isViewBtn = YES;
    self.searchTFView.isSearchWidth = YES;
    // 遵守TextField代理
    self.searchTFView.searchTF.delegate = self;
    self.searchTFView.searchTF.textColor = Black;
    [self.searchTFView.searchTF setValue:NotClick  forKeyPath:@"_placeholderLabel.textColor"];
    self.searchTFView.searchTF.tintColor = ThemeColor;
    self.searchTFView.searchView.backgroundColor = WhiteColor;
    self.searchTFView.searchMagnifierImage.image = [UIImage imageNamed:@"nav_search_gray"];
    self.navigationItem.titleView = self.searchTFView;
    // 左边
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_close"] style:UIBarButtonItemStyleDone target:self action:@selector(searchRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)searchLayoutView {
    /** 搜索view */
    self.searchVCView = [[SearchVCView alloc] init];
    self.searchVCView.delegate = self;
    self.searchVCView.userTableView.delegate = self;
    self.searchVCView.userCarTableView.delegate = self;
    self.searchVCView.userCardTableView.delegate = self;
    [self.view addSubview:self.searchVCView];
    @weakify(self)
    [self.searchVCView mas_makeConstraints:^(MASConstraintMaker *make) {
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
