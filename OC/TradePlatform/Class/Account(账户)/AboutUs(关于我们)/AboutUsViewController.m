//
//  AboutUsViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载网络URL
    [self loadNetworkHTML:self.webUrl];
}



#pragma mark - webView代理方法
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    return true;
}
#pragma mark - 布局nav


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
