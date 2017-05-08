//
//  FeedbackViewController.m
//  LoveCarEHome
//
//  Created by 爱车e家 on 16/4/7.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import "FeedbackViewController.h"
#import "PlacehoderTextView.h"

@interface FeedbackViewController ()

/** 发送 */
@property (nonatomic, strong) UIButton *submitBtn;
/** 输入框 */
@property (nonatomic, strong) PlacehoderTextView *placehoder;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"意见反馈";
    
    self.placehoder = [[PlacehoderTextView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    _placehoder.placeholder = @"请留下您的宝贵意见，我们将不断完善！";
    _placehoder.wordLimit = @"500";
    [self.view addSubview:_placehoder];
    
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame = CGRectMake(10, CGRectGetMaxY(_placehoder.frame) + 60, ScreenW - 20, 44);
    [_submitBtn setTitle:@"发送" forState:UIControlStateNormal];
    _submitBtn.backgroundColor = NotClick;
    [_submitBtn addTarget:self action:@selector(feedbackSubmitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 2;
    _submitBtn.userInteractionEnabled = NO;
    [self.view addSubview:_submitBtn];
    
    // 监听文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:_placehoder];
}

#pragma mark - 监听方法
/** 监听文字改变 */
- (void)textDidChange {
    if (self.placehoder.hasText) {
        _submitBtn.backgroundColor = ThemeColor;
        _submitBtn.userInteractionEnabled = YES;
    }else {
        _submitBtn.backgroundColor = NotClick;
        _submitBtn.userInteractionEnabled = NO;
    }
}

/** 发送 */
- (void)feedbackSubmitBtnAction:(UIButton *)button {
    /*/index.php?c=feedback&a=add&v=1
     staff_user_id 	int 	是 	登录者id
     os 	int 	是 	0:未知 1：iOS 2：Android
     os_version 	string 	是 	操作系统版本号
     content 	string 	是 	反馈内容   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"feedback", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
    parameters[@"content"] = self.placehoder.text; // 反馈内容
    parameters[@"os"] = @"1"; // 0：未知1：ios 2：Android
    parameters[@"os_version"] = CurrentSystemVersion; // 操作系统版本
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在提交..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showSuccess:@"谢谢您的支持"];
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}
// 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
