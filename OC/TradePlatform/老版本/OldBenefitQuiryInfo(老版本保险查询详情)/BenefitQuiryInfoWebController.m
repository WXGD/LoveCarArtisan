//
//  BenefitQuiryInfoWebController.m
//  TradePlatform
//
//  Created by apple on 2017/3/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitQuiryInfoWebController.h"
// 发短信
#import <MessageUI/MessageUI.h>
// 分享
#import "ShareView.h"

@interface BenefitQuiryInfoWebController ()<ShareOptionChoiceDelegate, MFMessageComposeViewControllerDelegate>


@end

@implementation BenefitQuiryInfoWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self benefitQuiryInfoWebLayoutNav];
    // 加载网络URL
    // 中文转化
    NSString *encodedString = [self.webUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self loadNetworkHTML:encodedString];
}

// 分享
- (void)shareBtnAction:(UIButton *)sender {
    ShareView *shareView = [[ShareView alloc] init];
    shareView.delegate = self;
    [shareView show];
}

// 分享项目选择按钮
- (void)shareOptionChoiceBtnAction:(UIButton *)button {
    switch (button.tag) {
            /** 微信分享 */
        case WeiXinShareBtnAction: {
            
            break;
        }
            /** 手机号分享 */
        case PhoneShareBtnAction: {
            /** 调用系统电话 */
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.quiryRecordModel.mobile]]];
            break;
        }
            /** 短信分享 */
        case SmsShareBtnAction: {
            if( [MFMessageComposeViewController canSendText] ){
                MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
                controller.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@", self.quiryRecordModel.mobile]];
                // 中文转化
                NSString *encodedString = [self.webUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                controller.body = [NSString stringWithFormat:@"保险查询结果，点击链接查看%@", encodedString];
                controller.messageComposeDelegate = self;
                [self presentViewController:controller animated:YES completion:nil];
                [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
            }else{
                [MBProgressHUD showError:@"设备没有短信功能"];
            }
            break;
        }
        default:
            break;
    }
}
#pragma mark - 发送短信代理方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:NO completion:nil];//关键的一句   不能为YES
    switch ( result ) {
        case MessageComposeResultCancelled:
            [MBProgressHUD showError:@"发送取消"];
            break;
        case MessageComposeResultFailed:
            [MBProgressHUD showSuccess:@"发送成功"];
            break;
        case MessageComposeResultSent:
            [MBProgressHUD showError:@"发送失败"];
            break;
        default:
            break;
    }
}

#pragma mark - webView代理方法
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    return true;
}
#pragma mark - 布局nav
- (void)benefitQuiryInfoWebLayoutNav {
    // 分享按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
