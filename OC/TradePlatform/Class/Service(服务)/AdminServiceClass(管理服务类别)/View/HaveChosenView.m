//
//  HaveChosenView.m
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HaveChosenView.h"
// view
#import "AdminChoseCell.h"
#import "AdminChoseHeaderView.h"

@interface HaveChosenView ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

/** collection */
@property (strong, nonatomic) UICollectionView *collectionView;
/** collection样式 */
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
/** 长按抖动手势 */
@property (strong, nonatomic) UILongPressGestureRecognizer *recognize;
/** 移动手势 */
@property (strong, nonatomic) UILongPressGestureRecognizer *longGesture;
/** 轻拍手势 */
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
/** yes:可以编辑,no:不可以编辑 */
@property (assign, nonatomic) BOOL isBegin;

@end

@implementation HaveChosenView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self haveChosenLayoutView];
    }
    return self;
}

#pragma mark - set方法
- (void)setHaveChosenArray:(NSMutableArray *)haveChosenArray {
    _haveChosenArray = haveChosenArray;
    [self.collectionView reloadData];
}



#pragma mark - 按钮点击方法
- (void)delAdminBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(delAdminDelegate:)]) {
        [_delegate delAdminDelegate:button];
    }
}

#pragma mark - view布局
- (void)haveChosenLayoutView {
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
    [self.collectionView registerClass:[AdminChoseCell class] forCellWithReuseIdentifier:@"HaveChosenAdminCell"];
    // 注册头部视图
    [self.collectionView registerClass:[AdminChoseHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HaveChosenAdminClass"];
//    // 长按抖动手势添加
//    [self addRecognize];
    // 长按添加移动手势
    [self addLongGesture];
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
    return self.haveChosenArray.count;
}

// 告诉系统每个Cell如何显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AdminChoseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HaveChosenAdminCell" forIndexPath:indexPath];
    ServiceProviderModel *serviceClass = [self.haveChosenArray objectAtIndex:indexPath.item];
    cell.adminChoseTitleLabel.text = serviceClass.name;
    cell.isAdminSelected = YES;
    /** 删除管理按钮 */
    cell.delAdminBtn.tag = indexPath.item;
    [cell.delAdminBtn addTarget:self action:@selector(delAdminBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    // 判断是否添加抖动动画
    if (self.isBegin) {
        [self starLongPress:cell];
    }else {
        [self endLongPress:cell];
    }
    return cell;
}
//动态设置某组头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 43);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    AdminChoseHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HaveChosenAdminClass" forIndexPath:indexPath];
    view.titleTop = 28;
    view.titleLabel.text = @"已选择服务类别";
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
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(editAdminSort:toIndexPath:)]) {
        [_delegate editAdminSort:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark -  长按抖动手势添加
- (void)addRecognize {
    // 添加长按抖动手势
    if(!self.recognize){
        self.recognize = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    }
    //长按响应时间
    self.recognize.minimumPressDuration = 1;
    [self.collectionView addGestureRecognizer:self.recognize];
}
#pragma mark - 长按抖动手势方法
- (void)longPress:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.isBegin = YES;
            [self.collectionView removeGestureRecognizer:self.recognize];
            // 添加长按编辑
            [self addLongGesture];
            [self.collectionView reloadData];
        }
        default:
            break;
    }
}

#pragma mark -  移动手势的添加
- (void)addLongGesture {
    //此处给其增加长按手势，用此手势触发cell移动效果
    if(!self.longGesture){
        self.longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        self.longGesture.delegate = self;
    }
    self.longGesture.minimumPressDuration = 0;
    [self.collectionView addGestureRecognizer:self.longGesture];
}
#pragma mark - 移动手势的响应方法
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            // 旋转选中cell
            AdminChoseCell *cell = (AdminChoseCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            cell.transform = CGAffineTransformMakeRotation(M_1_PI/3);
        }
            break;
        case UIGestureRecognizerStateChanged:{
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            // 旋转选中cell
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            AdminChoseCell *cell = (AdminChoseCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            cell.transform = CGAffineTransformMakeRotation(M_1_PI/3);
            break;
        }
        case UIGestureRecognizerStateEnded:{
            [self.collectionView endInteractiveMovement];
            // 旋转选中cell
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            AdminChoseCell *cell = (AdminChoseCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            cell.transform = CGAffineTransformIdentity;
//            // 移除抖动动画
//            self.isBegin = NO;
//            // 移除移动手势
//            [self.collectionView removeGestureRecognizer:self.longGesture];
//            // 移除轻拍手势
//            [self.collectionView removeGestureRecognizer:self.tapGesture];
//            // 长按抖动手势添加
//            [self addRecognize];
//            [self.collectionView reloadData];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 开始抖动
- (void)starLongPress:(AdminChoseCell *)cell{
    CABasicAnimation *animation = (CABasicAnimation *)[cell.layer animationForKey:@"rotation"];
    if (animation == nil) {
        [self shakeImage:cell];
    }else {
        [self resume:cell];
    }
}
- (void)shakeImage:(AdminChoseCell *)cell {
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置属性，周期时长
    [animation setDuration:0.15];
    //抖动角度
    animation.fromValue = @(-M_1_PI/4);
    animation.toValue = @(M_1_PI/4);
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [cell.layer addAnimation:animation forKey:@"rotation"];
}
- (void)resume:(AdminChoseCell *)cell {
    cell.layer.speed = 1.0;
}
- (void)endLongPress:(AdminChoseCell *)cell{
    [cell.layer removeAllAnimations];
}
#pragma mark - 手势代理，解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 判断是不是tableview触发的手势
    PDLog(@"%@", touch.view);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}



@end
