//
//  ImageCropViewController.m
//  CarRepairFactory
//
//  Created by apple on 2016/11/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ImageCropViewController.h"

@interface ImageCropViewController ()

/** 请对齐行驶证边缘裁图 */
@property (nonatomic, strong) UILabel *carEngineaLigned;

@end

@implementation ImageCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageCropLayoutView];
}

- (void)imageCropLayoutView {    
    /** 请对齐行驶证边缘裁图 */
    self.carEngineaLigned = [[UILabel alloc] init];
    self.carEngineaLigned.font = TwelveTypeface;
    self.carEngineaLigned.textColor = WhiteColor;
    self.carEngineaLigned.text = @"请对齐行驶证边缘裁图";
    self.carEngineaLigned.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.carEngineaLigned];
    /** 请对齐行驶证边缘裁图 */
    [self.carEngineaLigned mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
