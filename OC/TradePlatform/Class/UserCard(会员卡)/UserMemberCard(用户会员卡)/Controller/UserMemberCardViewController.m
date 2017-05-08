//
//  UserMemberCardViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserMemberCardViewController.h"
// view
#import "UserMemberCardView.h"
#import "MemberCardNavBtn.h"
#import "CashierServiceChoiceView.h"
// 下级控制器
#import "UserCardRechargeViewController.h"
#import "EditUserCardViewController.h"
#import "SearchViewController.h"

@interface UserMemberCardViewController ()<CashierServiceChoiceDelegate, UserMemberCardDelegate>
/** 用户会员卡view */
@property (strong, nonatomic) UserMemberCardView *userMemberCardView;
/** 用户会员卡nav中间按钮 */
@property (strong, nonatomic) MemberCardNavBtn *memberCardNavBtn;

@end

@implementation UserMemberCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 马上进入刷新状态
    [self.userMemberCardView.userMemberCardTypeTable.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self userMemberCardLayoutNAV];
    // 布局视图
    [self userMemberCardLayoutView];
    // 网络请求
    [self userMemberCardRequest];
}
#pragma mark - 网络请求
- (void)userMemberCardRequest {
    UserMemberCardModel *userMemberCardModel = [[UserMemberCardModel alloc] init];
    // 下拉刷新
    @weakify(self)
    self.userMemberCardView.userMemberCardTypeTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        /*/index.php?c=provider_card&a=statistic&v=1
         provider_id 	int 	是 	服务商id
         provider_card_id 	int 	是 	服务商卡id(全部为0)
         start 	int 	否 	页数，默认为0
         pageSize 	int 	否 	每页显示条数,默认为10    */
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
        params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardTypeModel.provider_card_id]; // 卡id(全部为0)
        // 网络请求
        [userMemberCardModel userCardRequestData:self.userMemberCardView.userMemberCardTypeTable params:params viewController:self success:^(NSMutableArray *userCardArray, NSDictionary *options) {
            // 界面赋值
            [self userMemberCardAssignment:options];
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.userMemberCardView.userMemberCardTypeArray removeAllObjects];
            // 判断是否有数据
            if (userCardArray.count == 0) {
                [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.userMemberCardView.userMemberCardTypeTable.mas_centerX);
                        make.centerY.equalTo(self.userMemberCardView.userMemberCardTypeTable.mas_centerY);
                    }];
                }];
            }else {
                self.userMemberCardView.userMemberCardTypeArray = userCardArray;
            }
            [self.userMemberCardView.userMemberCardTypeTable reloadData];
        }];
    }];
    // 上拉加载
    self.userMemberCardView.userMemberCardTypeTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /*/index.php?c=provider_card&a=statistic&v=1
         provider_id 	int 	是 	服务商id
         provider_card_id 	int 	是 	服务商卡id(全部为0)
         start 	int 	否 	页数，默认为0
         pageSize 	int 	否 	每页显示条数,默认为10    */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
        params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardTypeModel.provider_card_id]; // 卡id(全部为0)
        // 网络请求
        [userMemberCardModel userCardLoadRequestData:self.userMemberCardView.userMemberCardTypeTable params:params viewController:self success:^(NSMutableArray *userCardArray) {
            [self.userMemberCardView.userMemberCardTypeArray addObjectsFromArray:userCardArray];
            [self.userMemberCardView.userMemberCardTypeTable reloadData];
        }];
    }];
//    // 马上进入刷新状态
//    [self.userMemberCardView.userMemberCardTypeTable.mj_header beginRefreshing];
}


#pragma mark - 按钮点击方法
/** 编辑 */
- (void)editClickAction:(NSInteger)tag {
    EditUserCardViewController *editUserCardVC = [[EditUserCardViewController alloc] init];
    editUserCardVC.userCard = [self.userMemberCardView.userMemberCardTypeArray objectAtIndex:tag];
    editUserCardVC.EditUserCardSuccessBlock = ^(UserMemberCardModel *userCard) {
        [self.userMemberCardView.userMemberCardTypeTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:tag inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:editUserCardVC animated:YES];
}
/** 充值 */
- (void)rechargeClickAction:(NSInteger)tag {
    UserCardRechargeViewController *userCardRechargeVC = [[UserCardRechargeViewController alloc] init];
    userCardRechargeVC.userCard = [self.userMemberCardView.userMemberCardTypeArray objectAtIndex:tag];
    [self.navigationController pushViewController:userCardRechargeVC animated:YES];
}


#pragma mark - 会员卡页功能选择按钮
- (void)userMemberCardBtnAvtion:(UIButton *)button {
    
}

// nav中间按钮点击, 选中切换会员卡类型
- (void)memberCardNavBtnAction:(UIButton *)button {
        // 遍历所有服务，找到当前选中的服务
        for (CardTypeModel *cardTypeModel in self.cardTypeArray) {
            cardTypeModel.checkMark = NO;
            if (cardTypeModel.provider_card_id == self.cardTypeModel.provider_card_id) {
                cardTypeModel.checkMark = YES;
            }
        }
        // 弹出支付方式选择
        CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
        payChoiceBoxView.choiceArray = self.cardTypeArray;
        payChoiceBoxView.serviceChoice = UserCardTyoeChoiceBtnAction;
        payChoiceBoxView.delegate = self;
        [payChoiceBoxView show];
}
// nav右边按钮点击
- (void)userMemberCardRightBarBtnAction {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:NO];
}
// 选中会员卡类型
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    /** 当前选中会员卡 */
    self.cardTypeModel = [choiceArray objectAtIndex:indexPath.row];
    // 马上进入刷新状态
    [self.userMemberCardView.userMemberCardTypeTable.mj_header beginRefreshing];
}


#pragma mark - 界面赋值
- (void)userMemberCardAssignment:(NSDictionary *)options {
    // 用户会员卡nav中间按钮赋值
    self.memberCardNavBtn.cardNameLabel.text = [NSString stringWithFormat:@"%@(%ld)", self.cardTypeModel.name, self.cardTypeModel.count];
    /** 总储值次数 */
    self.userMemberCardView.totalSaveNumLabel.bomText.text = [NSString stringWithFormat:@"%@次", options[@"count"]];
    /** 总储值金额 */
    NSString *amountStr = [NSString stringWithFormat:@"%@", options[@"amount"]];
    double amount = [amountStr doubleValue];
    self.userMemberCardView.totalSaveMoneyLabel.bomText.text = [NSString stringWithFormat:@"%.2f元", amount];
}


#pragma mark - 布局nav
- (void)userMemberCardLayoutNAV {
    self.memberCardNavBtn = [[MemberCardNavBtn alloc] init];
    [self.memberCardNavBtn addTarget:self action:@selector(memberCardNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.memberCardNavBtn;
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(userMemberCardRightBarBtnAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user_card_nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(userMemberCardRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)userMemberCardLayoutView {
    /** 用户会员卡view */
    self.userMemberCardView = [[UserMemberCardView alloc] init];
    self.userMemberCardView.delegate = self;
    [self.view addSubview:self.userMemberCardView];
    @weakify(self)
    [self.userMemberCardView mas_makeConstraints:^(MASConstraintMaker *make) {
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
