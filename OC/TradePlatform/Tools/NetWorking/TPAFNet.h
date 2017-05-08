//
//  TPAFNet.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface TPAFNet : NSObject

/**
 * 获取当前网络状态
 */
+ (void)networkState;
#pragma mark - 监测数据上传或下载过程
/**
 * GET请求，请求数据 (监测下载进度)
 *
 * @paramet URLString:请求接口
 * @paramet parameters:请求参数
 * @paramet constructingBodyWithBlock:下载进度
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)GETDownload:(NSString *)URLString
         parameters:(id)parameters
constructingBodyWithBlock:(void (^)(NSProgress * uploadProgress))progress
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;
/**
 * POST请求，请求数据 (监测下载进度)
 *
 * @paramet URLString:请求接口
 * @paramet parameters:请求参数
 * @paramet constructingBodyWithBlock:下载进度
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)POSTDownload:(NSString *)URLString
          parameters:(id)parameters
constructingBodyWithBlock:(void (^)(NSProgress * uploadProgress))progress
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure;
/**
 * POST请求，上传数据 (监测上传进度)
 *
 * @paramet URLString:请求接口
 * @paramet parameters:请求参数
 * @paramet constructingBodyWithBlock:上传文件内容
 * @paramet progress:下载进度
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)POSTUpload:(NSString *)URLString
        parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
          progress:(void (^)(NSProgress * uploadProgress))progress
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;
#pragma mark - 不监测数据上传或下载过程
/**
 * GET请求，请求数据 (不监测下载进度)
 *
 * @paramet URLString:请求接口
 * @paramet parameters:请求参数
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)GETDownload:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;
/**
 * POST请求，请求数据 (不监测下载进度)
 *
 * @paramet URLString:请求接口
 * @paramet parameters:请求参数
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)POSTDownload:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure;
/**
 * POST请求，上传数据 (不监测上传进度)
 *
 * @paramet URLString:请求接口
 * @paramet parameters:请求参数
 * @paramet constructingBodyWithBlock:上传文件内容
 * @paramet success:请求成功
 * @paramet failure:请求失败
 */
+ (void)POSTUpload:(NSString *)URLString
        parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;


@end
