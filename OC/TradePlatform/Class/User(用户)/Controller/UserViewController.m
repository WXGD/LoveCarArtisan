//
//  UserViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserViewController.h"
// view
#import "SearchView.h"
// table
#import "GJBaseTabelView.h"
#import "UserDataSource.h"
// 下级控制器
#import "UserInfoViewController.h"
#import "AddUserViewController.h"
#import "SearchViewController.h"

@interface UserViewController ()<GJTableViewDelegate, UITextFieldDelegate>

/** 客户信息table */
@property (strong, nonatomic) GJBaseTabelView *userTable;
/** 客户信息数据 */
@property (strong, nonatomic) UserDataSource *userTableDataSource;
/** 搜索框view */
@property (strong, nonatomic) SearchView *searchTFView;

@end

@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 马上进入刷新状态
    [self.userTable.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self userLayoutNAV];
    // 布局视图
    [self userLayoutView];
    // 网络请求
    [self userRequestData];
}
#pragma mark - 网络请求
- (void)userRequestData {
    /*/index.php?c=provider_user&a=list&v=1
     provider_id 	int 	是 	服务商id
     user_input 	string 	否 	用户手机号(支持模糊输入)
     start 	int 	否 	查询开始位置，默认为0
     pageSize 	int 	否 	每页显示条数，默认为10   */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
    params[@"user_input"] = self.searchTFView.searchTF.text; // 用户手机号
    // 下拉刷新
    @weakify(self)
    self.userTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求
        [self.userTableDataSource userRefreshRequestData:self.userTable params:params viewController:self success:^(NSInteger arrayCount) {
            // 移除无数据视图
            [self removeNoDataView];
            if (arrayCount == 0) {
                // 判断是否有数据
                if (arrayCount == 0) {
                    [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                        [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(self.userTable.mas_centerX);
                            make.centerY.equalTo(self.userTable.mas_centerY);
                            make.top.equalTo(noImage.mas_top);
                            make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                            make.width.mas_equalTo(ScreenW);
                        }];
                    }];
                }
            }
        }];
    }];
    // 上拉加载
    self.userTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [self.userTableDataSource userLoadRequestData:self.userTable params:params viewController:self success:^{
            
        }];
    }];
}
#pragma mark - 按钮点击方法
// cell按钮点击方法
- (void)tableView:(UITableView *)tableView rowDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *userBasicInfo = self.userTableDataSource.rowArray[indexPath.row];
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    userInfoVC.providerUserId = [NSString stringWithFormat:@"%ld", userBasicInfo.provider_user_id];
    [self.navigationController pushViewController:userInfoVC animated:YES];
}
// nav右边
- (void)UserRightBarButtonItmeAction {
    AddUserViewController *addUserVC = [[AddUserViewController alloc] init];
    [self.navigationController pushViewController:addUserVC animated:YES];
}


// 搜索view点击按钮
- (void)searchViewBtnAction:(UIButton *)button {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:searchVC] animated:nil completion:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
}

#pragma mark - textField输入代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断输入框内容为空，不刷新
    NSString *tfText = [self.searchTFView.searchTF.text stringByAppendingString:string];
    if (tfText.length == 0) {
        return YES;
    }
    // 马上刷新用户列表
    [self.userTable.mj_header beginRefreshing];
    return YES;
}


#pragma mark - 布局nav
- (void)userLayoutNAV {
    self.navigationItem.title = @"用户";
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add_user"] style:UIBarButtonItemStyleDone target:self action:@selector(UserRightBarButtonItmeAction)];
    // 左边
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(UserRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)userLayoutView {
    @weakify(self)
    /** 客户信息table */
    self.userTable = [[GJBaseTabelView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.userTableDataSource = [[UserDataSource alloc] init];
    self.userTable.GJDataSource = self.userTableDataSource;
    self.userTable.GJDelegate = self;
    self.userTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTable.backgroundColor = CLEARCOLOR;
    [self.view addSubview:self.userTable];
    [self.userTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    // tableview高度随数据高度变化而变化
    [self.userTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // table头部view
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    // 搜索框view
    self.searchTFView = [[SearchView alloc] init];
    self.searchTFView.searchTF.delegate = self;
    self.searchTFView.isSearch = YES;
    self.searchTFView.searchType = OrdinaryViewLayout;
    self.searchTFView.searchTF.textColor = Black;
    self.searchTFView.searchTF.placeholder = @"搜索";
    [self.searchTFView.searchTF setValue:NotClick  forKeyPath:@"_placeholderLabel.textColor"];
    self.searchTFView.searchTF.tintColor = ThemeColor;
    self.searchTFView.searchView.backgroundColor = WhiteColor;
    self.searchTFView.searchMagnifierImage.image = [UIImage imageNamed:@"nav_search_gray"];
    [self.searchTFView.viewBtn addTarget:self action:@selector(searchViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:self.searchTFView];
    [self.searchTFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableHeaderView.mas_top).offset(10);
        make.left.equalTo(tableHeaderView.mas_left).offset(16);
        make.right.equalTo(tableHeaderView.mas_right).offset(-16);
        make.height.mas_equalTo(@30);
    }];
    self.userTable.tableHeaderView = tableHeaderView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
