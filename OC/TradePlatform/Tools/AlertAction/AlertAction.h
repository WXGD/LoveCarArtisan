//
//  AlertAction.h
//  LoveCarEHome
//
//  Created by 爱车e家 on 16/4/11.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CertificatePhotoTipsView;

@interface AlertAction : NSObject

/** StyleAlert只有单个按钮 */
+ (void)determineStay:(UIViewController *)viewController title:(NSString *)title admitStr:(NSString *)admitStr message:(NSString *)message determineBlock:(void(^)())determineBlock;
/** StyleAlert取消确定，确定在左，带取消回调 */
+ (void)determineStayLeft:(UIViewController *)viewController title:(NSString *)title admit:(NSString *)admit noadmit:(NSString *)noadmit message:(NSString *)message admitBlock:(void(^)())admitBlock noadmitBlock:(void(^)())noadmitBlock;
/** StyleAlert确定取消，确定在右 */
+ (void)determineStayRight:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message determineBlock:(void(^)())determineBlock;
/** StyleAlert取消确定，确定在左 */
+ (void)determineStayLeft:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message determineBlock:(void(^)())determineBlock;
/** StyleActionSheet相机（Camera）相册（album） 的调用*/
+ (UIAlertController *)callCameraAlertActionStyleActionSheetBtn:(UIButton *)btn ViewController:(UIViewController *)viewController CameraBlock:(void(^)(UIImagePickerController *picker))cameraBlock albumBlock:(void(^)(UIImagePickerController *picker))albumBlock cancelBlock:(void(^)())cancelBlock;
/** 上方带照片 */
+ (UIAlertController *)callCameraAlertActionStyleActionSheetBtn:(UIButton *)btn ViewController:(UIViewController *)viewController certificatePhotoTips:(CertificatePhotoTipsView *)certificatePhotoTips CameraBlock:(void(^)(UIImagePickerController *picker))cameraBlock albumBlock:(void(^)(UIImagePickerController *picker))albumBlock;
/** 获取验证码 */
+ (UIAlertController *)twoActionSheetWithBtn:(UIButton *)btn ViewController:(UIViewController *)viewController shortMessageBlock:(void(^)())shortMessageBlock voiceBlock:(void(^)())voiceBlock;

@end
