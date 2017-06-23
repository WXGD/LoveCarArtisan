//
//  UserCardListViewController.m
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardListViewController.h"
// 网络请求
#import "UserCardListNetwork.h"
// view
#import "UserCardListTableViewCell.h"
// 下级控制器
#import "EditUserCardViewController.h"
#import "UserCardRechargeViewController.h"

@interface UserCardListViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 会员卡列表 */
@property (strong, nonatomic) UITableView *userCardListTableView;
/** 会员卡列表数据 */
@property (strong, nonatomic) NSMutableArray *userCardListModelArray;
/** 保存当前点击cell的row */
@property (assign, nonatomic) NSInteger currentRow;

@end

@implementation UserCardListViewController

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
    [self userCardListLayoutNAV];
    // 布局视图
    [self userCardListLayoutView];
    // 网络请求
    [self userCardListRepuestData];
}
#pragma mark - 网络请求
- (void)userCardListRepuestData {
    // 初始化用户卡列表请求类
    UserCardListNetwork *cardListNetwork = [[UserCardListNetwork alloc] init];
    /*/index.php?c=provider_user_card&a=list&v=1
     provider_id 	int 	是 	服务商id
     provider_user_id 	int 	否 	用户id(用户信息中查看卡信息必传)     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"provider_user_id"] = [NSString stringWithFormat:@"%ld", self.userModel.provider_user_id]; // 用户id(用户信息中查看卡信息必传)
    // 下拉刷新
    @weakify(self)
    self.userCardListTableView.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求
        [cardListNetwork cardListRefreshRequestData:self.userCardListTableView params:params viewController:self success:^(NSMutableArray *userCardArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 修改背景颜色
            self.userCardListTableView.backgroundColor = ThemeColor;
            // 判断有无数据
            if (userCardArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    // 修改背景颜色
                    self.userCardListTableView.backgroundColor = VCBackground;
                    noLabel.text = @"无会员卡";
                    noImage.image = [UIImage imageNamed:@"placeholder_nothing_card"];
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.userCardListTableView.mas_centerX);
                        make.centerY.equalTo(self.userCardListTableView.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.userCardListModelArray = userCardArray;
                [self.userCardListTableView reloadData];
            }
        }];
    }];
    // 上拉加载
    self.userCardListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [cardListNetwork cardListLoadRequestData:self.userCardListTableView params:params viewController:self success:^(NSMutableArray *userCardArray) {
            [self.userCardListModelArray addObjectsFromArray:userCardArray];
            [self.userCardListTableView reloadData];
        }];
    }];
    // 马上进入刷新状态
    [self.userCardListTableView.mj_header beginRefreshing];
}
#pragma mark - 按钮点击方法
/** 编辑 */
- (void)editBtnAction:(UIButton *)button {
    // 获取当前点击的订单模型
    UserMemberCardModel *userCard = [self.userCardListModelArray objectAtIndex:button.tag];
    EditUserCardViewController *editUserCardVC = [[EditUserCardViewController alloc] init];
    editUserCardVC.userCard = userCard;
    editUserCardVC.EditUserCardSuccessBlock = ^(UserMemberCardModel *userCard) {
        [self.userCardListTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:button.tag inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:editUserCardVC animated:YES];
}
/** 充值 */
- (void)rechargeBtnAction:(UIButton *)button {
    // 获取当前点击的订单模型
    UserMemberCardModel *userCard = [self.userCardListModelArray objectAtIndex:button.tag];
    UserCardRechargeViewController *userCardRechargeVC = [[UserCardRechargeViewController alloc] init];
    userCardRechargeVC.userCard = userCard;
    [self.navigationController pushViewController:userCardRechargeVC animated:YES];
}


#pragma mark - 界面赋值
- (void)userCardListAssignment {
    
}
#pragma mark - 布局nav
- (void)userCardListLayoutNAV {
    self.navigationItem.title = @"会员卡列表";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(userCardListLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(userCardListRightBarBtnAction)];
}
#pragma mark - 布局视图
- (void)userCardListLayoutView {
    /** 消息 */
    self.userCardListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.userCardListTableView.backgroundColor = ThemeColor;
    self.userCardListTableView.delegate = self;
    self.userCardListTableView.dataSource = self;
    self.userCardListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.userCardListTableView];
}
#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userCardListModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"userCardListTableCell";
    UserCardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UserCardListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.userCardModel = [self.userCardListModelArray objectAtIndex:indexPath.row];
    /** 编辑 */
    cell.userCardListCellView.editBtn.tag = indexPath.row;
    [cell.userCardListCellView.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 充值 */
    cell.userCardListCellView.rechargeBtn.tag = indexPath.row;
    [cell.userCardListCellView.rechargeBtn addTarget:self action:@selector(rechargeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 得到当前的模型
    UserMemberCardModel *userCardModel = [self.userCardListModelArray objectAtIndex:indexPath.row];
    // 计算实际需要的高度
    CGFloat height = 0;
    if (userCardModel.used_goods_text.length != 0) {
        height = [CustomString heightForString:userCardModel.used_goods_text textFont:TwelveTypeface textWidth:ScreenW - 64];
    }
    return 224 + height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.currentRow = indexPath.row;
////    [tableView reloadData];
//    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
