//
//  PhotographViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define AppWidth [[UIScreen mainScreen] bounds].size.width
#define AppHeigt [[UIScreen mainScreen] bounds].size.height


#import "PhotographViewController.h"
// 相机
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
// 网络请求
#import "PhotographNetwork.h"
// 下级控制器
#import "CashierViewController.h"
// view
#import "OperationBtn.h"

@interface PhotographViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIView *preview;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureStillImageOutput *imageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewSubLayer;
/** 拍摄范围 */
@property (strong, nonatomic) UIImageView *shootingAreaImage;
/** 闪光灯 */
@property (strong, nonatomic) OperationBtn *openBtn;

@end

@implementation PhotographViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在页面出现的时候就将黑线隐藏起来
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // nav透明
    self.navigationController.navigationBar.translucent = YES;
    // 背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:192/255.0f green:192/255.0f blue:192/255.0f alpha:0.7];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    // nav不透明
    self.navigationController.navigationBar.translucent = NO;
    // 背景颜色
    self.navigationController.navigationBar.barTintColor = ThemeColor;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.preview = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.preview];
    // session 连接到 captureDevive
    self.session = [[AVCaptureSession alloc] init];
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    if ([self.session canAddInput:deviceInput])
        [self.session addInput:deviceInput];
    // 初始化界面按键
    [self initViewsOfButtons:captureDevice.flashMode];
    // 预览 session
    [self loadPreviewLayer];
    // output
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *setting = [[NSDictionary alloc]initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.imageOutput setOutputSettings:setting];
    [self.session addOutput:self.imageOutput];
    [self.session startRunning];
}


// 预览 session
- (void)loadPreviewLayer {
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [previewLayer setFrame:[UIScreen mainScreen].bounds];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.preview.layer setMasksToBounds:YES];
    [self.preview.layer insertSublayer:previewLayer atIndex:0];
}


