//
//  InquiryRecordViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "InquiryRecordViewController.h"
#import "InquiryRecordCell.h"
#import "PolicyAddressViewController.h"
#import "InquiryRecordModel.h"
//下级页面
#import "QuotationViewController.h"


@interface InquiryRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong ,nonatomic) UITableView *inquiryRecordTab;

/** 出险记录数据 */
@property(strong, nonatomic) NSMutableArray *inquiryRecordArray;
@end

@implementation InquiryRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self inquiryRecordLayoutNAV];
    // 网络请求
    [self inquiryRecordRequestData];
}
#pragma mark - 布局nav
- (void)inquiryRecordLayoutNAV {
    self.navigationItem.title = @"询价记录";
    self.inquiryRecordTab = [[UITableView alloc] init];
    self.inquiryRecordTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.inquiryRecordTab.delegate = self;
    self.inquiryRecordTab.dataSource = self;
    self.inquiryRecordTab.backgroundColor = CLEARCOLOR;
    self.inquiryRecordTab.rowHeight = UITableViewAutomaticDimension;
    self.inquiryRecordTab.estimatedRowHeight = 60;
    [self.view addSubview:self.inquiryRecordTab];
    @weakify(self)
    /** 出险记录 */
    [self.inquiryRecordTab mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
#pragma mark - 网络请求
- (void)inquiryRecordRequestData {
    InquiryRecordModel *inquiryRecordModel = [[InquiryRecordModel alloc] init];
    // 下拉刷新
    @weakify(self) self.inquiryRecordTab.mj_header =
    [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求
        
        [inquiryRecordModel inquiryRecordRefreshRequestData:self.inquiryRecordTab params:params viewController:self success:^(NSMutableArray *orderArray) {
             // 移除无数据视图
             [self removeNoDataView];
             // 移除所有数据
             [self.inquiryRecordArray removeAllObjects];
             // 判断是否有数据
             if (orderArray.count == 0) {
                 [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                     noLabel.text = @"暂无询价";
                     noImage.image = [UIImage imageNamed:@"placeholder_query"];
                     [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                         make.centerX.equalTo(self.inquiryRecordTab.mas_centerX);
                         make.centerY.equalTo(self.inquiryRecordTab.mas_centerY);
                         make.top.equalTo(noImage.mas_top);
                         make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                         make.width.mas_equalTo(ScreenW);
                     }];
                 }];
             } else {
                 self.inquiryRecordArray = orderArray;
             }
             [self.inquiryRecordTab reloadData];
             
         }];
    }];
    // 上拉加载
    self.inquiryRecordTab.mj_footer =
    [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        // 网络请求
        [inquiryRecordModel inquiryRecordRequestData:self.inquiryRecordTab params:params viewController:self success:^(NSMutableArray *orderArray) {
             [self.inquiryRecordArray addObjectsFromArray:orderArray];
             [self.inquiryRecordTab reloadData];
         }];
    }];
    // 马上进入刷新状态
    [self.inquiryRecordTab.mj_header beginRefreshing];
}
#pragma mark - tableviewDegate、DataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _inquiryRecordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"InquiryRecordCell";
    InquiryRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID
                                             owner:nil
                                           options:nil][0];
    }
    cell.lookDetailClick = ^(InquiryRecordModel *inquiryModel) {
        //报价页面
        QuotationViewController *quotationVC = [[QuotationViewController alloc] init];
        quotationVC.inquiryModel = inquiryModel;
        [self.navigationController pushViewController:quotationVC animated:YES];
    };
    cell.inquiryModel = _inquiryRecordArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InquiryRecordModel *inquiryRecordModel = _inquiryRecordArray[indexPath.row];
    if (inquiryRecordModel.status == 2) {
        QuotationViewController *quotationVC = [[QuotationViewController alloc] init];
        quotationVC.inquiryModel = inquiryRecordModel;
        [self.navigationController pushViewController:quotationVC animated:YES];
    }

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
