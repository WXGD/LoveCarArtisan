//
//  UsedCarKindsViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarKindsViewController.h"
// view

@interface UsedCarKindsViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 车型table */
@property (strong, nonatomic) UITableView *usedCarKindsTable;
/** 车型数据 */
@property (strong, nonatomic) NSMutableArray *usedCarKindsArray;
/** table头部view */
@property (strong, nonatomic) UIView *tableHeaderView;
/** 品牌名 */
@property (strong, nonatomic) UILabel *brandName;

@end

@implementation UsedCarKindsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self usedCarKindsLayoutNAV];
    // 布局视图
    [self usedCarKindsLayoutView];
    // 请求车型数据
    [self requestCarKindsData];
}
#pragma mark - 网络请求
/** 请求车型数据 */
- (void)requestCarKindsData {
    /* /index.php?c=usedcar_brand_series&a=list&v=1
     brand_id 	string 	否 	获取车系、车型必传
     series_id 	string 	否 	获取车型必传    */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"brand_id"] = [NSString stringWithFormat:@"%ld", self.usedCarBrandModel.brand_series_id]; // 车品牌ID
    params[@"series_id"] = [NSString stringWithFormat:@"%ld", self.usedCarSerierModel.brand_series_id]; // 车系ID
    [UsedCarKindsModel requestCarKindsData:params success:^(NSMutableArray *carKindsArray) {
        self.usedCarKindsArray = carKindsArray;
        [self.usedCarKindsTable reloadData];
    }];
}

#pragma mark - 布局nav
- (void)usedCarKindsLayoutNAV {
    self.navigationItem.title = @"车型选择";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(usedCarKindsRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(usedCarKindsRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)usedCarKindsLayoutView {
    /** 车型table */
    self.usedCarKindsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.usedCarKindsTable.delegate = self;
    self.usedCarKindsTable.dataSource = self;
    self.usedCarKindsTable.backgroundColor = CLEARCOLOR;
    self.usedCarKindsTable.separatorColor = DividingLine;
    self.usedCarKindsTable.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);        // 设置端距，这里表示separator离左边和右边均80像素
    self.usedCarKindsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.usedCarKindsTable];
    // tableview高度随数据高度变化而变化
    [self.usedCarKindsTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    @weakify(self)
    [self.usedCarKindsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    /** table头部view */
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 48)];
    self.tableHeaderView.backgroundColor = WhiteColor;
    [self.usedCarKindsTable setTableHeaderView:self.tableHeaderView];
    /** 品牌名 */
    self.brandName = [[UILabel alloc] init];
    self.brandName.textColor = ThemeColor;
    self.brandName.font = FifteenTypeface;
    self.brandName.text = self.usedCarBrandModel.name;
    [self.tableHeaderView addSubview:self.brandName];
    /** 品牌名 */
    [self.brandName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.tableHeaderView.mas_centerY);
        make.left.equalTo(self.tableHeaderView.mas_left).offset(16);
    }];
}

#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.usedCarKindsArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    UsedCarKindsModel *kindsModel = [self.usedCarKindsArray objectAtIndex:section];
    return kindsModel.car_models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"carKindsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UsedCarKindsModel *kindsModel = [self.usedCarKindsArray objectAtIndex:indexPath.section];
    UsedCarBrandModel *carKindsModel = [kindsModel.car_models objectAtIndex:indexPath.row];
    cell.textLabel.text = carKindsModel.name;
    cell.textLabel.textColor = Black;
    cell.textLabel.font = FifteenTypeface;
    cell.textLabel.numberOfLines = 0;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *cellHeaderView = [[UIView alloc] init];
    cellHeaderView.backgroundColor = VCBackground;
    UILabel *cellTitleLabel = [[UILabel alloc] init];
    UsedCarKindsModel *kindsModel = [self.usedCarKindsArray objectAtIndex:section];
    cellTitleLabel.text = kindsModel.sale_year;
    cellTitleLabel.textColor = GrayH2;
    cellTitleLabel.font = ThirteenTypeface;
    [cellHeaderView addSubview:cellTitleLabel];
    [cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cellHeaderView.mas_centerY);
        make.left.equalTo(cellHeaderView.mas_left).offset(16);
    }];
    return cellHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UsedCarKindsModel *kindsModel = [self.usedCarKindsArray objectAtIndex:indexPath.section];
    UsedCarBrandModel *carKindsModel = [kindsModel.car_models objectAtIndex:indexPath.row];
    return 30 + [CustomString heightForString:carKindsModel.name textFont:FifteenTypeface textWidth:ScreenW - 32];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UsedCarKindsModel *kindsModel = [self.usedCarKindsArray objectAtIndex:indexPath.section];
    UsedCarBrandModel *carKindsModel = [kindsModel.car_models objectAtIndex:indexPath.row];
    if (_UsedCarKindsChoiceBlock) {
        _UsedCarKindsChoiceBlock(self.usedCarBrandModel, self.usedCarSerierModel, carKindsModel);
    }
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
