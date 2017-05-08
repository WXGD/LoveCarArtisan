//
//  ReviseRangeViewController.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import "ReviseRangeViewController.h"
// view
#import "ReviseRangeView.h"
// model
#import "ExpireModel.h"

@interface ReviseRangeViewController ()<ReviseRangeDelegate>

/** 修改范围view */
@property (strong, nonatomic) ReviseRangeView *reviseRangeView;

@end

@implementation ReviseRangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self userCardExpireLayoutView];
    // 布局nav
    [self userCardExpireLayoutNAV];
}


#pragma mark - 删除区间点击代理
- (void)delReviseRangeDelegate {
//    [self.navigationController popViewControllerAnimated:YES];
//    if (_AddDataSectionBlock) {
//        _AddDataSectionBlock();
//    }
}

#pragma mark - 按钮点击代理
// 添加数据区间
- (void)addDataSectionBtnAction:(UIButton *)button {

    
    /* /index.php?c=user_track&a=add_section&v=1
     provider_id 	int 	是 	服务商i的
     type 	int 	是 	数据类型 1-会员卡到期区间 2-会员卡余额不足区间 3-会员卡余次不足区间 4-会员长期未到店区间 5-用户消费区间
     min_value 	int 	是 	区间最小值
     max_value 	int 	是 	区间最大值    */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    switch (self.reviseRangeType) {
            /** 会员卡过期 */
        case UserCardExpireShowType: {
            params[@"type"] = @1; // 数据类型
            break;
        }
            /** 长期未到店  */
        case longNotShopShowType: {
            params[@"type"] = @4; // 数据类型
            break;
        }
            /** 余额 */
        case BalanceShowType: {
            params[@"type"] = @2; // 数据类型
            break;
        }
            /** 余次 */
        case LeaveSecondShowType: {
            params[@"type"] = @3; // 数据类型
            break;
        }
        default:
            break;
    }
    if (self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.text.length <= 0 && self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.text.length <= 0) {
        [MBProgressHUD showError:@"请填写区间范围"];
        return;
    }else if (self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.text.length > 0 && self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.text.length <= 0) {
        params[@"min_value"] = self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.text; // 区间最小值
        params[@"max_value"] = @""; // 区间最大值
    }else if (self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.text.length <= 0 && self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.text.length > 0) {
        params[@"min_value"] = @""; // 区间最小值
        params[@"max_value"] = self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.text; // 区间最大值
    }else {
            if ([self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.text integerValue] > [self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.text integerValue]) {
                [MBProgressHUD showError:@"请正确填写区间范围"];
                return;
            }
        params[@"min_value"] = self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.text; // 区间最小值
        params[@"max_value"] = self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.text; // 区间最大值
    }
    
    [ExpireModel addDataSection:params success:^{
//        if (_AddDataSectionBlock) {
//            _AddDataSectionBlock();
//        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 布局nav
- (void)userCardExpireLayoutNAV {
    
    switch (self.reviseRangeType) {
            /** 会员卡过期 */
        case UserCardExpireShowType: {
            self.navigationItem.title = @"自定义会员卡到期天数";
            self.reviseRangeView.reviseRangeFootView.addRangeLabel.text = @"输入会员卡到期天数区间";
            self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.placeholder = @"输入天数区间";
            self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.placeholder = @"输入天数区间";
            break;
        }
            /** 长期未到店  */
        case longNotShopShowType: {
            self.navigationItem.title = @"自定义未到店天数";
            self.reviseRangeView.reviseRangeFootView.addRangeLabel.text = @"输入未到店天数区间";
            self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.placeholder = @"输入天数区间";
            self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.placeholder = @"输入天数区间";
            break;
        }
            /** 余额 */
        case BalanceShowType: {
            self.navigationItem.title = @"自定义余额";
            self.reviseRangeView.reviseRangeFootView.addRangeLabel.text = @"输入余额区间";
            self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.placeholder = @"输入金额区间";
            self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.placeholder = @"输入金额区间";
            break;
        }
            /** 余次 */
        case LeaveSecondShowType: {
            self.navigationItem.title = @"自定义余次";
            self.reviseRangeView.reviseRangeFootView.addRangeLabel.text = @"输入余次区间";
            self.reviseRangeView.reviseRangeFootView.addRangeView.startTF.placeholder = @"输入次数区间";
            self.reviseRangeView.reviseRangeFootView.addRangeView.endTF.placeholder = @"输入次数区间";
            break;
        }
        default:
            break;
    }
    
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add_user"] style:UIBarButtonItemStyleDone target:self action:@selector(UserRightBarButtonItmeAction)];
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(UserRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)userCardExpireLayoutView {
    @weakify(self)
    /** 修改范围view */    
    self.reviseRangeView = [[ReviseRangeView alloc] init];
    self.reviseRangeView.rangeArray = self.rangeArray;
    self.reviseRangeView.delegate = self;
    // 添加区间数据
    [self.reviseRangeView.reviseRangeFootView.addRangeView.handleBtn addTarget:self action:@selector(addDataSectionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reviseRangeView];
    [self.reviseRangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_AddDataSectionBlock) {
        _AddDataSectionBlock();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