// 初始化按键
- (void)initViewsOfButtons:(AVCaptureFlashMode) flashMode {
    // 拍摄范围
    CGFloat imageX = 30;
    CGFloat imageW = self.preview.width - (imageX * 2);
    CGFloat imageH = 150 * HScale;
    CGFloat imageY = 114;
    self.shootingAreaImage = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    self.shootingAreaImage.image = [UIImage imageNamed:@"scan_photo_frame"];
    [self.preview addSubview:self.shootingAreaImage];
    // 上边
    UIView *viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.preview.width, imageY)];
    viewTop.backgroundColor = RGBA(0, 0, 0, 0.2);
    [self.preview addSubview:viewTop];
    // 左边
    CGFloat viewLeftH = self.preview.height - imageY;
    UIView *viewLeft = [[UIView alloc] initWithFrame:CGRectMake(0, imageY, imageX, viewLeftH)];
    viewLeft.backgroundColor = RGBA(0, 0, 0, 0.2);
    [self.preview addSubview:viewLeft];
    // 右边
    UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shootingAreaImage.frame), imageY, imageX, viewLeftH)];
    viewRight.backgroundColor = RGBA(0, 0, 0, 0.2);
    [self.preview addSubview:viewRight];
    // 下边
    CGFloat viewBotH = self.preview.height - CGRectGetMaxY(self.shootingAreaImage.frame);
    UIView *viewBot = [[UIView alloc] initWithFrame:CGRectMake(imageX, CGRectGetMaxY(self.shootingAreaImage.frame), imageW, viewBotH)];
    viewBot.backgroundColor = RGBA(0, 0, 0, 0.2);
    [self.preview addSubview:viewBot];
    // 提示标语
    UILabel *prompt = [[UILabel alloc] initWithFrame:CGRectMake(imageX, CGRectGetMaxY(self.shootingAreaImage.frame) + 45, imageW, 20)];
    prompt.font = [UIFont systemFontOfSize:12];
    prompt.textColor = [UIColor whiteColor];
    prompt.text = @"将取景框对准车牌号点击拍摄";
    prompt.textAlignment = NSTextAlignmentCenter;
    [self.preview addSubview:prompt];
    // 拍照
    CGFloat shotCentetX = self.preview.centerX;
    CGFloat buttonW = self.preview.width / 3;
    CGFloat buttonH = 100;
    CGFloat shotX = shotCentetX - (buttonW / 2);
    CGFloat shotY = CGRectGetMaxY(prompt.frame) + 53;
    UIButton *shotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shotBtn.frame = CGRectMake(shotX, shotY, buttonW, buttonH);
    [shotBtn setImage:[UIImage imageNamed:@"scan_photograph"] forState:UIControlStateNormal];
    [shotBtn addTarget:self action:@selector(shotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.preview addSubview:shotBtn];
    // 操作按钮y值
    CGFloat operationY = self.preview.height - buttonH;
    // 相册
    CGFloat albumBtnX = 0;
    OperationBtn *albumBtn = [[OperationBtn alloc] initWithFrame:CGRectMake(albumBtnX, operationY, buttonW, buttonH)];
    albumBtn.operationImage.image = [UIImage imageNamed:@"scan_album"];
    albumBtn.operationText.text = @"相册";
    [albumBtn.operationButton addTarget:self action:@selector(albumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.preview addSubview:albumBtn];
    // 开灯
    CGFloat openX = CGRectGetMaxX(albumBtn.frame);
    self.openBtn = [[OperationBtn alloc] initWithFrame:CGRectMake(openX, operationY, buttonW, buttonH)];
    self.openBtn.operationImage.image = [UIImage imageNamed:@"scan_open_auto"];
    self.openBtn.operationText.text = @"自动";
    [self.openBtn.operationButton addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.preview addSubview:self.openBtn];
    // 输入
    CGFloat inputX = CGRectGetMaxX(self.openBtn.frame);
    OperationBtn *inputBtn = [[OperationBtn alloc] initWithFrame:CGRectMake(inputX, operationY, buttonW, buttonH)];
    inputBtn.operationImage.image = [UIImage imageNamed:@"scan_input_pln"];
    inputBtn.operationText.text = @"输入车牌号";
    [inputBtn.operationButton addTarget:self action:@selector(inputBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.preview addSubview:inputBtn];
}

// 拍摄
- (void)shotBtnAction:(UIButton *)button {
    // 闪光效果
    UIView *flashView = [[UIView alloc] initWithFrame:[[self preview] frame]];
    [flashView setBackgroundColor:[UIColor blackColor]];
    [[[self preview] window] addSubview:flashView];
    [UIView animateWithDuration:.4f animations:^{
        [flashView setAlpha:0.f];
    } completion:^(BOOL finished){
        [flashView removeFromSuperview];
    }];
    // 获取相机的连接
    AVCaptureConnection *connection = nil;
    for (AVCaptureConnection *tempConnection in self.imageOutput.connections) {
        for (AVCaptureInputPort *port in [tempConnection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                connection = tempConnection;
                break;
            }
        }
        if (connection) {
            break;
        }
    }
    // 保存图片
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [[UIImage alloc]initWithData:imageData];
        image = [self imageCompressForSize:image targetSize:self.preview.size];
        // 切割图片
        UIImage *simage = [self imageFromImage:image];
        [PhotographNetwork photographModifyImage:simage success:^(NSMutableDictionary *responseObject) {
            switch (self.photographViewType) {
                    /** 收银使用 */
                case CashierAssignment:{
                    CashierViewController *cashierVC = [[CashierViewController alloc] init];
                    cashierVC.plnPhoto = responseObject[@"result"];
                    [self.navigationController pushViewController:cashierVC animated:YES];
                    // 删除拍照界面
                    NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                    [navViews removeObject:self];
                    [self.navigationController setViewControllers:navViews animated:YES];
                    break;
                }
                    /** 自定义开卡使用 */
                case CustomOpenCardAssignment:{
                    if (_DistinguishSuccessBlock) {
                        _DistinguishSuccessBlock(responseObject[@"result"]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                    /** 保险查询使用 */
                case BenefitQuiryAssignment:{
                    if (_DistinguishSuccessBlock) {
                        _DistinguishSuccessBlock(responseObject[@"result"]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                default:
                    break;
            }
        }];
    }];
}
// 相册
- (void)albumBtnAction:(UIButton *)button {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma -mark 选择相册代理
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
        [PhotographNetwork photographModifyImage:image success:^(NSMutableDictionary *responseObject) {
            switch (self.photographViewType) {
                    /** 收银使用 */
                case CashierAssignment:{
                    CashierViewController *cashierVC = [[CashierViewController alloc] init];
                    cashierVC.plnPhoto = responseObject[@"result"];
                    [self.navigationController pushViewController:cashierVC animated:YES];
                    // 删除拍照界面
                    NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                    [navViews removeObject:self];
                    [self.navigationController setViewControllers:navViews animated:YES];
                    break;
                }
                    /** 自定义开卡使用 */
                case CustomOpenCardAssignment:{
                    if (_DistinguishSuccessBlock) {
                        _DistinguishSuccessBlock(responseObject[@"result"]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                    /** 保险查询使用 */
                case BenefitQuiryAssignment:{
                    if (_DistinguishSuccessBlock) {
                        _DistinguishSuccessBlock(responseObject[@"result"]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                default:
                    break;
            }
        }];
    } else {
        UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
        [PhotographNetwork photographModifyImage:image success:^(NSMutableDictionary *responseObject) {
            switch (self.photographViewType) {
                    /** 收银使用 */
                case CashierAssignment:{
                    CashierViewController *cashierVC = [[CashierViewController alloc] init];
                    cashierVC.plnPhoto = responseObject[@"result"];
                    [self.navigationController pushViewController:cashierVC animated:YES];
                    // 删除拍照界面
                    NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                    [navViews removeObject:self];
                    [self.navigationController setViewControllers:navViews animated:YES];
                    break;
                }
                    /** 自定义开卡使用 */
                case CustomOpenCardAssignment:{
                    if (_DistinguishSuccessBlock) {
                        _DistinguishSuccessBlock(responseObject[@"result"]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                    /** 保险查询使用 */
                case BenefitQuiryAssignment:{
                    if (_DistinguishSuccessBlock) {
                        _DistinguishSuccessBlock(responseObject[@"result"]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                default:
                    break;
            }
        }];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 开灯
- (void)openBtnAction:(UIButton *)button {
    AVCaptureDeviceInput *input = [self getVideoInput];
    [input.device lockForConfiguration:nil];
    if (input.device.flashMode == AVCaptureFlashModeAuto) {
        [input.device setFlashMode:AVCaptureFlashModeOff];
    } else if (input.device.flashMode == AVCaptureFlashModeOff) {
        [input.device setFlashMode:AVCaptureFlashModeOn];
    } else {
        [input.device setFlashMode:AVCaptureFlashModeAuto];
    }
    [input.device unlockForConfiguration];
    NSString *buttonTitle = [self getTitleByFlashlightMode:input.device.flashMode];
    self.openBtn.operationText.text = buttonTitle;
    UIImage *buttonImage = [self getImageByFlashlightMode:input.device.flashMode];
    self.openBtn.operationImage.image = buttonImage;
}
- (NSString *)getTitleByFlashlightMode:(AVCaptureFlashMode) flashMode {
    NSString *buttonTitle;
    if (flashMode == AVCaptureFlashModeAuto) {
        buttonTitle = @"自动";
    } else if (flashMode == AVCaptureFlashModeOff) {
        buttonTitle = @"关闭";
    } else {
        buttonTitle = @"打开";
    }
    return buttonTitle;
}

- (UIImage *)getImageByFlashlightMode:(AVCaptureFlashMode) flashMode {
    NSString *imageName;
    if (flashMode == AVCaptureFlashModeAuto) {
        imageName = @"scan_open_auto";
    } else if (flashMode == AVCaptureFlashModeOff) {
        imageName = @"scan_open_off";
    } else { // AVCaptureFlashModeOn
        imageName = @"scan_open_on";
    }
    UIImage *buttonImage = [UIImage imageNamed:imageName];
    return buttonImage;
}

// 获取相机 input
- (AVCaptureDeviceInput *)getVideoInput {
    for (AVCaptureDeviceInput *input in self.session.inputs) {
        if ([input.device hasMediaType:AVMediaTypeVideo]) {
            return input;
        }
    }
    return nil;
}
// 输入
- (void)inputBtnAction:(UIButton *)button {
    switch (self.photographViewType) {
            /** 收银使用 */
        case CashierAssignment:{
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            [self.navigationController pushViewController:cashierVC animated:YES];
            // 删除拍照界面
            NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [navViews removeObject:self];
            [self.navigationController setViewControllers:navViews animated:YES];
            break;
        }
            /** 自定义开卡使用 */
        case CustomOpenCardAssignment:{
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
            /** 保险查询使用 */
        case BenefitQuiryAssignment:{
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
}


/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageFromImage:(UIImage *)image {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, self.shootingAreaImage.frame);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}
// 等比例压缩
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
