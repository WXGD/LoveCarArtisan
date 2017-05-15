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
/** 旋转图片 */
@property (nonatomic, strong) UIButton *rotateImgBtn;

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
    /** 旋转图片 */
    self.rotateImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rotateImgBtn setImage:[UIImage imageNamed:@"rotate_image"] forState:UIControlStateNormal];
    [self.rotateImgBtn addTarget:self action:@selector(rotateImgBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rotateImgBtn];
    [self.rotateImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
}


- (void)rotateImgBtnAction:(UIButton *)button {
    self.image = [self image:self.image];
}





- (UIImage *)image:(UIImage *)image {
    
    long double rotate = 0.0;
    
    CGRect rect;
    
    float translateX = 0;
    
    float translateY = 0;
    
    float scaleX = 1.0;
    
    float scaleY = 1.0;
    
    
    
    
    
    rotate = M_PI_2;
    
    rect = CGRectMake(0, 0, image.size.height, image.size.width);
    
    translateX = 0;
    
    translateY = -rect.size.width;
    
    scaleY = rect.size.width/rect.size.height;
    
    scaleX = rect.size.height/rect.size.width;
    
    
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //做CTM变换
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextRotateCTM(context, rotate);
    
    CGContextTranslateCTM(context, translateX, translateY);
    
    
    
    CGContextScaleCTM(context, scaleX, scaleY);
    
    //绘制图片
    
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    return newPic;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
