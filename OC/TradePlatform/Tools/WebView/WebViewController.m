//
//  WebViewController.m
//  CarRepairFactory
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WebViewController.h"
// 网页加载进度条
#import "WebProgressLayer.h"

@interface WebViewController ()<UIWebViewDelegate>

// webView
@property (nonatomic,strong) UIWebView *webView;
// 网页加载进度条
@property (nonatomic,strong) WebProgressLayer *progressLayer;

@end


@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self webViewLayoutNav];
    // 布局view
    [self webViewLayoutView];
}

#pragma mark - 加载URL
// 加载网络URL
- (void)loadNetworkHTML:(NSString *)htmlString {
    // 加载URL
    NSURL *url =[NSURL URLWithString:htmlString];
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [mutableRequest setValue:VERSION forHTTPHeaderField:@"version"];
    [mutableRequest setValue:BUILD forHTTPHeaderField:@"build"];
    [mutableRequest setValue:@"1" forHTTPHeaderField:@"appId"];
    [self.webView loadRequest:mutableRequest];
}


// 加载本地URL
- (void)loadLocalHTML:(NSString *)htmlString {
    // 取得本地html文件名
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:htmlString ofType:@"html"];
    NSString *htmlStr = [[NSString alloc] initWithContentsOfFile:resourcePath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:resourcePath]];
}
#pragma mark - 布局nav
- (void)webViewLayoutNav {
    // 返回按钮
    UIBarButtonItem *leftBackBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBackBtnAction)];
    // 关闭按钮
    UIBarButtonItem *leftCloseBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_close"] style:UIBarButtonItemStyleDone target:self action:@selector(leftCloseBtnAction)];
    NSArray *leftBarArray = [[NSArray alloc]initWithObjects:leftBackBtn,leftCloseBtn, nil];
    self.navigationItem.leftBarButtonItems = leftBarArray;
}

#pragma mark - 布局view
- (void)webViewLayoutView {
    // 加载web view
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    // 将此webview与WebViewJavascriptBridge关联
    if (self.bridge) { return; }
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
}

#pragma mark - webView代理方法
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    // 初始化进度条
    if (!_progressLayer) {
        _progressLayer = [[WebProgressLayer alloc] init];
        _progressLayer.frame = CGRectMake(0, 42, ScreenW, 2);
        [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    }
    return true;
}
// 网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];
}
// 网页完成加载
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressLayer finishedLoad];
    _progressLayer = nil;
    // 获取h5的标题
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
// 网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
    _progressLayer = nil;
}

#pragma mark - nav左边按钮
//点击返回的方法
- (void)leftBackBtnAction {
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
    } else {
        [self leftCloseBtnAction];
    }
}

//关闭H5页面，直接回到原生页面
- (void)leftCloseBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 界面销毁
- (void)dealloc {
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
