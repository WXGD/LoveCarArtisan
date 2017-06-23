//
//  UserCarOptViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCarOptViewController.h"
// model
#import "UserCarOptNetwork.h"
#import "UserCarOptCell.h"

@interface UserCarOptViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 车辆选择table */
@property (strong, nonatomic) UITableView *carOptTable;
/** 车辆选择array */
@property (strong, nonatomic) NSMutableArray *carOptArray;

@end

@implementation UserCarOptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self userCarOptLayoutNAV];
    // 布局视图
    [self userCarOptLayoutView];
    // 网络请求
    [self userCarOptRequestData];
}

#pragma mark - 网络请求
- (void)userCarOptRequestData {
    // 初始化订单请求类
    UserCarOptNetwork *userCarOpt = [[UserCarOptNetwork alloc] init];
    /*/index.php?c=provider_user_car&a=list&v=2
     provider_id 	int 	是 	服务商id
     mobile 	string 	否 	手机号      */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"mobile"] = self.userModel.mobile; // 手机号
    // 下拉刷新
    @weakify(self)
    self.carOptTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求
        [userCarOpt userCarOptRefreshRequestData:self.carOptTable params:params viewController:self success:^(NSMutableArray *userCarOptArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.carOptArray removeAllObjects];
            // 判断是否有数据
            if (userCarOptArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.carOptTable.mas_centerX);
                        make.centerY.equalTo(self.carOptTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.carOptArray = userCarOptArray;
            }
            [self.carOptTable reloadData];
            
        }];
    }];
    // 上拉加载
    self.carOptTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [userCarOpt userCarOptLoadRequestData:self.carOptTable params:params viewController:self success:^(NSMutableArray *userCarOptArray) {
            [self.carOptArray addObjectsFromArray:userCarOptArray];
            [self.carOptTable reloadData];
        }];
    }];
    // 马上进入刷新状态
    [self.carOptTable.mj_header beginRefreshing];
}


#pragma mark - 布局nav
- (void)userCarOptLayoutNAV {
    self.navigationItem.title = @"选择车辆";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(userCarOptRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)userCarOptLayoutView {
    /** 车辆选择table */
    self.carOptTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.carOptTable.delegate = self;
    self.carOptTable.dataSource = self;
    self.carOptTable.backgroundColor = CLEARCOLOR;
    self.carOptTable.rowHeight = 99;
    self.carOptTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.carOptTable];
}
#pragma mark - table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carOptArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"userCarOptCell";
    UserCarOptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UserCarOptCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    PDLog(@"%@", NSStringFromCGRect(cell.cellBackView.frame));
    
    cell.userCarModel = [self.carOptArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserCarModel *userCarModel = [self.carOptArray objectAtIndex:indexPath.row];
    if (_ChoiceCarBlock) {
        _ChoiceCarBlock(userCarModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
