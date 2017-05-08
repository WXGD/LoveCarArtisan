//
//  CityListViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CityListViewController.h"
// view
#import "SearchView.h"

@interface CityListViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate>

/** 合作城市table */
@property (strong, nonatomic) UITableView *cityListTable;
/** 合作城市数据 */
@property (strong, nonatomic) NSMutableDictionary *cityDic;
/** 合作城市排序 */
@property (strong, nonatomic) NSMutableArray *cityDicKeys;
/** 搜索框view */
@property (strong, nonatomic) SearchView *searchTFView;

@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self cityListLayoutNAV];
    // 布局视图
    [self cityListLayoutView];
    // 请求城市数据
    [self requestCityListData];
}
#pragma mark - 网络请求
// 请求城市数据
- (void)requestCityListData {
    CityModel *cityModel = [[CityModel alloc] init];
    [cityModel requestWholeCityDataBlock:^(NSMutableDictionary *cityDic, NSMutableArray *dicKeys) {
        /** 合作城市数据 */
        self.cityDic = cityDic;
        /** 合作城市排序 */
        self.cityDicKeys = dicKeys;
        // 刷新table
        [self.cityListTable reloadData];
    }];
}

#pragma mark - textField输入代理
// 获取输入字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断输入框内容为空，不刷新
    NSString *tfText = [self.searchTFView.searchTF.text stringByAppendingString:string];
    // 只保留中文
    NSString *chineseText = [CustomString getAStringOfChineseWord:tfText];
    // 只保存英文字母
    NSString *englishText = [CustomString getNumber:tfText];
    // 模糊查询
    CityModel *cityModel = [[CityModel alloc] init];
    [cityModel fuzzyQueryCityDataQueryText:chineseText englishText:englishText success:^(NSMutableDictionary *cityDic, NSMutableArray *dicKeys) {
        /** 合作城市数据 */
        self.cityDic = cityDic;
        /** 合作城市排序 */
        self.cityDicKeys = dicKeys;
        // 刷新table
        [self.cityListTable reloadData];
    }];
    return YES;
}
// 清空输入内容
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    CityModel *cityModel = [[CityModel alloc] init];
    [cityModel  requestWholeCityDataBlock:^(NSMutableDictionary *cityDic, NSMutableArray *dicKeys) {
        /** 合作城市数据 */
        self.cityDic = cityDic;
        /** 合作城市排序 */
        self.cityDicKeys = dicKeys;
        // 刷新table
        [self.cityListTable reloadData];
    }];
    return YES;
}


#pragma mark - scrollview输入代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchTFView endEditing:YES];
}

#pragma mark - 布局nav
- (void)cityListLayoutNAV {
    self.navigationItem.title = @"城市选择";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(cityListRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(cityListRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)cityListLayoutView {
    /** 合作城市table */
    self.cityListTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.cityListTable.delegate = self;
    self.cityListTable.dataSource = self;
    self.cityListTable.backgroundColor = CLEARCOLOR;
    self.cityListTable.separatorColor = DividingLine;
    self.cityListTable.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    self.cityListTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.cityListTable];
    // tableview高度随数据高度变化而变化
    [self.cityListTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    @weakify(self)
    [self.cityListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    UITapGestureRecognizer *cityListTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityListTableTapAction)];
    cityListTap.delegate = self;
    [self.cityListTable addGestureRecognizer:cityListTap];
    // table头部view
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    // 搜索框view
    self.searchTFView = [[SearchView alloc] init];
    self.searchTFView.searchTF.delegate = self;
    self.searchTFView.isSearch = YES;
    self.searchTFView.isViewBtn = YES;
    self.searchTFView.searchType = OrdinaryViewLayout;
    self.searchTFView.searchTF.textColor = Black;
    self.searchTFView.searchTF.placeholder = @"搜索";
    [self.searchTFView.searchTF setValue:NotClick  forKeyPath:@"_placeholderLabel.textColor"];
    self.searchTFView.searchTF.tintColor = ThemeColor;
    self.searchTFView.searchView.backgroundColor = WhiteColor;
    self.searchTFView.searchMagnifierImage.image = [UIImage imageNamed:@"nav_search_gray"];
    [tableHeaderView addSubview:self.searchTFView];
    [self.searchTFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableHeaderView.mas_top).offset(10);
        make.left.equalTo(tableHeaderView.mas_left).offset(16);
        make.right.equalTo(tableHeaderView.mas_right).offset(-16);
        make.height.mas_equalTo(@30);
    }];
    self.cityListTable.tableHeaderView = tableHeaderView;
}

#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityDicKeys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *cityArray = [self.cityDic objectForKey:[self.cityDicKeys objectAtIndex:section]];
    return cityArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *cityArray = [self.cityDic objectForKey:[self.cityDicKeys objectAtIndex:indexPath.section]];
    CityModel *city = [cityArray objectAtIndex:indexPath.row];
    cell.textLabel.text = city.cityName;
    cell.textLabel.textColor = Black;
    cell.textLabel.font = FifteenTypeface;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *cellHeaderView = [[UIView alloc] init];
    cellHeaderView.backgroundColor = VCBackground;
    UILabel *cellTitleLabel = [[UILabel alloc] init];
    cellTitleLabel.text = [self.cityDicKeys objectAtIndex:section];
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
    return self.cityDicKeys;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *cityArray = [self.cityDic objectForKey:[self.cityDicKeys objectAtIndex:indexPath.section]];
    CityModel *city = [cityArray objectAtIndex:indexPath.row];
    if (_cityChoiceBlock) {
        _cityChoiceBlock(city);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 回收键盘
- (void)cityListTableTapAction {
    [self.cityListTable endEditing:YES];
}
#pragma mark - 手势代理，解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 判断是不是tableview触发的手势
    PDLog(@"%@", touch.view);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
