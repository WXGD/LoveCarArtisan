//
//  TPAFNet.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TPAFNet.h"
#import "EncryptionMode.h"

@implementation TPAFNet

/** 获取当前网络状态 */
+ (void)networkState {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                // 位置网络
                NSLog(@"位置网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable: {
                // 无法联网
                NSLog(@"无法联网");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                // 手机自带网络
                NSLog(@"当前使用的是2G/3G/4G网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                // WIFI
                NSLog(@"当前在WIFI网络下");
            }
        }
    }];
}
#pragma mark - 监测数据上传或下载过程
/** GET请求，请求数据(监测下载进度) */
+ (void)GETDownload:(NSString *)URLString
         parameters:(id)parameters
constructingBodyWithBlock:(void (^)(NSProgress * _Nonnull uploadProgress))progress
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure {
    // 请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 请求超时的时间
    manager.requestSerializer.timeoutInterval = 30;
    // 解决：Request failed: unacceptable content-type: text/html
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 获取请求时间
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.f", timeInterval];
    // MD5签名
    NSString *sig = [EncryptionMode repuestUrlAddSigParameters:parameters timeStr:timeStr];
    NSString *URL = [NSString stringWithFormat:@"%@&sig=%@", URLString, sig];
    // 获取base64加密后的authorization
    NSString *base64 = [EncryptionMode repuestAuthorizationTimeStr:timeStr];
    // 设置请求头
    [manager.requestSerializer setValue:base64 forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:VERSION forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:BUILD forHTTPHeaderField:@"build"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"appId"];
    PDLog(@"%@", manager.requestSerializer.HTTPRequestHeaders);
    [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PDLog(@"CWFAPI%@", URL);
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
/** POST请求，请求数据(监测下载进度) */
+ (void)POSTDownload:(NSString *)URLString
          parameters:(id)parameters
constructingBodyWithBlock:(void (^)(NSProgress * _Nonnull uploadProgress))progress
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure {
    // 请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 请求超时的时间
    manager.requestSerializer.timeoutInterval = 30;
    // 解决：Request failed: unacceptable content-type: text/html
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 获取请求时间
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.f", timeInterval];
    // MD5签名
    NSString *sig = [EncryptionMode repuestUrlAddSigParameters:parameters timeStr:timeStr];
    NSString *URL = [NSString stringWithFormat:@"%@&sig=%@", URLString, sig];
    // 获取base64加密后的authorization
    NSString *base64 = [EncryptionMode repuestAuthorizationTimeStr:timeStr];
    // 设置请求头
    [manager.requestSerializer setValue:base64 forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:VERSION forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:BUILD forHTTPHeaderField:@"build"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"appId"];
    [manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PDLog(@"CWFAPI%@", URL);
        PDLog(@"HTTPHeader%@", manager.requestSerializer.HTTPRequestHeaders);
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
/** POST请求，上传数据(监测上传进度) */
+ (void)POSTUpload:(NSString *)URLString
        parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
          progress:(void (^)(NSProgress * _Nonnull uploadProgress))progress
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure {
    // 请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 请求超时的时间
    manager.requestSerializer.timeoutInterval = 30;
    // 解决：Request failed: unacceptable content-type: text/html
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    // 获取请求时间
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.f", timeInterval];
    // MD5签名
    NSString *sig = [EncryptionMode repuestUrlAddSigParameters:parameters timeStr:timeStr];
    NSString *URL = [NSString stringWithFormat:@"%@&sig=%@", URLString, sig];
    // 获取base64加密后的authorization
    NSString *base64 = [EncryptionMode repuestAuthorizationTimeStr:timeStr];
    // 设置请求头
    [manager.requestSerializer setValue:base64 forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:VERSION forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:BUILD forHTTPHeaderField:@"build"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"appId"];
    [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
#pragma mark - 不监测数据上传或下载过程
/** GET请求，请求数据(不监测下载进度) */
+ (void)GETDownload:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure {
    [TPAFNet GETDownload:URLString parameters:parameters constructingBodyWithBlock:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/** POST请求，请求数据(不监测下载进度) */
+ (void)POSTDownload:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure {
    [TPAFNet POSTDownload:URLString parameters:parameters constructingBodyWithBlock:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/** POST请求，上传数据(不监测上传进度) */
+ (void)POSTUpload:(NSString *)URLString
        parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure {
    [TPAFNet POSTUpload:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (block) {
            block(formData);
        }
    } progress:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end



