//
//  TPNetRequest.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAFNet.h"

@interface TPNetRequest : NSObject


/**
 * 不带token的GET请求
 *
 * @paramet URL:请求接口
 * @paramet parameters:请求参数
 * @paramet progressHUD:加载框显示内容
 * @paramet falseDate:本地数据
 * @paramet parentController:请求控制器
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)GET:(NSString *)URL
 parameters:(id)parameters
ProgressHUD:(NSString *)progressHUD
  falseDate:(NSString *)falseDate
parentController:(UIViewController *)parentController
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 * 不带token的POST请求
 *
 * @paramet URL:请求接口
 * @paramet parameters:请求参数
 * @paramet progressHUD:加载框显示内容
 * @paramet falseDate:本地数据
 * @paramet parentController:请求控制器
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)POST:(NSString *)URL
  parameters:(id)parameters
 ProgressHUD:(NSString *)progressHUD
   falseDate:(NSString *)falseDate
parentController:(UIViewController *)parentController
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

/**
 * 带token的POST请求
 *
 * @paramet URL:请求接口
 * @paramet parameters:请求参数
 * @paramet progressHUD:加载框显示内容
 * @paramet falseDate:本地数据
 * @paramet parentController:请求控制器
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)tokenPOST:(NSString *)URL
       parameters:(id)parameters
      ProgressHUD:(NSString *)progressHUD
        falseDate:(NSString *)falseDate
 parentController:(UIViewController *)parentController
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;

/**
 * 带token的POST请求，带图片上传
 *
 * @paramet URL:请求接口
 * @paramet parameters:请求参数
 * @paramet progressHUD:加载框显示内容
 * @paramet falseDate:本地数据
 * @paramet parentController:请求控制器
 * @paramet block:上传内容
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)tokenPOST:(NSString *)URL
       parameters:(id)parameters
      ProgressHUD:(NSString *)progressHUD
        falseDate:(NSString *)falseDate
 parentController:(UIViewController *)parentController
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;


@end

