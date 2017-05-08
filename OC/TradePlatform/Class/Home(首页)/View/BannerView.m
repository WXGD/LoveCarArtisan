//
//  BannerView.m
//  TradePlatform
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BannerView.h"
// 轮播图
#import "BHInfiniteScrollView/BHInfiniteScrollView.h"
#import "SMPageControl.h"
#import "SMPageControl.h"
// 数据模型
#import "BannerModel.h"
// 下级控制器
#import "BannerWebViewController.h"

@interface BannerView ()<BHInfiniteScrollViewDelegate>

/** 轮播图数据 */
@property (strong, nonatomic) NSArray *bannerModelArray;
/** 标题标志 */
@property (strong, nonatomic) UIView *titleSignView;
/** 标题 */
@property (strong, nonatomic) UILabel *titleLabel;
/** 轮播图 */
@property (strong, nonatomic) UIView *bannerView;
/** 轮播图占位图片 */
@property (strong, nonatomic) UIImageView *bannerPlaceholderImage;

@end

@implementation BannerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self bannerViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)bannerViewLayoutView {
    /** 标题标志 */
    self.titleSignView = [[UIView alloc] init];
    self.titleSignView.backgroundColor = ThemeColor;
    [self addSubview:self.titleSignView];
    /** 标题 */
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"工匠资讯";
    self.titleLabel.font = FourteenTypeface;
    self.titleLabel.textColor = Black;
    [self addSubview:self.titleLabel];
    /** 轮播图 */
    self.bannerView = [[UIView alloc] init];
    [self addSubview:self.bannerView];
    /** 轮播图占位图片 */
    self.bannerPlaceholderImage = [[UIImageView alloc] init];
    self.bannerPlaceholderImage.image = [UIImage imageNamed:@"placeholder_banner"];
    [self.bannerView addSubview:self.bannerPlaceholderImage];
}
#pragma mark - 布局轮播图视图
- (void)bannerLayoutViewModelArray:(NSArray *)modelArray {
    // 保存所有模型数据
    self.bannerModelArray = modelArray;
    // 初始化图片数组
    NSMutableArray *imageArray = [NSMutableArray new];
    // 将所有图片链接，单独保存
    for (BannerModel *bancerModel in modelArray) {
        [imageArray addObject:bancerModel.image_url];
    }
    // 轮播图
    // 判断是否有网络轮播图
    if (imageArray.count != 0) {
        // 隐藏占位图
        [self.bannerPlaceholderImage setHidden:YES];
        // 轮播图片
        BHInfiniteScrollView *picView = [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(0, 0, self.bannerView.width, self.bannerView.height) Delegate:self ImagesArray:imageArray PlageHolderImage:[UIImage imageNamed:@"placeholder_banner"]];
        picView.scrollTimeInterval = 5;
        picView.titleView.hidden = YES;
        picView.pageControlAlignmentOffset = CGSizeMake(0, 5);
        picView.selectedDotImage = [UIImage imageNamed:@"home_banner_checked"];
        picView.dotImage = [UIImage imageNamed:@"home_banner_unchecked"];
        [self.bannerView addSubview:picView];
    }
}

/** 轮播图点击方法 */
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index {
    // 首先判断有banner图片
    if (self.bannerModelArray.count != 0) {
        BannerModel *bancer = self.bannerModelArray[index];
        if (bancer.redirect_data && bancer.redirect_data.length > 7) {
            BannerWebViewController *bannerWebVC = [[BannerWebViewController alloc] init];
            bannerWebVC.webUrl = bancer.redirect_data;
            [[self viewController].navigationController pushViewController:bannerWebVC animated:YES];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 标题标志 */
    [self.titleSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(16);
        make.size.mas_equalTo(CGSizeMake(2, 20));
    }];
    /** 标题 */
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.titleSignView.mas_centerY);
        make.left.equalTo(self.titleSignView.mas_right).offset(10);
    }];
    /** 轮播图 */
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.titleSignView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@(150 * HScale));
    }];
    /** 轮播图占位图片 */
    [self.bannerPlaceholderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.bannerView.mas_top);
        make.left.equalTo(self.bannerView.mas_left);
        make.right.equalTo(self.bannerView.mas_right);
        make.bottom.equalTo(self.bannerView.mas_bottom);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.bannerView.mas_bottom).offset(16);
    }];
}

@end
