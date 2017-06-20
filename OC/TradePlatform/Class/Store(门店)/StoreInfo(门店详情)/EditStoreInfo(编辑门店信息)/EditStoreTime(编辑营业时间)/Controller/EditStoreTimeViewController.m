//
//  EditStoreTimeViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditStoreTimeViewController.h"
// view
#import "EditStoreTimeView.h"
// 网络请求
#import "EditStoreInfoNetwork.h"

@interface EditStoreTimeViewController ()
/** 编辑营业时间view */
@property (strong, nonatomic) EditStoreTimeView *editStoreTimeView;

@end

@implementation EditStoreTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self editStoreTimeLayoutNAV];
    // 布局视图
    [self editStoreTimeLayoutView];
    // 界面赋值
    [self editStoreTimeAssignment];
}

#pragma mark - 界面赋值
- (void)editStoreTimeAssignment {
    /** 开始时间 */
    [self.editStoreTimeView.startBtn setTitle:self.startStr forState:UIControlStateNormal];
    /** 结束时间 */
    [self.editStoreTimeView.endBtn setTitle:self.endStr forState:UIControlStateNormal];
}

#pragma mark - 按钮点击方法
- (void)editStoreTimeRightBtnAction {
    // 确定修改过营业时间
    if ([self.storeModel.business_start_time isEqualToString:self.editStoreTimeView.startBtn.titleLabel.text] && [self.editStoreTimeView.startBtn.titleLabel.text isEqualToString:self.editStoreTimeView.startBtn.titleLabel.text]) {
        [MBProgressHUD showError:@"请确认修改后在提交"];
        return;
    }
    /*/index.php?c=provider&a=edit&v=1
     provider_id 	int 	是 	服务商id
     data 	string 	是 	修改的信息： 数据格式： 数据库字段名=值(店名----name 地址--address 电话--service_tel)  */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
    params[@"data"] = [NSString stringWithFormat:@"business_start_time=%@,business_end_time=%@", self.editStoreTimeView.startBtn.titleLabel.text,self.editStoreTimeView.endBtn.titleLabel.text]; // 需要修改的商户信息
    [EditStoreInfoNetwork editMerchantInfoParams:params success:^{
        // 修改营业时间
        self.storeModel.business_start_time = self.editStoreTimeView.startBtn.titleLabel.text;
        self.storeModel.business_end_time = self.editStoreTimeView.endBtn.titleLabel.text;
        if (_EditStoreTimeSuccess) {
            _EditStoreTimeSuccess(self.storeModel);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];

}


#pragma mark - 布局nav
- (void)editStoreTimeLayoutNAV {
    self.navigationItem.title = @"编辑营业时间";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(editStoreTimeRightBtnAction)];
}
#pragma mark - 布局视图
- (void)editStoreTimeLayoutView {
    /** 编辑营业时间view */
    self.editStoreTimeView = [[EditStoreTimeView alloc] init];
    [self.view addSubview:self.editStoreTimeView];
    @weakify(self)
    [self.editStoreTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
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
