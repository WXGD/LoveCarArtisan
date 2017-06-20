//
//  StoreInfoViewController.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "StoreInfoViewController.h"
#import "StoreInfoView.h"
//下级
#import "EditStoreInfoViewController.h"
#import "EditStoreTimeViewController.h"

@interface StoreInfoViewController ()
@property (nonatomic, strong) StoreInfoView *storeInfoView;
/** 二维码bgView */
@property (nonatomic, strong) UIView *qrBgView;
/** 二维码imageView */
@property (nonatomic, strong) UIImageView *qrimageView;
/** 二维码label*/
@property (nonatomic, strong) UILabel *qrLab;
@end

@implementation StoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self storeInfoLayoutNAV];
    // 布局视图
    [self storeInfoLayoutView];
    // 填充数据
    self.storeModel = _storeModel;
}
#pragma mark - 填充数据
-(void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    [self.storeInfoView.imageView setImageWithImageUrl:self.storeModel.image_url perchImage:@"placeholder_search_user"];
    self.storeInfoView.storeNameView.describeLabel.text = self.storeModel.name;
    self.storeInfoView.telPhoneView.describeLabel.text = self.storeModel.service_tel;
    self.storeInfoView.messagePhoneView.describeLabel.text = self.storeModel.service_mobile;
    self.storeInfoView.addressLabel.text = self.storeModel.address;
    self.storeInfoView.timeView.describeLabel.text = [NSString stringWithFormat:@"%@-%@",self.storeModel.business_start_time,self.storeModel.business_end_time];
}
#pragma mark - 布局nav
- (void)storeInfoLayoutNAV {
    self.navigationItem.title = @"门店详情";
    // 左边
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(myAccountLeftBtnAction)];
    // 右边
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_account_account_bank"] style:UIBarButtonItemStyleDone target:self action:@selector(bankCardManagement)];
}
#pragma mark - 布局视图
- (void)storeInfoLayoutView {
    /** 门店详情 */
    self.storeInfoView = [[StoreInfoView alloc] init];
    [self.view addSubview:self.storeInfoView];
    @weakify(self)
    [self.storeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.storeInfoView.storeNameView.usedCellBtn addTarget:self action:@selector(storeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeInfoView.telPhoneView.usedCellBtn addTarget:self action:@selector(storeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeInfoView.messagePhoneView.usedCellBtn addTarget:self action:@selector(storeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeInfoView.addressView.usedCellBtn addTarget:self action:@selector(storeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeInfoView.timeView.usedCellBtn addTarget:self action:@selector(storeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeInfoView.qrCodeView.usedCellBtn addTarget:self action:@selector(storeClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)storeClick:(UIButton *)btn{
    switch (btn.tag) {
        /** 店名 */
        case StoreNameBtnAction:{
            EditStoreInfoViewController *editStoreInfoVC = [[EditStoreInfoViewController alloc] init];
            /** 编辑信息页面标题 */
            editStoreInfoVC.navTitleStr = @"编辑店名";
            /** 编辑信息类型标题 */
            editStoreInfoVC.typeTitleStr = @"店名：";
            /** 编辑信息提示文字 */
            editStoreInfoVC.placeholderStr = @"请输入店名";
            /** 编辑信息回显文字 */
            editStoreInfoVC.echoStr = self.storeModel.name;
            /** 门店信息 */
            editStoreInfoVC.storeModel = self.storeModel;
            /** 输入框响应类型 */
            editStoreInfoVC.editStoreInfoType = EditStoreName;
            /** 修改成功回调 */
            editStoreInfoVC.EditStoreInfoSuccess = ^(StoreModel *storeModel) {
                self.storeModel = storeModel;
            };
            [self.navigationController pushViewController:editStoreInfoVC animated:YES];
            break;
        }
        /** 客服电话 */
        case StoreTelPhoneBtnAction:{
            EditStoreInfoViewController *editStoreInfoVC = [[EditStoreInfoViewController alloc] init];
            /** 编辑信息页面标题 */
            editStoreInfoVC.navTitleStr = @"编辑客服电话";
            /** 编辑信息类型标题 */
            editStoreInfoVC.typeTitleStr = @"客服电话：";
            /** 编辑信息提示文字 */
            editStoreInfoVC.placeholderStr = @"请输入客服电话";
            /** 编辑信息回显文字 */
            editStoreInfoVC.echoStr = self.storeModel.service_tel;
            /** 门店信息 */
            editStoreInfoVC.storeModel = self.storeModel;
            /** 输入框响应类型 */
            editStoreInfoVC.editStoreInfoType = EditStoreServicePhone;
            /** 修改成功回调 */
            editStoreInfoVC.EditStoreInfoSuccess = ^(StoreModel *storeModel) {
                self.storeModel = storeModel;
            };
            [self.navigationController pushViewController:editStoreInfoVC animated:YES];
            break;
        }
        /** 短信电话 */
        case StoreMessagePhoneBtnAction:{
            EditStoreInfoViewController *editStoreInfoVC = [[EditStoreInfoViewController alloc] init];
            /** 编辑信息页面标题 */
            editStoreInfoVC.navTitleStr = @"编辑通知电话";
            /** 编辑信息类型标题 */
            editStoreInfoVC.typeTitleStr = @"通知电话：";
            /** 编辑信息提示文字 */
            editStoreInfoVC.placeholderStr = @"请输入短信通知电话";
            /** 编辑信息回显文字 */
            editStoreInfoVC.echoStr = self.storeModel.service_mobile;
            /** 门店信息 */
            editStoreInfoVC.storeModel = self.storeModel;
            /** 输入框响应类型 */
            editStoreInfoVC.editStoreInfoType = EditStoreNoticePhone;
            /** 修改成功回调 */
            editStoreInfoVC.EditStoreInfoSuccess = ^(StoreModel *storeModel) {
                self.storeModel = storeModel;
            };
            [self.navigationController pushViewController:editStoreInfoVC animated:YES];
            break;
        }
        /** 地址 */
        case StoreAddressBtnAction:{
            EditStoreInfoViewController *editStoreInfoVC = [[EditStoreInfoViewController alloc] init];
            /** 编辑信息页面标题 */
            editStoreInfoVC.navTitleStr = @"编辑地址";
            /** 编辑信息类型标题 */
            editStoreInfoVC.typeTitleStr = @"地址：";
            /** 编辑信息提示文字 */
            editStoreInfoVC.placeholderStr = @"请输入店面地址";
            /** 编辑信息回显文字 */
            editStoreInfoVC.echoStr = self.storeModel.address;
            /** 门店信息 */
            editStoreInfoVC.storeModel = self.storeModel;
            /** 输入框响应类型 */
            editStoreInfoVC.editStoreInfoType = EditStoreAddress;
            /** 修改成功回调 */
            editStoreInfoVC.EditStoreInfoSuccess = ^(StoreModel *storeModel) {
                self.storeModel = storeModel;
            };
            [self.navigationController pushViewController:editStoreInfoVC animated:YES];
            break;
        }
        /** 营业时间 */
        case StoreTimeBtnAction:{
            EditStoreTimeViewController *editStoreTimeVC = [[EditStoreTimeViewController alloc] init];
            /** 开始时间 */
            editStoreTimeVC.startStr = self.storeModel.business_start_time;
            /** 结束时间 */
            editStoreTimeVC.endStr = self.storeModel.business_end_time;
            /** 门店信息 */
            editStoreTimeVC.storeModel = self.storeModel;
            /** 修改成功回调 */
            editStoreTimeVC.EditStoreTimeSuccess = ^(StoreModel *storeModel) {
                self.storeModel = storeModel;
            };
            [self.navigationController pushViewController:editStoreTimeVC animated:YES];
            break;
        }
        /** 微信公众号 */
        case StoreQrBtnAction:{
            [self showQr];
            break;
        }
        default:
            break;
    }
}
- (void)showQr{
    self.qrBgView = [[UIView alloc] init];
    self.qrBgView.userInteractionEnabled = YES;
    self.qrBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissQr)];
    [self.qrBgView addGestureRecognizer:ges];
    UIWindow *currentWindow =  [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self.qrBgView];
    @weakify(self)
    [self.qrBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(-64);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    self.qrimageView = [[UIImageView alloc] init];
    [self.qrimageView setImageWithImageUrl:self.storeModel.wxmp_qrcode perchImage:@"placeholder_logo"];
    [self.qrBgView addSubview:self.qrimageView];
    [self.qrimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.qrBgView.mas_top).offset(162);
        make.centerX.equalTo(self.qrBgView.mas_centerX);
        make.height.mas_equalTo(@200);
        make.width.mas_equalTo(@200);
    }];
    self.qrLab = [[UILabel alloc] init];
    self.qrLab.text = @"关注微信公众号，更便捷，更优惠";
    self.qrLab.textAlignment = NSTextAlignmentCenter;
    self.qrLab.font = FourteenTypeface;
    self.qrLab.textColor = WhiteColor;
    [self.qrBgView addSubview:self.qrLab];
    [self.qrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.qrimageView.mas_bottom).offset(35);
        make.centerX.equalTo(self.qrBgView.mas_centerX);
        make.left.equalTo(self.qrBgView.mas_left);
        make.right.equalTo(self.qrBgView.mas_right);
    }];
}
- (void)dissmissQr{
    [self.qrBgView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
