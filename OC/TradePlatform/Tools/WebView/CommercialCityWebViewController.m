//
//  CommercialCityWebViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommercialCityWebViewController.h"
// 支付宝
#import "ALiPay.h"
#import "ALiPayHandle.h"
// 微信支付
#import "WXPayment.h"
#import "WXApiManager.h"
// 接收上级页面的参数
#import "UIViewController+DCURLRouter.h"

@interface CommercialCityWebViewController ()<ALiPayHandleDelegate, WXApiManagerDelegate>

@end

@implementation CommercialCityWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 微信回调代理
    [WXApiManager sharedManager].delegate = self;
    // 支付宝回调代理
    [ALiPayHandle sharedManager].delegate = self;
    // web和html交互
    [self webAndHtmlInteractiveMethod];
    // 判断是否有URL，如果没有
    if (self.webUrl.length == 0) {
        // 判断是非需要登陆者ID
        if ([[NSString stringWithFormat:@"%@", self.params[@"web_url_id"]] isEqualToString:@"0"]) {
            self.webUrl = self.params[@"web_url"];
        }else {
            self.webUrl = [NSString stringWithFormat:@"%@%@", self.params[@"web_url"], self.merchantInfo.provider_id];
        }
    }
}




- (void)setWebUrl:(NSString *)webUrl {
    _webUrl = webUrl;
    // 加载网络URL
    [self loadNetworkHTML:webUrl];
}

/** web和html交互方法 */
- (void)webAndHtmlInteractiveMethod {
    // 支付宝按钮点击
    [self.bridge registerHandler:@"aliPayOnClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        [ALiPay callALiPayOrderDic:data[@"payDic"] paymentEndBlock:^(NSDictionary *resultDic) {
            
        }];
    }];
    // 微信支付按钮点击
    [self.bridge registerHandler:@"wxPayOnClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        // 调用微信
        [WXPayment callPayment:data[@"payDic"]];
    }];
}

#pragma mark - 支付宝回调代理
- (void)aLiPaySuccessCallback:(NSDictionary *)aliPayDic {
    // 支付宝支付状态
    NSString *payState = [[NSString alloc] init];
    if ([[NSString stringWithFormat:@"%@", aliPayDic[@"resultStatus"]] isEqualToString:@"9000"]) {
        payState = @"1";
    }else if ([[NSString stringWithFormat:@"%@", aliPayDic[@"resultStatus"]] isEqualToString:@"4000"]) {
        payState = @"0";
    }else if ([[NSString stringWithFormat:@"%@", aliPayDic[@"resultStatus"]] isEqualToString:@"6001"]) {
        payState = @"-1";
    }else {
        payState = @"0";
    }
    PDLog(@"%@", payState);
    NSMutableDictionary *payStateDic = [[NSMutableDictionary alloc] init];
    [payStateDic setObject:payState forKey:@"payState"];
    // 支付宝支付回调
    [self.bridge callHandler:@"aliPayComplete"data:payStateDic responseCallback:^(id responseData) {

        PDLog(@"%@", responseData);
    }];
}

#pragma mark - 微信支付成功回调
- (void)managerDidRecvPayResp:(PayResp *)payResp {
    PDLog(@"%@", [NSString stringWithFormat:@"%d", payResp.errCode]);
    // 微信支付状态
    NSString *payState = [[NSString alloc] init];
    if ([[NSString stringWithFormat:@"%d", payResp.errCode] isEqualToString:@"0"]) {
        payState = @"1";
    }else if ([[NSString stringWithFormat:@"%d", payResp.errCode] isEqualToString:@"-1"]) {
        payState = @"0";
    }else if ([[NSString stringWithFormat:@"%d", payResp.errCode] isEqualToString:@"-2"]) {
        payState = @"-1";
    }else {
        payState = @"0";
    }
    PDLog(@"%@", payState);
    NSMutableDictionary *payStateDic = [[NSMutableDictionary alloc] init];
    [payStateDic setObject:payState forKey:@"payState"];
    // 微信支付回调
    [self.bridge callHandler:@"wxPayComplete"data:payStateDic responseCallback:^(id responseData) {
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
