//
//  ServiceModuleView.m
//  TradePlatform
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServiceModuleView.h"

@interface ServiceModuleView ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** collection样式 */
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
/** collection */
@property (strong, nonatomic) UICollectionView *collectionView;
/** pageControl */
@property (nonatomic, strong) SMPageControl *pageControl;

@end

@implementation ServiceModuleView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self serviceModuleLayoutView];
    }
    return self;
}

#pragma mark - 获取服务模块数据set方法
- (void)setModuleArray:(NSMutableArray *)moduleArray {
    _moduleArray = moduleArray;
    self.pageControl.numberOfPages = moduleArray.count;
    [self.collectionView reloadData];
}


#pragma mark - 服务模块点击方法
- (void)moduleBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(serviceModuleBtnAction:)]) {
        [_delegate serviceModuleBtnAction:button];
    }
}


#pragma mark - collection代理方法
// 告诉系统一共多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.moduleArray.count;
}
// 告诉系统每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *moduleItem = [self.moduleArray objectAtIndex:section];
    return moduleItem.count;
}
// 告诉系统每个Cell如何显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"moduleCell" forIndexPath:indexPath];
    NSArray *moduleItem = [self.moduleArray objectAtIndex:indexPath.section];
    NSArray *itemArray = [moduleItem objectAtIndex:indexPath.row];
    /** cell位置 */
    cell.indexPath = indexPath;
    /** 按钮数据 */
    cell.btnArray = itemArray;
    /** 按钮1 */
    [cell.btnOne.moduleBtn addTarget:self action:@selector(moduleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 按钮2 */
    [cell.btnTwo.moduleBtn addTarget:self action:@selector(moduleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 按钮3 */
    [cell.btnThree.moduleBtn addTarget:self action:@selector(moduleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
// 定义每个Cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenW - 32, 106);;
}
// 这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
// 两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
// 动态设置某组头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(16, 0);
}


//动态设置某组尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(16, 0);
}


#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.width + 0.5;
    self.pageControl.currentPage = page;
}


#pragma mark - view布局
- (void)serviceModuleLayoutView {
    /** collection样式 */
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置滚动方向
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    /** collection */
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.collectionViewFlowLayout];
    self.collectionView.backgroundColor = CLEARCOLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    [self addSubview:self.collectionView];
    // 注册Item
    [self.collectionView registerClass:[ModuleCell class] forCellWithReuseIdentifier:@"moduleCell"];
    // 添加pageControl
    self.pageControl = [[SMPageControl alloc] init];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.indicatorMargin = 10.0f;
    self.pageControl.indicatorDiameter = 10.0f;
    self.pageControl.pageIndicatorImage = [UIImage imageNamed:@"home_page_service_unchecked"];
    self.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"home_page_service_checked"];
    [self addSubview:_pageControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** collection */
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** pageControl */
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@100);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@232);
    }];
}

@end
