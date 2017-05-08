//
//  QRCodeViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()

/** 二维码 */
@property (strong, nonatomic) UIImageView *qrImage;
/** 提示文字 */
@property (strong, nonatomic) UILabel *qrTitleLable;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self QRCodeLayoutNAV];
    // 布局视图
    [self QRCodeLayoutView];
    // 界面赋值
    [self QRCodeAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法

#pragma mark - 界面赋值
- (void)QRCodeAssignment {
    
}
#pragma mark - 布局nav
- (void)QRCodeLayoutNAV {
    self.navigationItem.title = @"公众号二维码";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)QRCodeLayoutView {
    @weakify(self)
    /** 二维码 */
    self.qrImage = [[UIImageView alloc] init];
    [self.qrImage setImageWithImageUrl:self.imageStr perchImage:@"placeholder_logo"];
    [self.view addSubview:self.qrImage];
    [self.qrImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(40);
        make.height.mas_equalTo(@(200 * HScale));
        make.width.equalTo(self.qrImage.mas_height);
    }];
    /** 提示文字 */
    self.qrTitleLable = [[UILabel alloc] init];
    self.qrTitleLable.text = self.textStr;
    self.qrTitleLable.numberOfLines = 0;
    self.qrTitleLable.textColor = GrayH1;
    self.qrTitleLable.font = FifteenTypeface;
    self.qrTitleLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.qrTitleLable];
    [self.qrTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.qrImage.mas_bottom).offset(25);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
