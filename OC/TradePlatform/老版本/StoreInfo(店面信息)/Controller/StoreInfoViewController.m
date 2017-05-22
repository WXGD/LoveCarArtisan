//
//  StoreInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StoreInfoViewController.h"
#import "StoreInfoView.h"
// 下级控制
#import "ChangeInfoViewController.h"

@interface StoreInfoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/** 商户信息view */
@property (strong, nonatomic) StoreInfoView *storeInfoView;

@end

@implementation StoreInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 界面赋值
    [self storeInfoAssignment];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self storeInfoLayoutNAV];
    // 布局视图
    [self storeInfoLayoutView];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
//  账户页面按钮点击方法
- (void)storeInfoBtnAction:(UIButton *)button {
    switch (button.tag) {
            /** 门头图片 */
        case StoreInfoBigImageBtnAction: {
//            // 图片选择
//            [AlertAction callCameraAlertActionStyleActionSheetBtn:button ViewController:self CameraBlock:^(UIImagePickerController *picker) {
//                // 设置代理
//                picker.delegate = self;
//            } albumBlock:^(UIImagePickerController *picker) {
//                // 设置代理
//                picker.delegate = self;
//            } cancelBlock:nil];
            break;
        }
            /** 名称 */
        case StoreInfoNameBtnAction: {
            ChangeInfoViewController *changeInfoVC = [[ChangeInfoViewController alloc] init];
            changeInfoVC.changeInfoExhibitionType = ChangeMerchantNameAssignment;
            [self.navigationController pushViewController:changeInfoVC animated:YES];
            break;
        }
            /** 电话 */
        case StoreInfoPhoneBtnAction: {
            ChangeInfoViewController *changeInfoVC = [[ChangeInfoViewController alloc] init];
            changeInfoVC.changeInfoExhibitionType = ChangePhoneAssignment;
            [self.navigationController pushViewController:changeInfoVC animated:YES];
            break;
        }
            /** 地址 */
        case StoreInfoAddressBtnAction: {
            ChangeInfoViewController *changeInfoVC = [[ChangeInfoViewController alloc] init];
            changeInfoVC.changeInfoExhibitionType = ChangeAddressAssignment;
            [self.navigationController pushViewController:changeInfoVC animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
        // 把选择的图片赋值给头像
        /** 门头图片 */
        self.storeInfoView.storeBigImageView.describeImage.image = image;
    } else {
        UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
        /** 门头图片 */
        self.storeInfoView.storeBigImageView.describeImage.image = image;
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 取消图片挑选
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark - 界面赋值
- (void)storeInfoAssignment {
    /** 门头图片 */
    [self.storeInfoView.storeBigImageView.describeImage setImageWithImageUrl:self.merchantInfo.thumb_image_url perchImage:@"placeholder_logo"];
    /** 名称 */
    self.storeInfoView.storeNameView.describeLabel.text = self.merchantInfo.name;
    /** 电话 */
    self.storeInfoView.storePhoneView.describeLabel.text = self.merchantInfo.service_tel;
    /** 地址 */
    self.storeInfoView.storeAddressView.describeLabel.text = self.merchantInfo.address;
}
#pragma mark - 布局nav
- (void)storeInfoLayoutNAV {
    self.navigationItem.title = @"店面信息";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)storeInfoLayoutView {
    /** 商户信息view */
    self.storeInfoView = [[StoreInfoView alloc] init];
    /** 门头图片 */
    [self.storeInfoView.storeBigImageView.usedCellBtn addTarget:self action:@selector(storeInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 名称 */
    [self.storeInfoView.storeNameView.usedCellBtn addTarget:self action:@selector(storeInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 电话 */
    [self.storeInfoView.storePhoneView.usedCellBtn addTarget:self action:@selector(storeInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 地址 */
    [self.storeInfoView.storeAddressView.usedCellBtn addTarget:self action:@selector(storeInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.storeInfoView];
    @weakify(self)
    [self.storeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
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
