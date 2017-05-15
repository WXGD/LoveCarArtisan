//
//  AccountBankViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AccountBankViewController.h"
#import "AccountBankAddViewController.h"
#import "AccountBankCell.h"

@interface AccountBankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *accountBankTab;

@property (strong, nonatomic) NSMutableArray *accountBankArr;

@end

@implementation AccountBankViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 网络请求
    [self bankRequestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    // 布局nav
    [self bankLayoutNAV];
    // 布局视图
    [self bankLayoutView];
    
}
-(void)bankRequestData{
    AccountBankModel *accountBankModel = [[AccountBankModel alloc] init];
    // 下拉刷新
    @weakify(self) self.accountBankTab.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求
        
        [accountBankModel AccountBankRefreshRequestData:self.accountBankTab params:params viewController:self success:^(AccountBankModel *accountBankModel) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.accountBankArr removeAllObjects];
            // 判断是否有数据
            if (!accountBankModel.DefaultModel && accountBankModel.common.count==0) {
                [self showNoDataView:^(UILabel *noLabel,
                                       UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(
                                                     MASConstraintMaker *make) {
                        make.centerX.equalTo(
                                             self.accountBankTab.mas_centerX);
                        make.centerY.equalTo(
                                             self.accountBankTab.mas_centerY);
                        noLabel.text = @"暂无银行卡";
                        noImage.image =
                        [UIImage imageNamed:@"pendorder_zero"];
                    }];
                }];
            } else {
                NSMutableArray *defaultArr = accountBankModel.common.mutableCopy;
                if (accountBankModel.DefaultModel) {
                    [defaultArr insertObject:accountBankModel.DefaultModel atIndex:0];

                }
                self.accountBankArr = defaultArr;
            }
            [self.accountBankTab reloadData];
            
        }];
    }];
    // 马上进入刷新状态
    [self.accountBankTab.mj_header beginRefreshing];
}
#pragma mark - 布局nav
- (void)bankLayoutNAV {
    if (_bankViewFrom==BankSelect) {
        self.navigationItem.title = @"选择银行卡";
    }else if (_bankViewFrom==management) {
        self.navigationItem.title = @"银行卡绑定";
        // 右边
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bank_add"] style:UIBarButtonItemStyleDone target:self action:@selector(addBankCard)];
        
        
//        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBankCard)];
//        // 左边
//            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    }
}
#pragma mark - 绑定银行卡
- (void)addBankCard {
    AccountBankAddViewController *accountBankAddVC= [[AccountBankAddViewController alloc] init];
    [self.navigationController pushViewController:accountBankAddVC animated:YES];
}
#pragma mark - 布局视图
- (void)bankLayoutView{
    _accountBankTab = [[UITableView alloc] init];
    _accountBankTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _accountBankTab.delegate = self;
    _accountBankTab.dataSource = self;
    _accountBankTab.backgroundColor = CLEARCOLOR;
    _accountBankTab.rowHeight = UITableViewAutomaticDimension;
    _accountBankTab.estimatedRowHeight = 100;
    [self.view addSubview:_accountBankTab];
    @weakify(self)
    /** 出险记录 */
    [self.accountBankTab mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
#pragma mark - tableviewDegate、DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _accountBankArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"AccountBankCell";
    AccountBankCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil][0];
    }
    cell.cancelBtnClick = ^(BankCommonModel *bankCommonModel) {
        NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
        dic[@"provider_id"] = self.merchantInfo.provider_id; ;
        dic[@"provider_bank_account_id"] = bankCommonModel.provider_bank_account_id;
        dic[@"type"] = @"del";
        [self cancelOrSetDefauBank:dic];
    };
    cell.setDefaultBtnClick = ^(BankCommonModel *bankCommonModel) {
        NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
        dic[@"provider_id"] = self.merchantInfo.provider_id; ;
        dic[@"provider_bank_account_id"] = bankCommonModel.provider_bank_account_id;
        dic[@"type"] = @"set";
        [self cancelOrSetDefauBank:dic];
    };
    cell.indP = indexPath;
    cell.bankViewFrom = self.bankViewFrom;
    cell.bankCommonModel = _accountBankArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_bankViewFrom == 1) {
       BankCommonModel *model = _accountBankArr[indexPath.row];
        if (_selextBankClick) {
            _selextBankClick(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
// 解绑  设置默认账户
- (void)cancelOrSetDefauBank:(NSDictionary *)parameters{
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_bank_account", @"edit", APIEdition];
    
    
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"处理中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [self.accountBankTab.mj_header beginRefreshing];
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
