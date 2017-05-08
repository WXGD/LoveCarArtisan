//
//  WebViewController.h
//  CarRepairFactory
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootViewController.h"
// webview和js交互
#import "WebViewJavascriptBridge.h"

@interface WebViewController : RootViewController

// webview和js交互
@property (nonatomic,strong) WebViewJavascriptBridge *bridge;

#pragma mark - webView代理方法
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;
#pragma mark - 加载URL
/** 加载网络URL */
- (void)loadNetworkHTML:(NSString *)htmlString;
/** 加载本地URL */
- (void)loadLocalHTML:(NSString *)htmlString;

@end
