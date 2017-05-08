//
//  RootViewController.m
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

/** 无数据view */
@property (strong, nonatomic) UIView *noDataView;
/** 无数据图片 */
@property (strong, nonatomic) UIImageView *noDataImageView;
/** 无数据文字 */
@property (strong, nonatomic) UILabel *noDataLabel;

@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 获取商户信息user
    self.merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 页面基础信息
    [self rootVCBasicInfo];
}

#pragma mark - 页面基础信息
- (void)rootVCBasicInfo {
    self.view.backgroundColor = VCBackground;
    // 获取商户信息user
    self.merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
}

#pragma mark - 无数据视图操作
// 显示没有数据页面
-(void)showNoDataView:(void(^)(UILabel *noLabel, UIImageView *noImage))noDataView {
    // 创建无数据视图
    [self noDataViewLayoutView];
    if (noDataView) {
        noDataView(self.noDataLabel, self.noDataImageView);
    }
}
// 移除无数据页面
-(void)removeNoDataView {
    if (_noDataView) {
        [self.noDataView removeFromSuperview];
    }
}
#pragma mark - 初始化无数据视图
- (void)noDataViewLayoutView {
    /** 无数据view */
    self.noDataView = [[UIView alloc] init];
    // 无数据视图，显示在tableview上面
    [self.view addSubview:_noDataView];
    /** 无数据文字 */
    self.noDataLabel = [[UILabel alloc] init];
    self.noDataLabel.font = FourteenTypeface;
    self.noDataLabel.textColor = GrayH2;
    self.noDataLabel.text = @"还没有数据哦！！！";
    self.noDataLabel.numberOfLines = 0;
    self.noDataLabel.textAlignment = NSTextAlignmentCenter;
    [self.noDataView addSubview:self.noDataLabel];
    @weakify(self)
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    /** 无数据图片 */
    self.noDataImageView = [[UIImageView alloc] init];
    self.noDataImageView.image = [UIImage imageNamed:@"placeholder_big_list"];
    [self.noDataView addSubview:self.noDataImageView];
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.noDataLabel.mas_centerX);
        make.bottom.equalTo(self.noDataLabel.mas_top).offset(-20);
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
