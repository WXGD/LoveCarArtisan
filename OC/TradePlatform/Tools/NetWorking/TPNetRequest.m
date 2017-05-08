//
//  TPNetRequest.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TPNetRequest.h"

@implementation TPNetRequest

/** 不带token的GET请求 */
+ (void)GET:(NSString *)URL
 parameters:(id)parameters
ProgressHUD:(NSString *)progressHUD
  falseDate:(NSString *)falseDate
parentController:(UIViewController *)parentController
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure {
    
    // 获取商户code
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
    if ([userName isEqualToString:@"18712345678"]) {
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUD];
            //获取到假数据
            NSString *path = [[NSBundle mainBundle] pathForResource:falseDate ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (success) {
                success(dictioary);
            }
        });
    }else {
        // 加载框
        if (progressHUD && progressHUD.length != 0) {
            [MBProgressHUD showMessage:progressHUD];
        }
        [TPAFNet GETDownload:URL parameters:parameters success:^(id responseObject) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            if (success) {
                success(responseObject);
            }
        } failure:^(NSError *error) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            if (failure) {
                failure(error);
            }
        }];
    }
}

/** 不带token的POST请求 */
+ (void)POST:(NSString *)URL
  parameters:(id)parameters
 ProgressHUD:(NSString *)progressHUD
   falseDate:(NSString *)falseDate
parentController:(UIViewController *)parentController
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure {
    
    // 获取商户code
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
    if ([userName isEqualToString:@"18712345678"]) {
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUD];
            //获取到假数据
            NSString *path = [[NSBundle mainBundle] pathForResource:falseDate ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (success) {
                success(dictioary);
            }
        });
    }else {
        // 加载框
        if (progressHUD && progressHUD.length != 0) {
            [MBProgressHUD showMessage:progressHUD];
        }
        [TPAFNet POSTDownload:URL parameters:parameters success:^(id responseObject) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            if (success) {
                success(responseObject);
            }
        } failure:^(NSError *error) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            if (failure) {
                failure(error);
            }
        }];
    }
}

/** 带token的POST请求 */
+ (void)tokenGET:(NSString *)URL
      parameters:(id)parameters
     ProgressHUD:(NSString *)progressHUD
       falseDate:(NSString *)falseDate
parentController:(UIViewController *)parentController
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure {
    
    // 获取商户code
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
    if ([userName isEqualToString:@"18712345678"]) {
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUD];
            //获取到假数据
            NSString *path = [[NSBundle mainBundle] pathForResource:falseDate ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (success) {
                success(dictioary);
            }
        });
    }else {
        // 加载框
        if (progressHUD && progressHUD.length != 0) {
            [MBProgressHUD showMessage:progressHUD];
        }
        // 获取用户信息UserInfo
        //        UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoRoute];
        // 获取token
        //        NSString *token = [NetParameter tokenGetsThe:parameters ackey:userInfo.ackey];
        // 拼接请求参数
        NSMutableDictionary *params = parameters;
        //        params[@"token"] = token;
        [TPAFNet GETDownload:URL parameters:params success:^(id responseObject) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            // 判断是否过期
            if ([responseObject[@"code"] isEqualToString:@"ackey_expire"] || [responseObject[@"code"] isEqualToString:@"tokenrerr1"] || [responseObject[@"code"] isEqualToString:@"tokenerr"]) {
                [MBProgressHUD showSuccess:@"登录过期，请重新登录"];
            }else {
                if (success) {
                    success(responseObject);
                }
            }
        } failure:^(NSError *error) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            if (failure) {
                failure(error);
            }
        }];
    }
}


/** 带token的POST请求 */
+ (void)tokenPOST:(NSString *)URL
       parameters:(id)parameters
      ProgressHUD:(NSString *)progressHUD
        falseDate:(NSString *)falseDate
 parentController:(UIViewController *)parentController
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure {
    
    
    // 获取商户code
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
    if ([userName isEqualToString:@"18712345678"]) {
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUD];
            //获取到假数据
            NSString *path = [[NSBundle mainBundle] pathForResource:falseDate ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (success) {
                success(dictioary);
            }
        });
    }else {
        // 加载框
        if (progressHUD && progressHUD.length != 0) {
            [MBProgressHUD showMessage:progressHUD];
        }
        // 获取用户信息UserInfo
        //        UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoRoute];
        // 获取token
        //        NSString *token = [NetParameter tokenGetsThe:parameters ackey:userInfo.ackey];
        // 拼接请求参数
        NSMutableDictionary *params = parameters;
        //        params[@"token"] = token;
        [TPAFNet POSTDownload:URL parameters:params success:^(id responseObject) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            // 判断是否过期
            if ([responseObject[@"code"] isEqualToString:@"ackey_expire"] || [responseObject[@"code"] isEqualToString:@"tokenrerr1"] || [responseObject[@"code"] isEqualToString:@"tokenerr"]) {
                [MBProgressHUD showSuccess:@"登录过期，请重新登录"];
            }else {
                if (success) {
                    success(responseObject);
                }
            }
        } failure:^(NSError *error) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            if (failure) {
                failure(error);
            }
        }];
    }
}

/** 带token的POST请求，带图片上传 */
+ (void)tokenPOST:(NSString *)URL
       parameters:(id)parameters
      ProgressHUD:(NSString *)progressHUD
        falseDate:(NSString *)falseDate
 parentController:(UIViewController *)parentController
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure {
    
    
    // 获取商户code
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
    if ([userName isEqualToString:@"18712345678"]) {
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUD];
            //获取到假数据
            NSString *path = [[NSBundle mainBundle] pathForResource:falseDate ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSDictionary *dictioary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (success) {
                success(dictioary);
            }
        });
    }else {
        // 加载框
        if (progressHUD && progressHUD.length != 0) {
            [MBProgressHUD showMessage:progressHUD];
        }
        // 获取用户信息UserInfo
//                UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoRoute];
        // 获取token
        //        NSString *token = [NetParameter tokenGetsThe:parameters ackey:userInfo.ackey];
        // 拼接请求参数
        NSMutableDictionary *params = parameters;
        //        params[@"token"] = token;
        [TPAFNet POSTUpload:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (block) {
                block(formData);
            }
        } success:^(id responseObject) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            if (success) {
                success(responseObject);
            }
        } failure:^(NSError *error) {
            if (progressHUD && progressHUD.length != 0) {
                [MBProgressHUD hideHUD];
            }
            if (failure) {
                failure(error);
            }
        }];
    }
}


@end



