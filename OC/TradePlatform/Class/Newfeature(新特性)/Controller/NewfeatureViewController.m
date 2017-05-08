//
//  NewfeatureViewController.m
//  WeiBo
//
//  Created by lanouscrollCountg on 15/9/24.
//  Copyright (c) 2015年 cc. All rights reserved.
//
#define scrollCount 3

#import "NewfeatureViewController.h"
#import "SMPageControl.h"
// 下级控制器
#import "TabbarViewController.h"
#import "NavigationViewController.h"
#import "LoginViewController.h"
// 推送设置别名
#import "JPUSHService.h"

@interface NewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SMPageControl *pageControl;

@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置推送标签
    [JPUSHService setTags:nil alias:self.merchantInfo.staff_user_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        PDLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
    }];
//    NSArray *rgbArray = @[RGBColor(95, 245, 250, 1), RGBColor(251, 215, 69, 1), RGBColor(250, 95, 95, 1)];
    // 1.创建一个scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    // 2.添加图片到scrollView上
    CGFloat scrollW = self.scrollView.width;
    CGFloat scrollH = self.scrollView.height;
    for (int i = 0; i < scrollCount; i++) {
        
        UIView *view = [[UIView alloc] init];
        view.width = scrollW;
        view.height = scrollH;
        view.y = 0;
        view.x = i * scrollW;
        view.backgroundColor = ThemeColor;

        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        // 显示图片
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"newfeature_%d", i + 1]];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            if (scrollW == 320) {
                make.top.equalTo(view.mas_top);
            }else {
                make.top.equalTo(view.mas_top).offset(70);
            }
        }];
        [_scrollView addSubview:view];
        
        // 如果是最后一个imageView就添加其他内容
        if (i == scrollCount - 1) {
            [self setupLastView:view imageView:imageView];
        }
    }
    // 设置scrollView的其他属性
    _scrollView.contentSize = CGSizeMake(scrollW * scrollCount, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 添加pageControl
    self.pageControl = [[SMPageControl alloc] init];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.numberOfPages = scrollCount;
    _pageControl.indicatorMargin = 20.0f;
    _pageControl.indicatorDiameter = 10.0f;
//    _pageControl.pageIndicatorTintColor = GrayH2;
//    _pageControl.currentPageIndicatorTintColor = ThemeColor;
    _pageControl.pageIndicatorImage = [UIImage imageNamed:@"newfeature_unchecked"];
    _pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"newfeature_checked"];
    [self.view addSubview:_pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@100);
    }];
    // 跳过按钮
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn setBackgroundColor:RGBA(0, 0, 0, 0.4)];
    [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    skipBtn.layer.masksToBounds = YES;
    skipBtn.layer.cornerRadius = 5;
    [skipBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipBtn];
    [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}

- (void)startBtnClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    // 判断是否登陆
    if (merchantInfo.provider_id) {
        window.rootViewController = [[TabbarViewController alloc] init];
    }else {
        window.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = scrollView.contentOffset.x / scrollView.width + 0.5;
    self.pageControl.currentPage = page;
}

// 最后一个imageView
- (void)setupLastView:(UIView *)view imageView:(UIImageView *)imageView {
    
    view.userInteractionEnabled = YES;

    // 开始旅程
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitle:@"开始使用" forState:UIControlStateNormal];
    [startBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    startBtn.backgroundColor = WhiteColor;
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"了解我们点击前"] forState:UIControlStateNormal];
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"了解我们点击后"] forState:UIControlStateSelected];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    startBtn.layer.masksToBounds = YES;
    startBtn.layer.cornerRadius = 2;
//    [startBtn.layer setBorderWidth:2];
//    CGColorRef colorRef = RGBColor(70, 70, 70, 1).CGColor;
//    [startBtn.layer setBorderColor:colorRef];
    [view addSubview:startBtn];
    // 按钮位置
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.top.equalTo(imageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
}
- (void)shareClick:(UIButton *)shareBtn {
    
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
