//
//  DangerRecordViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DangerRecordViewController.h"
#import "DangerRecordCell.h"
// 下级页面
#import "PolicyDetailViewController.h"
// model
#import "DangerRecordModel.h"

@interface DangerRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong ,nonatomic) UITableView *dangerRecordTab;

/** 出险记录数据 */
@property(strong, nonatomic) NSMutableArray *dangerRecordArray;

@end

@implementation DangerRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self dangerRecordLayoutNAV];
    // 网络请求
    [self dangerRecordRequestData];
}
#pragma mark - 布局nav
- (void)dangerRecordLayoutNAV {
    self.navigationItem.title = @"出险记录";
    _dangerRecordTab = [[UITableView alloc] init];
    _dangerRecordTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dangerRecordTab.delegate = self;
    _dangerRecordTab.dataSource = self;
    _dangerRecordTab.backgroundColor = CLEARCOLOR;
    _dangerRecordTab.rowHeight = UITableViewAutomaticDimension;
    _dangerRecordTab.estimatedRowHeight = 60;
    [self.view addSubview:_dangerRecordTab];
    @weakify(self)
    /** 出险记录 */
    [self.dangerRecordTab mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - 网络请求
- (void)dangerRecordRequestData {
    DangerRecordModel *dangerRecordModel = [[DangerRecordModel alloc] init];
    // 下拉刷新
    @weakify(self) self.dangerRecordTab.mj_header =
    [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求
        
        [dangerRecordModel dangerRecordRefreshRequestData:self.dangerRecordTab params:params viewController:self success:^(NSMutableArray *orderArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 移除所有数据
            [self.dangerRecordArray removeAllObjects];
            // 判断是否有数据
            if (orderArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    noLabel.text = @"暂无询价";
                    noImage.image = [UIImage imageNamed:@"placeholder_query"];
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.dangerRecordTab.mas_centerX);
                        make.centerY.equalTo(self.dangerRecordTab.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            } else {
                self.dangerRecordArray = orderArray;
            }
            [self.dangerRecordTab reloadData];
            
        }];
    }];
    // 上拉加载
    self.dangerRecordTab.mj_footer =
    [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求
        [dangerRecordModel dangerRecordRequestData:self.dangerRecordTab params:params viewController:self success:^(NSMutableArray *orderArray) {
            [self.dangerRecordArray addObjectsFromArray:orderArray];
            [self.dangerRecordTab reloadData];
        }];
    }];
    // 马上进入刷新状态
    [self.dangerRecordTab.mj_header beginRefreshing];
}

#pragma mark - tableviewDegate、DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dangerRecordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"DangerRecordCell";
    DangerRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil][0];
    }
    cell.lookDetailClick = ^(NSString *str) {
        PolicyDetailViewController *detailVC = [[PolicyDetailViewController alloc] init];
        detailVC.whereFrom = 2;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    cell.dangerModel = _dangerRecordArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DangerRecordModel *model = _dangerRecordArray[indexPath.row];
    if (model.status == 3) {
        PolicyDetailViewController *detailVC = [[PolicyDetailViewController alloc] init];
        detailVC.whereFrom = 2;
        detailVC.dangerRecordModel = model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
