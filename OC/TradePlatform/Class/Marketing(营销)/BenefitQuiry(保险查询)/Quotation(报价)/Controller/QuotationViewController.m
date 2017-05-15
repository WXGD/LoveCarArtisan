//
//  QuotationViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QuotationViewController.h"
// view
#import "QuotationView.h"
// model
#import "QuotationModel.h"
// 下级页面
#import "PolicyDetailViewController.h"
// 发短信
#import <MessageUI/MessageUI.h>
// 分享
#import "ShareView.h"

@interface QuotationViewController ()<ShareOptionChoiceDelegate, MFMessageComposeViewControllerDelegate>

/** 报价view */
@property (strong, nonatomic) QuotationView *quotationView;
/** 报价数据 */
@property (strong, nonatomic) NSMutableArray *quotationArr;
@end

@implementation QuotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self quotationLayoutNAV];
    // 布局视图
    [self quotationLayoutView];
    // 网络请求
    [self quotationRequestData];
}
#pragma mark - 网络请求
- (void)quotationRequestData{
    QuotationModel *quotationModel = [[QuotationModel alloc] init];
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"insurance_query_id"] = self.inquiryModel.insurance_query_id; // 服务商id
    // 网络请求
    
    [quotationModel quotationRefreshRequestData:nil params:params viewController:self success:^(NSMutableArray *orderArray) {
        // 移除无数据视图
        [self removeNoDataView];
        self.quotationArr = orderArray;

    }];
}

#pragma mark - 按钮点击方法
// nav右边按钮
- (void)quotationRightBarBtnAction {
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
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.inquiryModel.mobile]]];
            break;
        }
            /** 短信分享 */
        case SmsShareBtnAction: {
            if( [MFMessageComposeViewController canSendText] ){
                MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
                controller.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@", self.inquiryModel.mobile]];
                // 中文转化
//                NSString *encodedString = [self.webUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                controller.body = [NSString stringWithFormat:@"保险查询结果"];
                controller.messageComposeDelegate = self;
                [self presentViewController:controller animated:YES completion:nil];
                [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"短信"];//修改短信界面标题
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



#pragma mark - 车险询价功能选择按钮
- (void)quotationBtnAvtion:(UIButton *)button {
    
}

#pragma mark - 界面赋值
- (void)setQuotationArr:(NSMutableArray *)quotationArr {
    _quotationArr = quotationArr;
    [self quotationLayoutView];
}


#pragma mark - 布局nav
- (void)quotationLayoutNAV {
    self.navigationItem.title = @"报价";
    if ([CustomObject checkTel:self.inquiryModel.mobile]) {
        // 右边
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(quotationRightBarBtnAction)];
    }
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(quotationRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)quotationLayoutView {
    /** 报价view */
    self.quotationView = [[QuotationView alloc] init];
    self.quotationView.inquiryModel = self.inquiryModel;
    @weakify(self)
    self.quotationView.policyDetail = ^(InsuranceQuoteModel *insuranceQuoteModel) {
        @strongify(self)
        PolicyDetailViewController *detailVC = [[PolicyDetailViewController alloc] init];
        detailVC.whereFrom = 1;
        detailVC.insuranceQuoteModel = insuranceQuoteModel;
        detailVC.inquiryRecordModel = self.inquiryModel;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    
    NSMutableArray *planArr = [[NSMutableArray alloc] initWithCapacity:0];
    if (_quotationArr.count>0) {
        for (int i = 0; i < _quotationArr.count; i++) {
            NSString *planNum = [NSString stringWithFormat:@"方案%d",i+1];
            [planArr addObject:planNum];
        }
        self.quotationView.schemeArray = planArr;//(NSMutableArray *)@[@"方案一", @"方案二", @"方案三", @"方案四", @"方案五", @"方案六", @"方案七", @"方案八", @"方案九", @"方案十", @"方案十一"];
        self.quotationView.dataArray = _quotationArr;
    }
    [self.view addSubview:self.quotationView];
    [self.quotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
