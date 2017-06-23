//
//  UserCardViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardViewController.h"
// view
#import "UserCardView.h"
// 下级控制器
#import "CustomOpenCardViewController.h"
#import "CardInfoViewController.h"
#import "NewAddCardViewController.h"
#import "UserMemberCardViewController.h"
#import "OpenCardViewController.h"

@interface UserCardViewController ()<UserCardDelegate>

/** 会员卡view */
@property (strong, nonatomic) UserCardView *userCardView;

@end

@implementation UserCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
    [self userCardLayoutNAV];
    // 布局视图
    [self userCardLayoutView];
    // 请求会员卡类型
    [self requestUserCardType];
}
#pragma mark - 网络请求
// 请求会员卡类型
- (void)requestUserCardType {
    // 下拉刷新
    @weakify(self)
    self.userCardView.userCardTypeTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        /* /index.php?c=provider_card&a=list&v=1
         provider_id 	int 	是 	服务商id     */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        [CardTypeModel requestCardTypeListDataParams:params tableView:self.userCardView.userCardTypeTable success:^(NSMutableArray *cardTypeArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 判断是否有数据
            if (cardTypeArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    noLabel.text = @"还没有卡，点击左上方的“新增卡”去添加一张吧！";
                    noImage.image = [UIImage imageNamed:@"placeholder_card"];
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.userCardView.userCardTypeTable.mas_centerX);
                        make.centerY.equalTo(self.userCardView.userCardTypeTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.userCardView.userCardTypeArray = cardTypeArray;
                [self.userCardView.userCardTypeTable reloadData];
            }
        }];
    }];
    // 马上刷新
    [self.userCardView.userCardTypeTable.mj_header beginRefreshing];
}

#pragma mark - 按钮点击方法
// nav右边按钮
- (void)userCardRightBarBtnAction {


}
// 类型cell点击
- (void)tableView:(UITableView *)tableView CardTypeCellClickIndexPath:(NSIndexPath *)indexPath {
    CardInfoViewController *cardInfoVC = [[CardInfoViewController alloc] init];
    cardInfoVC.cardTypeInfoModel = [self.userCardView.userCardTypeArray objectAtIndex:indexPath.row];
    cardInfoVC.CardInfoBlock = ^(CardTypeModel *cardInfoModel) {
        // 马上刷新
        [self.userCardView.userCardTypeTable.mj_header beginRefreshing];
//        [self.userCardView.userCardTypeTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:cardInfoVC animated:YES];
}
// 用户会员卡按钮点击
- (void)userCardClickAction:(NSInteger)tag {
    UserMemberCardViewController *userMemberCardVC = [[UserMemberCardViewController alloc] init];
    userMemberCardVC.cardTypeModel = [self.userCardView.userCardTypeArray objectAtIndex:tag];
//    CardTypeModel *wholeCardType = [[CardTypeModel alloc] init];
//    wholeCardType.name = @"全部";
//    [self.userCardView.userCardTypeArray insertObject:wholeCardType atIndex:0];
    userMemberCardVC.cardTypeArray = self.userCardView.userCardTypeArray;
    [self.navigationController pushViewController:userMemberCardVC animated:YES];
}
// 开卡按钮点击
- (void)openCardClickAction:(NSInteger)tag {
    OpenCardViewController *openCardVC = [[OpenCardViewController alloc] init];
    openCardVC.cardTypeModel = [self.userCardView.userCardTypeArray objectAtIndex:tag];
    [self.navigationController pushViewController:openCardVC animated:YES];
}
#pragma mark - 会员卡页功能选择按钮
- (void)userCardBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 新增卡类型 */
        case AddCardTypeBtnAction: {
            NewAddCardViewController *newAddCardVC = [[NewAddCardViewController alloc] init];
            newAddCardVC.addCardSuccess = ^() {
                // 马上刷新
                [self.userCardView.userCardTypeTable.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:newAddCardVC animated:YES];
            break;
        }
            /** 自定义开卡 */
        case CustomOpenCardBtnAction: {
            CustomOpenCardViewController *customOpenCardVC = [[CustomOpenCardViewController alloc] init];
            [self.navigationController pushViewController:customOpenCardVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 界面赋值
- (void)userCardAssignment {
    

}


#pragma mark - 布局nav
- (void)userCardLayoutNAV {
    self.navigationItem.title = @"会员卡";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(userCardRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(userCardRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)userCardLayoutView {
    /** 会员卡view */
    self.userCardView = [[UserCardView alloc] init];
    self.userCardView.delegate = self;
    /** 新增卡类型 */
    [self.userCardView.addCardTypeBtn.topBotBtn addTarget:self action:@selector(userCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 自定义开卡 */
    [self.userCardView.customOpenCardBtn.topBotBtn addTarget:self action:@selector(userCardBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.userCardView];
    @weakify(self)
    [self.userCardView mas_makeConstraints:^(MASConstraintMaker *make) {
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
