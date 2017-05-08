//
//  FilterConditionViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FilterConditionViewController.h"
// view
#import "FilterCounditionCell.h"
#import "DataGroupHeaderView.h"
#import "GroupHeaderView.h"
#import "FiterConditionCell.h"

@interface FilterConditionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/** 确定筛选view */
@property (strong, nonatomic) UIView *confirmFilterView;
/** 重制 */
@property (strong, nonatomic) UIButton *resetBtn;
/** 完成 */
@property (strong, nonatomic) UIButton *finishBtn;

/** collection */
@property (strong, nonatomic) UICollectionView *collectionView;
/** collection样式 */
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
/** 头部view */
@property (strong, nonatomic) DataGroupHeaderView *dataGroupView;


@end

@implementation FilterConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self filterConditionLayoutNAV];
    // 布局视图
    [self filterConditionLayoutView];
    // 网络请求
    [self requestFilterConditionData];
}

#pragma mark - 网络请求
- (void)requestFilterConditionData {
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (self.filterArray.count == 0) {
        [OrderFilterHandle sharedInstance].requestCategorySuccessBlock = ^ () {
            // 保存订单筛选条件数据
            self.filterArray = [OrderFilterHandle sharedInstance].orderFilterArray;
            [self.collectionView reloadData];
        };
    }else {
        [self.collectionView reloadData];
    }
}

