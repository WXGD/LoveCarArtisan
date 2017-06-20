//
//  NotChosenView.m
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NotChosenView.h"
// view
#import "AdminChoseCell.h"
#import "AdminChoseHeaderView.h"
// 单利
#import "ServiceCategoryHandle.h"

@interface NotChosenView ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** collection */
@property (strong, nonatomic) UICollectionView *collectionView;
/** collection样式 */
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;

@end

@implementation NotChosenView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self notChosenLayoutView];
    }
    return self;
}


#pragma mark - set方法
- (void)setNotChosenArray:(NSMutableArray *)notChosenArray {
    _notChosenArray = notChosenArray;
    [self.collectionView reloadData];
}



#pragma mark - view布局
- (void)notChosenLayoutView {
    /** collection样式 */
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置item估计值
    self.collectionViewFlowLayout.itemSize = CGSizeMake((ScreenW - 18) / 3, 56);
    // 设置滚动方向
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    /** collection */
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.collectionViewFlowLayout];
    self.collectionView.backgroundColor = CLEARCOLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    
    // 注册Item
    [self.collectionView registerClass:[AdminChoseCell class] forCellWithReuseIdentifier:@"NotChosenAdminCell"];
    // 注册头部视图
    [self.collectionView registerClass:[AdminChoseHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NotChosenAdminClass"];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** collection */
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(9);
        make.right.equalTo(self.mas_right).offset(-9);
    }];
}



#pragma mark - collectionView代理方法
// 告诉系统一共多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 告诉系统每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.notChosenArray.count;
}

// 告诉系统每个Cell如何显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AdminChoseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NotChosenAdminCell" forIndexPath:indexPath];
    ServiceProviderModel *serviceClass = [self.notChosenArray objectAtIndex:indexPath.item];
    cell.adminChoseTitleLabel.text = serviceClass.name;
    return cell;
}
//动态设置某组头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 35);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    AdminChoseHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NotChosenAdminClass" forIndexPath:indexPath];
    view.titleTop = 20;
    view.titleLabel.text = @"未选择服务类别";
    return view;
    
}
// 这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
// 两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(addAdminDelegate:)]) {
        [_delegate addAdminDelegate:indexPath.item];
    }
}

@end
