//
//  SearchUserViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchUserViewController.h"
// view
#import "SearchView.h"
// table
#import "GJBaseTabelView.h"


@interface SearchUserViewController ()<UITextFieldDelegate, GJTableViewDelegate>

/** 搜索输入框 */
@property (strong, nonatomic) SearchView *searchUserTFView;
/** 客户信息table */
@property (strong, nonatomic) GJBaseTabelView *searchUserTable;
/** 客户信息数据 */
@property (strong, nonatomic) UserDataSource *searchUserTableDataSource;

@end

@implementation SearchUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self searchUserLayoutNAV];
    // 布局视图
    [self searchUserLayoutView];
    // 网络请求
    [self searchUserRequestData];
}
#pragma mark - 网络请求
- (void)searchUserRequestData {
    // 下拉刷新
    @weakify(self)
    self.searchUserTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        /*/index.php?c=provider_user&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_input 	string 	否 	用户手机号(支持模糊输入)
         start 	int 	否 	查询开始位置，默认为0
         pageSize 	int 	否 	每页显示条数，默认为10   */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
        params[@"user_input"] = self.searchUserTFView.searchTF.text; // 用户手机号
        // 网络请求
        [self.searchUserTableDataSource userRefreshRequestData:self.searchUserTable params:params viewController:self success:^(NSInteger arrayCount) {
            // 移除无数据视图
            [self removeNoDataView];
            if (arrayCount == 0) {
                // 判断是否有数据
                if (arrayCount == 0) {
                    [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                        [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(self.searchUserTable.mas_centerX);
                            make.centerY.equalTo(self.searchUserTable.mas_centerY);
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
    self.searchUserTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /*/index.php?c=provider_user&a=list&v=1
         provider_id 	int 	是 	服务商id
         user_input 	string 	否 	用户手机号(支持模糊输入)
         start 	int 	否 	查询开始位置，默认为0
         pageSize 	int 	否 	每页显示条数，默认为10   */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
        params[@"user_input"] = self.searchUserTFView.searchTF.text; // 用户手机号
        // 网络请求
        [self.searchUserTableDataSource userLoadRequestData:self.searchUserTable params:params viewController:self success:^{
            
        }];
    }];
    // 马上刷新用户列表
    [self.searchUserTable.mj_header beginRefreshing];
}


#pragma mark - 按钮点击方法
// nav右边按钮点击方法
- (void)searchRightBarBtnAction {
    [self.searchUserTFView endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/** cell点击方法 */
- (void)tableView:(UITableView *)tableView rowDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *userModel = self.searchUserTableDataSource.rowArray[indexPath.row];
    if (_ChoiceUserBlock) {
        _ChoiceUserBlock(userModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - textField输入代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断输入框内容为空，不刷新
    NSString *tfText = [self.searchUserTFView.searchTF.text stringByAppendingString:string];
    if (tfText.length == 0) {
        return YES;
    }
    // 马上刷新用户列表
    [self.searchUserTable.mj_header beginRefreshing];
    return YES;
}


#pragma mark - 布局nav
- (void)searchUserLayoutNAV {
    /** 搜索输入框 */
    self.searchUserTFView = [[SearchView alloc] init];
    self.searchUserTFView.searchTF.placeholder = @"搜索";
    self.searchUserTFView.isSearch = YES;
    self.searchUserTFView.isViewBtn = YES;
    self.searchUserTFView.isSearchWidth = YES;
    // 遵守TextField代理
    self.searchUserTFView.searchTF.delegate = self;
    self.searchUserTFView.searchTF.textColor = Black;
    [self.searchUserTFView.searchTF setValue:NotClick  forKeyPath:@"_placeholderLabel.textColor"];
    self.searchUserTFView.searchTF.tintColor = ThemeColor;
    self.searchUserTFView.searchView.backgroundColor = WhiteColor;
    self.searchUserTFView.searchMagnifierImage.image = [UIImage imageNamed:@"nav_search_gray"];
    self.navigationItem.titleView = self.searchUserTFView;
    // 左边
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_close"] style:UIBarButtonItemStyleDone target:self action:@selector(searchRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)searchUserLayoutView {
    @weakify(self)
    /** 客户信息table */
    self.searchUserTable = [[GJBaseTabelView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.searchUserTableDataSource = [[UserDataSource alloc] init];
    self.searchUserTable.GJDataSource = self.searchUserTableDataSource;
    self.searchUserTable.GJDelegate = self;
    self.searchUserTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchUserTable.backgroundColor = CLEARCOLOR;
    [self.view addSubview:self.searchUserTable];
    [self.searchUserTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    // tableview高度随数据高度变化而变化
    [self.searchUserTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
