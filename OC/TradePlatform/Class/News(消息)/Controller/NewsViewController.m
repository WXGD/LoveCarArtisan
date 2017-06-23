//
//  NewsViewController.m
//  TradePlatform
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsViewController.h"
// view
#import "NewsTableCell.h"
// 模型
#import "NewsModel.h"

@interface NewsViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 消息 */
@property (strong, nonatomic) UITableView *newsTableView;
/** 消息数据 */
@property (strong, nonatomic) NSMutableArray *newsModelArray;

@end

@implementation NewsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 马上进入刷新状态
    [self.newsTableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self newsLayoutNAV];
    // 布局视图
    [self newsLayoutView];
    // 网络请求
    [self newsRepuestData];
}
#pragma mark - 网络请求
- (void)newsRepuestData {
    // 初始化请求模型
    NewsModel *newsNetwork = [[NewsModel alloc] init];
    // 请求参数
    /*/index.php?c=provider_notify&a=list&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id  */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 服务id
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    // 下拉刷新
    @weakify(self)
    self.newsTableView.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        [newsNetwork newsRefreshRequestData:self.newsTableView params:params success:^(NSMutableArray *newsArray) {
            if (newsArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    noLabel.text = @"暂未收到消息";
                    noImage.image = [UIImage imageNamed:@"placeholder_news"];
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.newsTableView.mas_centerX);
                        make.centerY.equalTo(self.newsTableView.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                self.newsModelArray = newsArray;
                [self.newsTableView reloadData];
            }
        }];
    }];
    // 上拉加载
    self.newsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [newsNetwork newsLoadRequestData:self.newsTableView params:params success:^(NSMutableArray *newsArray) {
            [self.newsModelArray addObjectsFromArray:newsArray];
            [self.newsTableView reloadData];
        }];
    }];
    // 马上进入刷新状态
    [self.newsTableView.mj_header beginRefreshing];
}
#pragma mark - 按钮点击方法
- (void)newsBtnAvtion:(UIButton *)button {
    
}

#pragma mark - 界面赋值
- (void)newsAssignment {
    
}
#pragma mark - 布局nav
- (void)newsLayoutNAV {
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(newsLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newsRightBarBtnAction)];
}
#pragma mark - 布局视图
- (void)newsLayoutView {
    /** 消息 */
    self.newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 46) style:UITableViewStylePlain];
    self.newsTableView.delegate = self;
    self.newsTableView.dataSource = self;
    self.newsTableView.backgroundColor = RGB(245, 245, 245);
    self.newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.newsTableView];
}
#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"newsTableCell";
    NewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NewsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.newsModel = [self.newsModelArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 得到当前的模型
    NewsModel *newsModel = [self.newsModelArray objectAtIndex:indexPath.row];
    // 计算实际需要的高度
    CGFloat height = [CustomString heightForString:newsModel.content textFont:TwelveTypeface textWidth:ScreenW - 64];
    // 判断是否需要购买标志
//    if (newsModel.status == 0) {
//        return 35 + 57 + height + 10 + 14 + 24;
//    }else {
        return 35 + 57 + height + 24;
//    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
