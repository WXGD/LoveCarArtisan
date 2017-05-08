//
//  BannerWebViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BannerWebViewController.h"

@implementation BannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self benefitQuiryInfoWebLayoutNav];
    // 加载网络URL
    [self loadNetworkHTML:self.webUrl];
}


#pragma mark - 布局nav
- (void)benefitQuiryInfoWebLayoutNav {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end