// 重制
- (void)resetBtnAction:(UIButton *)button {
    // 遍历取消全部选中
    for (FilterConditionModel *filterConditionModel in self.filterArray) {
        for (FiterItemModel *fiterItemModel in filterConditionModel.value) {
            fiterItemModel.checkMark = NO;
        }
    }
    [self.dataGroupView.startDataBtn setTitle:@"选择开始时间" forState:UIControlStateNormal];
    [self.dataGroupView.endDataBtn setTitle:@"选择结束时间" forState:UIControlStateNormal];
    [self.collectionView reloadData];
    [self.selectedConditionArray removeAllObjects];
}
// 完成
- (void)finishBtnAction:(UIButton *)button {
    if ([self.dataGroupView.startDataBtn.titleLabel.text isEqualToString:@"选择开始时间"] && ![self.dataGroupView.endDataBtn.titleLabel.text isEqualToString:@"选择结束时间"]) { // 选择开始时间
        [MBProgressHUD showError:@"请选择开始时间"];
        return;
    }
    if (![self.dataGroupView.startDataBtn.titleLabel.text isEqualToString:@"选择开始时间"] && [self.dataGroupView.endDataBtn.titleLabel.text isEqualToString:@"选择结束时间"]) { // 选择开始时间
        [MBProgressHUD showError:@"请选择结束时间"];
        return;
    }
    // 初始化
    NSString *filterConditionStr = [[NSString alloc] init];
    if (![self.dataGroupView.startDataBtn.titleLabel.text isEqualToString:@"选择开始时间"] && ![self.dataGroupView.endDataBtn.titleLabel.text isEqualToString:@"选择结束时间"]) { // 选择开始时间
        filterConditionStr = [NSString stringWithFormat:@"%@~%@", self.dataGroupView.startDataBtn.titleLabel.text, self.dataGroupView.endDataBtn.titleLabel.text];
    }
    // 遍历选择的item
    for (FiterItemModel *fiterItemModel in self.selectedConditionArray) {
        if (filterConditionStr.length == 0) {
            filterConditionStr = [NSString stringWithFormat:@"%@", fiterItemModel.name];
        }else {
            filterConditionStr = [NSString stringWithFormat:@"%@/%@", filterConditionStr, fiterItemModel.name];
        }
    }
    if (_makingSelectionBlock) {
        _makingSelectionBlock(self.saveSelPay, self.saveSelOrderClass, self.saveSelServiceClass, self.dataGroupView.startDataBtn.titleLabel.text, self.dataGroupView.endDataBtn.titleLabel.text, filterConditionStr, self.filterArray, self.selectedConditionArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
// nav_left
- (void)filterConditionLeftBarBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 布局nav
- (void)filterConditionLayoutNAV {
    self.navigationItem.title = @"筛选";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_close"] style:UIBarButtonItemStyleDone target:self action:@selector(filterConditionLeftBarBtnAction)];
}
#pragma mark - 懒加载
// 初始化筛选条件数组
- (NSMutableArray *)selectedConditionArray {
    if (!_selectedConditionArray) {
        _selectedConditionArray = [[NSMutableArray alloc] init];
    }
    return _selectedConditionArray;
}

#pragma mark - 布局视图
- (void)filterConditionLayoutView {
    @weakify(self)
    /** 确定筛选view */
    self.confirmFilterView = [[UIView alloc] init];
    self.confirmFilterView.backgroundColor = WhiteColor;
    [self.view addSubview:self.confirmFilterView];
    [self.confirmFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@55);
    }];
    /** 重制 */
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resetBtn setTitle:@"重制" forState:UIControlStateNormal];
    [self.resetBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.resetBtn.titleLabel.font = SixteenTypeface;
    self.resetBtn.layer.masksToBounds = YES;
    self.resetBtn.layer.cornerRadius = 2;
    self.resetBtn.layer.borderWidth = 0.5;
    self.resetBtn.layer.borderColor = ThemeColor.CGColor;
    self.resetBtn.backgroundColor = WhiteColor;
    [self.resetBtn addTarget:self action:@selector(resetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmFilterView addSubview:self.resetBtn];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.confirmFilterView.mas_centerY);
        make.left.equalTo(self.confirmFilterView.mas_left).offset(16);
        make.width.equalTo(self.resetBtn.mas_width);
        make.height.mas_equalTo(@35);
    }];
    /** 完成 */
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.finishBtn.titleLabel.font = SixteenTypeface;
    self.finishBtn.layer.masksToBounds = YES;
    self.finishBtn.layer.cornerRadius = 2;
    self.finishBtn.backgroundColor = ThemeColor;
    [self.finishBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmFilterView addSubview:self.finishBtn];
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.confirmFilterView.mas_centerY);
        make.left.equalTo(self.resetBtn.mas_right).offset(28);
        make.right.equalTo(self.confirmFilterView.mas_right).offset(-16);
        make.width.equalTo(self.resetBtn.mas_width);
        make.height.mas_equalTo(@35);
    }];
    /** collection样式 */
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置item估计值
    self.collectionViewFlowLayout.itemSize = CGSizeMake((ScreenW - 60) / 3, 36);
    // 设置滚动方向
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    /** collection */
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.collectionViewFlowLayout];
    self.collectionView.backgroundColor = CLEARCOLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.confirmFilterView.mas_top).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
    }];
    // 注册Item
    [self.collectionView registerClass:[FiterConditionCell class] forCellWithReuseIdentifier:@"fiterConditionCell"];
    // 注册头部视图
    [self.collectionView registerClass:[DataGroupHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DataGroupHeaderView"];
    [self.collectionView registerClass:[GroupHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupHeaderView"];
}

// 告诉系统一共多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.filterArray.count;
}

// 告诉系统每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    FilterConditionModel *filterConditionModel = [self.filterArray objectAtIndex:section];
    return filterConditionModel.value.count;
}

// 告诉系统每个Cell如何显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FiterConditionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fiterConditionCell" forIndexPath:indexPath];
    FilterConditionModel *filterConditionModel = [self.filterArray objectAtIndex:indexPath.section];
    FiterItemModel *fiterItemModel = [filterConditionModel.value objectAtIndex:indexPath.row];
    cell.titleLabel.text = fiterItemModel.name;
    cell.isSelected = fiterItemModel.checkMark;
    return cell;
}
//动态设置某组头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenW, 129);
    }else {
        return CGSizeMake(ScreenW, 55);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    // 获取区头展示组名
    FilterConditionModel *filterConditionModel = [self.filterArray objectAtIndex:indexPath.section];
    //先通过kind类型判断是头还是尾巴，然后在判断是哪一组，如果都是一样的头尾，那么只要第一次判断就可以了
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            /** 头部view */
            self.dataGroupView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DataGroupHeaderView" forIndexPath:indexPath];
            self.dataGroupView.payWayLabel.text = filterConditionModel.title;
            if (self.startDataStr.length != 0 && self.endDataStr.length != 0) {
                [self.dataGroupView.startDataBtn setTitle:self.startDataStr forState:UIControlStateNormal];
                [self.dataGroupView.endDataBtn setTitle:self.endDataStr forState:UIControlStateNormal];
                self.startDataStr = nil;
                self.endDataStr = nil;
            }
            return self.dataGroupView;
        }
        else {
            GroupHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupHeaderView" forIndexPath:indexPath];
            view.titleLabel.text = filterConditionModel.title;
            return view;
        }
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterConditionModel *filterConditionModel = [self.filterArray objectAtIndex:indexPath.section];
    FiterItemModel *fiterItemModel = [filterConditionModel.value objectAtIndex:indexPath.row];
    // 判断选中的是哪个分区
    if ([filterConditionModel.name isEqualToString:@"pay_method"]) {
        // 判断当前选中是否是取消选中
        if (self.saveSelPay.ID == fiterItemModel.ID) {
            // 删除之前选择的支付方式
            [self.selectedConditionArray removeObject:self.saveSelPay];
            // 取消展示选中
            self.saveSelPay.checkMark = NO;
            // 刷新页面
            [self.collectionView reloadData];
            // 删除之前选择的支付方式
            self.saveSelPay = nil;
            return;
        }
        // 判断是否选择过支付方式
        if (self.saveSelPay && self.saveSelPay.name.length != 0) {
            // 删除之前选择的支付方式
            [self.selectedConditionArray removeObject:self.saveSelPay];
            // 取消展示选中
            self.saveSelPay.checkMark = NO;
        }
        // 保存当前选中的支付方式
        self.saveSelPay = fiterItemModel;
        // 展示选中
        self.saveSelPay.checkMark = !self.saveSelPay.checkMark;
        // 添加选择的支付方式
        [self.selectedConditionArray addObject:self.saveSelPay];
        // 刷新页面
        [self.collectionView reloadData];
    }else if ([filterConditionModel.name isEqualToString:@"order_category_id"]) {
        // 判断当前选中是否是取消选中
        if (self.saveSelOrderClass.ID == fiterItemModel.ID) {
            // 删除之前选择的订单类型
            [self.selectedConditionArray removeObject:self.saveSelOrderClass];
            // 取消展示选中
            self.saveSelOrderClass.checkMark = NO;
            // 刷新页面
            [self.collectionView reloadData];
            // 删除之前选择的订单类型
            self.saveSelOrderClass = nil;
            return;
        }
        // 判断是否选择过订单类型
        if (self.saveSelOrderClass && self.saveSelOrderClass.name.length != 0) {
            // 删除之前选择的订单类型
            [self.selectedConditionArray removeObject:self.saveSelOrderClass];
            // 取消展示选中
            self.saveSelOrderClass.checkMark = NO;
        }
        // 保存当前选中的订单类型
        self.saveSelOrderClass = fiterItemModel;
        // 展示选中
        self.saveSelOrderClass.checkMark = !self.saveSelOrderClass.checkMark;
        // 添加选择的订单类型
        [self.selectedConditionArray addObject:self.saveSelOrderClass];
        // 刷新页面
        [self.collectionView reloadData];
    }else if ([filterConditionModel.name isEqualToString:@"goods_category_id"]) {
        // 判断当前选中是否是取消选中
        if (self.saveSelServiceClass.ID == fiterItemModel.ID) {
            // 删除之前选择的服务类型
            [self.selectedConditionArray removeObject:self.saveSelServiceClass];
            // 取消展示选中
            self.saveSelServiceClass.checkMark = NO;
            // 刷新页面
            [self.collectionView reloadData];
            // 删除之前选择的服务类型
            self.saveSelServiceClass = nil;
            return;
        }
        // 判断是否选择过服务类型
        if (self.saveSelServiceClass && self.saveSelServiceClass.name.length != 0) {
            // 删除之前选择的服务类型
            [self.selectedConditionArray removeObject:self.saveSelServiceClass];
            // 取消展示选中
            self.saveSelServiceClass.checkMark = NO;
        }
        // 保存当前选中的服务单类型
        self.saveSelServiceClass = fiterItemModel;
        // 展示选中
        self.saveSelServiceClass.checkMark = !self.saveSelServiceClass.checkMark;
        // 添加选择的服务类型
        [self.selectedConditionArray addObject:self.saveSelServiceClass];
        // 刷新页面
        [self.collectionView reloadData];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
