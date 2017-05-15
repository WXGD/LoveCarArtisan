//
//  CancellationViewController.m
//  TradePlatform
//
//  Created by 弓杰 on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CancellationViewController.h"
// view
#import "CancellationViewCell.h"
// 下级控制器
#import "PaySuccessViewController.h"

@interface CancellationViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 核销Tableview */
@property (strong, nonatomic) UITableView *cancellationTable;

@end

@implementation CancellationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self cancellationLayoutNAV];
    // 布局视图
    [self cancellationLayoutView];
}
#pragma mark - 网络请求

#pragma mark - 核销选择按钮
/** 核销按钮 */
- (void)choiceCardBtnAction:(UIButton *)button {
    
}
#pragma mark - 布局nav
- (void)cancellationLayoutNAV {
    self.navigationItem.title = @"核销";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(cancellationRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(cancellationRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)cancellationLayoutView {
    /** 核销Tableview */
    self.cancellationTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.cancellationTable.delegate = self;
    self.cancellationTable.dataSource = self;
    self.cancellationTable.backgroundColor = CLEARCOLOR;
    self.cancellationTable.rowHeight = 80;
    [self.cancellationTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    [self.view addSubview:self.cancellationTable];
    // tableview高度随数据高度变化而变化
    [self.cancellationTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    @weakify(self)
    [self.cancellationTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cancellationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cardTypeCell";
    CancellationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CancellationViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.cancellationModel = [self.cancellationArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CancellationModel *cancellationModel = [self.cancellationArray objectAtIndex:indexPath.row];
    /*/index.php?c=order&a=consume&v=1
     order_detail_id 	int 	是 	订单详情id
     staff_user_id 	int 	是 	登录者id     */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"order_detail_id"] = [NSString stringWithFormat:@"%ld", cancellationModel.order_detail_id]; // 服务商id
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id，
    [CancellationModel useGifts:params success:^{
        [MBProgressHUD showSuccess:@"核销成功"];
        [self.navigationController popViewControllerAnimated:YES];
//        PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
//        paySuccessVC.userInfo = self.userInfo;
//        [self.navigationController pushViewController:paySuccessVC animated:YES];
//        // 删除扫一扫界面列表界面
//        NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//        [navViews removeObject:self];
//        [self.navigationController setViewControllers:navViews animated:YES];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
