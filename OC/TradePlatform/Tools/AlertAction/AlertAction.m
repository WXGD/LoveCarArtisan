//
//  AlertAction.m
//  LoveCarEHome
//
//  Created by 爱车e家 on 16/4/11.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import "AlertAction.h"
#import "CertificatePhotoTipsView.h"

@implementation AlertAction

/** StyleAlert确定取消 */
+ (void)determineStayLeft:(UIViewController *)viewController title:(NSString *)title admit:(NSString *)admit noadmit:(NSString *)noadmit message:(NSString *)message admitBlock:(void(^)())admitBlock noadmitBlock:(void(^)())noadmitBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Admit = [UIAlertAction actionWithTitle:admit style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (admitBlock) {
            admitBlock();
        }
    }];
    UIAlertAction *noAdmit = [UIAlertAction actionWithTitle:noadmit style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (noadmitBlock) {
            noadmitBlock();
        }
    }];
    [alertController addAction:Admit];
    [alertController addAction:noAdmit];
    [viewController presentViewController:alertController animated:YES completion:nil];
}


/** StyleAlert确定取消 */
+ (void)determineStayLeft:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message determineBlock:(void(^)())determineBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Admit = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (determineBlock) {
            determineBlock();
        }
    }];
    UIAlertAction *noAdmit = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:Admit];
    [alertController addAction:noAdmit];
    [viewController presentViewController:alertController animated:YES completion:nil];
}
/** StyleAlert取消确定 */
+ (void)determineStayRight:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message determineBlock:(void(^)())determineBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAdmit = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *Admit = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (determineBlock) {
            determineBlock();
        }
    }];
    [alertController addAction:noAdmit];
    [alertController addAction:Admit];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

/** StyleAlert只有单个按钮 */
+ (void)determineStay:(UIViewController *)viewController title:(NSString *)title admitStr:(NSString *)admitStr message:(NSString *)message determineBlock:(void(^)())determineBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *admit = [UIAlertAction actionWithTitle:admitStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (determineBlock) {
            determineBlock();
        }
    }];
    [alertController addAction:admit];
    [viewController presentViewController:alertController animated:YES completion:nil];
}



/** StyleActionSheet相机（Camera）相册（album） 的调用*/
+ (UIAlertController *)callCameraAlertActionStyleActionSheetBtn:(UIButton *)btn ViewController:(UIViewController *)viewController CameraBlock:(void(^)(UIImagePickerController *picker))cameraBlock albumBlock:(void(^)(UIImagePickerController *picker))albumBlock cancelBlock:(void(^)())cancelBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *Default = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 从图片库挑选图片
        // 创建UIImagePickerController对象
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        // 判断当前设备此种类型是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            // 当前设备有相机
            picker.sourceType = UIImagePickerControllerSourceTypeCamera; // 调用相机
        } else {
            // 当前设备没有相机
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        // 设置挑选出的图片是否可编辑
        picker.allowsEditing = NO;
        // 模态出图片库
        [viewController.navigationController presentViewController:picker animated:YES completion:^{
            
        }];
        if (albumBlock) {
            albumBlock(picker);
        }
    }];
    UIAlertAction *selected = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 创建UIImagePickerController对象
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置挑选出的图片是否可编辑
        picker.allowsEditing = NO;
        // 模态出图片库
        [viewController.navigationController presentViewController:picker animated:YES completion:^{
            
        }];
        if (cameraBlock) {
            cameraBlock(picker);
        }
    }];
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    [alertController addAction:Default];
    [alertController addAction:selected];
    [alertController addAction:destructive];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
        popPresenter.sourceView = btn;
        popPresenter.sourceRect = btn.bounds;
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    return alertController;
}


/** 上方带照片 */
+ (UIAlertController *)callCameraAlertActionStyleActionSheetBtn:(UIButton *)btn ViewController:(UIViewController *)viewController certificatePhotoTips:(CertificatePhotoTipsView *)certificatePhotoTips CameraBlock:(void(^)(UIImagePickerController *picker))cameraBlock albumBlock:(void(^)(UIImagePickerController *picker))albumBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *Default = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 行驶证照片消失
        [certificatePhotoTips dismiss];

        // 创建UIImagePickerController对象
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置代理
//        picker.delegate = self;
        // 设置挑选出的图片是否可编辑
        picker.allowsEditing = NO;
        if (albumBlock) {
            albumBlock(picker);
        }
        // 模态出图片库
        [viewController.navigationController presentViewController:picker animated:YES completion:^{
        
        }];
    }];
    UIAlertAction *selected = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        // 行驶证照片消失
        [certificatePhotoTips dismiss];
        //        NSLog(@"--- 从图片库挑选图片");
        // 创建UIImagePickerController对象
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        // 判断当前设备此种类型是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //            NSLog(@"--- 当前设备有相机");
            picker.sourceType = UIImagePickerControllerSourceTypeCamera; // 调用相机
        } else {
            //            NSLog(@"当前设备没有相机");
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        // 设置代理
//        picker.delegate = self;
        // 设置挑选出的图片是否可编辑
        picker.allowsEditing = NO;
        // 模态出图片库
        [viewController.navigationController presentViewController:picker animated:YES completion:^{
        
        }];
        if (cameraBlock) {
            cameraBlock(picker);
        }
    }];
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        // 行驶证照片消失
        [certificatePhotoTips dismiss];
    }];
    [alertController addAction:Default];
    [alertController addAction:selected];
    [alertController addAction:destructive];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
        popPresenter.sourceView = btn;
        popPresenter.sourceRect = btn.bounds;
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    return alertController;
}


/** 获取验证码 */
+ (UIAlertController *)twoActionSheetWithBtn:(UIButton *)btn ViewController:(UIViewController *)viewController shortMessageBlock:(void(^)())shortMessageBlock voiceBlock:(void(^)())voiceBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *shortMessage = [UIAlertAction actionWithTitle:@"短信验证码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (shortMessageBlock) {
            shortMessageBlock();
        }
    }];
    UIAlertAction *voice = [UIAlertAction actionWithTitle:@"语音验证码" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (voiceBlock) {
            voiceBlock();
        }
    }];
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:shortMessage];
    [alertController addAction:voice];
    [alertController addAction:destructive];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
        popPresenter.sourceView = btn;
        popPresenter.sourceRect = btn.bounds;
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    return alertController;
}

@end
