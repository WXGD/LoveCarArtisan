//
//  UsedCarBrandViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarBrandViewController.h"
// view
#import "UsedCarBrandCell.h"
#import "UsedCarSeriesView.h"
// 下级控制器
#import "UsedCarKindsViewController.h"

@interface UsedCarBrandViewController ()<UITableViewDelegate, UITableViewDataSource, UsedCarSeriesDelegate>

/** 二手车品牌table */
@property (strong, nonatomic) UITableView *usedCarBrandTable;
/** 二手车车系view */
@property (strong, nonatomic) UsedCarSeriesView *usedCarSeriesView;
/** 二手车品牌数据 */
@property (strong, nonatomic) NSMutableDictionary *usedCarBrandDic;
/** 二手车品牌排序 */
@property (strong, nonatomic) NSMutableArray *usedCarBrandKeys;

@end

@implementation UsedCarBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self usedCarBrandLayoutNAV];
    // 布局视图
    [self usedCarBrandLayoutView];
    // 请求二手车品牌数据
    [self requestusedCarBrandData];
    
    
}
#pragma mark - 网络请求
// 请求二手车品牌数据
- (void)requestusedCarBrandData {
    /** 二手车品牌分组数据 */
    self.usedCarBrandKeys = [UsedCarBrandHandle sharedInstance].usedCarBrandDicKeys;
    /** 全部二手车品牌数据 */
    self.usedCarBrandDic = [UsedCarBrandHandle sharedInstance].usedCarBrandDic;
    // 判断是否有二手车品牌数据，如果没有等请求成功后，在次刷新界面
    if (self.usedCarBrandKeys.count == 0) {
        [UsedCarBrandHandle sharedInstance].requestUsedCarBrandBlock = ^ () {
            /** 二手车品牌分组数据 */
            self.usedCarBrandKeys = [UsedCarBrandHandle sharedInstance].usedCarBrandDicKeys;
            /** 全部二手车品牌数据 */
            self.usedCarBrandDic = [UsedCarBrandHandle sharedInstance].usedCarBrandDic;
            [self.usedCarBrandTable reloadData];
            // 如果数据为空
            if (self.usedCarBrandKeys.count == 0) {
                [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    noLabel.text = @"聚合数据使用过期，正在抓紧修复！";
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.usedCarBrandTable.mas_centerX);
                        make.centerY.equalTo(self.usedCarBrandTable.mas_centerY);
                    }];
                }];
            }
        };
    }
    [self.usedCarBrandTable reloadData];
}

#pragma mark - 按钮点击事件
// 车系view轻扫手势，用来回收车系view
- (void)carSystemViewSwipeGestureRecognizer {
    [UIView animateWithDuration:0.5 animations:^{
        self.usedCarSeriesView.frame = CGRectMake(ScreenW, 0, ScreenW - 59, ScreenH);
    }];
}
// 车系选择代理方法
- (void)UsedCarSeriesSelectCarSeriesModel:(UsedCarBrandModel *)carSeriesModel carBrandModel:(UsedCarBrandModel *)carBrandModel {
    UsedCarKindsViewController *usedCarKindsVC = [[UsedCarKindsViewController alloc] init];
    usedCarKindsVC.usedCarBrandModel = carBrandModel;
    usedCarKindsVC.usedCarSerierModel = carSeriesModel;
    usedCarKindsVC.UsedCarKindsChoiceBlock = ^(UsedCarBrandModel *usedCarBrandModel, UsedCarBrandModel *usedCarSerierModel, UsedCarBrandModel *usedCarKindsModel) {
        if (_usedCarBrandChoiceBlock) {
            _usedCarBrandChoiceBlock(usedCarBrandModel, usedCarSerierModel, usedCarKindsModel);
        }
    };
    [self.navigationController pushViewController:usedCarKindsVC animated:YES];
    self.usedCarSeriesView.frame = CGRectMake(ScreenW, 0, ScreenW - 59, ScreenH);
}
#pragma mark - 布局nav
- (void)usedCarBrandLayoutNAV {
    self.navigationItem.title = @"品牌选择";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(usedCarBrandRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(usedCarBrandRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)usedCarBrandLayoutView {
    /** 二手车品牌table */
    self.usedCarBrandTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.usedCarBrandTable.delegate = self;
    self.usedCarBrandTable.dataSource = self;
    self.usedCarBrandTable.backgroundColor = CLEARCOLOR;
    self.usedCarBrandTable.rowHeight = 48;
    self.usedCarBrandTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.usedCarBrandTable];
    @weakify(self)
    [self.usedCarBrandTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    /** 二手车车系view */
    self.usedCarSeriesView = [[UsedCarSeriesView alloc] initWithFrame:CGRectMake(ScreenW, 0, ScreenW - 59, ScreenH)];
    self.usedCarSeriesView.backgroundColor = WhiteColor;
    self.usedCarSeriesView.delegate = self;
    [self.view addSubview:self.usedCarSeriesView];
    // 给车系view添加轻扫收拾
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(carSystemViewSwipeGestureRecognizer)];
    [self.usedCarSeriesView addGestureRecognizer:swipe];
}

#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.usedCarBrandKeys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *usedCarBrandArray = [self.usedCarBrandDic objectForKey:[self.usedCarBrandKeys objectAtIndex:section]];
    return usedCarBrandArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"carBrandCell";
    UsedCarBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UsedCarBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *usedCarBrandArray = [self.usedCarBrandDic objectForKey:[self.usedCarBrandKeys objectAtIndex:indexPath.section]];
    UsedCarBrandModel *usedCarBrandModel = [usedCarBrandArray objectAtIndex:indexPath.row];
    cell.usedCarBrandModel = usedCarBrandModel;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *cellHeaderView = [[UIView alloc] init];
    cellHeaderView.backgroundColor = VCBackground;
    UILabel *cellTitleLabel = [[UILabel alloc] init];
    cellTitleLabel.text = [self.usedCarBrandKeys objectAtIndex:section];
    cellTitleLabel.textColor = GrayH2;
    cellTitleLabel.font = ThirteenTypeface;
    [cellHeaderView addSubview:cellTitleLabel];
    [cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cellHeaderView.mas_centerY);
        make.left.equalTo(cellHeaderView.mas_left).offset(16);
    }];
    return cellHeaderView;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.usedCarBrandKeys;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *usedCarBrandArray = [self.usedCarBrandDic objectForKey:[self.usedCarBrandKeys objectAtIndex:indexPath.section]];
    UsedCarBrandModel *usedCarBrandModel = [usedCarBrandArray objectAtIndex:indexPath.row];
    self.usedCarSeriesView.usedCarBrandModel = usedCarBrandModel;
    @weakify(self)
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self)
        self.usedCarSeriesView.frame = CGRectMake(59, 0, ScreenW - 59, ScreenH);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
