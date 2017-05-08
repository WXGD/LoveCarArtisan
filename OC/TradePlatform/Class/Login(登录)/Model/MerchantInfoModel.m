//
//  MerchantInfoModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MerchantInfoModel.h"
// 控制器
#import "TabbarViewController.h"
#import "NavigationViewController.h"
#import "LoginViewController.h"
// 推送设置别名
#import "JPUSHService.h"
// 单利
#import "OrderFilterHandle.h"
#import "OrderClassHandle.h"
#import "UsedCarBrandHandle.h"
#import "AllGoodsHandle.h"
#import "ServiceMasterHandle.h"
#import "ServiceCategoryHandle.h"

@implementation MerchantInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}


- (void)setStaff_user_id:(NSString *)staff_user_id  {
    _staff_user_id = staff_user_id;
    self.chioceCategoriesId = [staff_user_id integerValue];
}

- (void)setUser_name:(NSString *)user_name {
    _user_name = user_name;
    self.chioceCategoriesName = user_name;
}


/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    /** 服务商id */
    [encoder encodeObject:self.provider_id forKey:@"provider_id"];
    /** 服务商名称 */
    [encoder encodeObject:self.name forKey:@"name"];
    /** 当前登陆用户名 */
    [encoder encodeObject:self.user_name forKey:@"user_name"];
    /** 服务商地址 */
    [encoder encodeObject:self.address forKey:@"address"];
    /** 门店缩略图 */
    [encoder encodeObject:self.thumb_image_url forKey:@"thumb_image_url"];
    /** 服务商联系方式 */
    [encoder encodeObject:self.service_tel forKey:@"service_tel"];
    /** 微信公众号图片 */
    [encoder encodeObject:self.wxmp_qrcode forKey:@"wxmp_qrcode"];
    /** 服务商微信支付二维码 */
    [encoder encodeObject:self.wxpay_collection_qrcode forKey:@"wxpay_collection_qrcode"];
    /** 服务商支付宝支付二维码 */
    [encoder encodeObject:self.alipay_collection_qrcode forKey:@"alipay_collection_qrcode"];
    /** token */
    [encoder encodeObject:self.login_token forKey:@"login_token"];
    /** 登陆者id */
    [encoder encodeObject:self.staff_user_id forKey:@"staff_user_id"];
    /** 服务商注册时间 */
    [encoder encodeObject:self.create_time forKey:@"create_time"];
    /** 过期时间 */
    [encoder encodeObject:self.overdue_timer forKey:@"overdue_timer"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        /** 服务商id */
        self.provider_id = [decoder decodeObjectForKey:@"provider_id"];
        /** 服务商名称 */
        self.name = [decoder decodeObjectForKey:@"name"];
        /** 当前登陆用户名 */
        self.user_name = [decoder decodeObjectForKey:@"user_name"];
        /** 服务商地址 */
        self.address = [decoder decodeObjectForKey:@"address"];
        /** 门店缩略图 */
        self.thumb_image_url = [decoder decodeObjectForKey:@"thumb_image_url"];
        /** 服务商联系方式 */
        self.service_tel = [decoder decodeObjectForKey:@"service_tel"];
        /** 微信公众号图片 */
        self.wxmp_qrcode = [decoder decodeObjectForKey:@"wxmp_qrcode"];
        /** 服务商微信支付二维码 */
        self.wxpay_collection_qrcode = [decoder decodeObjectForKey:@"wxpay_collection_qrcode"];
        /** 服务商支付宝支付二维码 */
        self.alipay_collection_qrcode = [decoder decodeObjectForKey:@"alipay_collection_qrcode"];
        /** token */
        self.login_token = [decoder decodeObjectForKey:@"login_token"];
        /** 登陆者id */
        self.staff_user_id = [decoder decodeObjectForKey:@"staff_user_id"];
        /** 服务商注册时间 */
        self.create_time = [decoder decodeObjectForKey:@"create_time"];
        /** 过期时间 */
        self.overdue_timer = [decoder decodeObjectForKey:@"overdue_timer"];
    }
    return self;
}

/** 获取验证码 */
+ (void)requestVerificationParame:(NSMutableDictionary *)parame success:(void(^)())success {
    /*/index.php?c=auth&a=sendcode&v=1
     mobile 	string 	是 	登录手机号   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"auth", @"sendcode", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在获取验证码..." falseDate:@"login" parentController:nil success:^(id responseObject) {
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        PDLog(@"sigln%@", error);
        [MBProgressHUD showError:@"请求失败"];
    }];
}
/** 登陆 */
+ (void)loginParame:(NSMutableDictionary *)parame viewController:(UIViewController *)viewController success:(void(^)())success {
    // 记录商户code
    [[NSUserDefaults standardUserDefaults] setObject:parame[@"login_name"] forKey:@"code"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    /*/index.php?c=auth&a=login&v=1
     login_name 	string 	是 	用户名或手机号
     smscode 	string 	否 	验证码登录必传，密码登录不传
     login_password 	string 	否 	验证码登录不传，密码登录必传
     os 	int 	是 	登录设备 0：未知，1：ios，2：Android
     os_version 	string 	是 	app操作系统版本号
     device_id 	string 	是 	设备id  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"auth", @"login", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    parameters[@"os"] = @"1"; // 0：未知1：ios 2：Android
    parameters[@"os_version"] = [[UIDevice currentDevice] systemVersion]; // 手机系统版本号
    parameters[@"device_id"] = [[UIDevice currentDevice].identifierForVendor UUIDString]; // 手机设备id
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在登录..." falseDate:@"login" parentController:nil success:^(id responseObject) {
        PDLog(@"sigln%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            if (success) {
                success();
            }
            // 获取服务商信息模型
            MerchantInfoModel *userInfo = [MerchantInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 设置推送标签
            [JPUSHService setTags:nil alias:userInfo.staff_user_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                PDLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
            }];
            // 获得当前时间
            NSDate *now = [NSDate date];
            // 过期的秒数
            NSTimeInterval expires = 2592000;
            // 获得过期时间
            NSDate *expiresTime = [now dateByAddingTimeInterval:expires];
            NSTimeInterval overdue_timer = [expiresTime timeIntervalSince1970] * 1000;
            userInfo.overdue_timer = [NSString stringWithFormat:@"%f", overdue_timer];
            // 储存商家信息
            [NSKeyedArchiver archiveRootObject:userInfo toFile:AccountPath];
            // 跳转到首页
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            keyWindow.rootViewController = [[TabbarViewController alloc] init];
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        PDLog(@"sigln%@", error);
        [MBProgressHUD showError:@"请求失败"];
    }];
    
}





/** 刷新接口 */
+ (void)updata:(UIViewController *)oldViewContrller {
    // 获取用户数据
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    // 判断是否登陆
    if (merchantInfo.provider_id) {
        // 获得当前时间
        NSTimeInterval nowTimer = [[NSDate date] timeIntervalSince1970] * 1000;
        // 本地判断是否过期
        if ([merchantInfo.overdue_timer floatValue] > nowTimer) {
            /*/index.php?c=auth&a=check_token&v=1
             staff_user_id 	int 	是 	登录者id(登陆时返回的user_id)
             os 	int 	是 	操作系统 0：未知1：ios 2：Android
             os_version 	string 	是 	操作系统版本
             device_id 	string 	是 	设备id
             login_token 	string 	是 	token   */
            NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"auth", @"check_token", APIEdition];
            // 拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"login_token"] = merchantInfo.login_token; // 老token
            params[@"staff_user_id"] = merchantInfo.staff_user_id; // 用户id
            params[@"os"] = @"1"; // 0：未知1：ios 2：Android
            params[@"os_version"] = CurrentSystemVersion; // 操作系统版本
            params[@"device_id"] = UDID; // 设备id
            // 发送请求
            [TPNetRequest POST:URL parameters:params ProgressHUD:nil falseDate:@"error" parentController:nil success:^(id responseObject) {
                PDLog(@"刷新接口%@", responseObject);
                PDLog(@"params%@", params);
                PDLog(@"CWFAPI%@", URL);
                if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
                    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
                    merchantInfo.login_token = responseObject[@"data"][@"login_token"];
                    // 获得当前时间
                    NSDate *nowTimer = [NSDate date];
                    // 过期的秒数
                    NSTimeInterval expires = 2592000;
                    // 获得过期时间
                    NSDate *expiresTime = [nowTimer dateByAddingTimeInterval:expires];
                    NSTimeInterval overdue_timer = [expiresTime timeIntervalSince1970] * 1000;
                    merchantInfo.overdue_timer = [NSString stringWithFormat:@"%f", overdue_timer];
                    [NSKeyedArchiver archiveRootObject:merchantInfo toFile:AccountPath];
                }else if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"5"]) {
                    // 储存一个空的用户信息模型，清空用户信息模型
                    MerchantInfoModel *merchantInfo = [[MerchantInfoModel alloc] init];
                    // 储存商家信息
                    [NSKeyedArchiver archiveRootObject:merchantInfo toFile:AccountPath];
                    [MBProgressHUD showError:@"登录验证失败，请重新登录"];
                    // 销毁单利
                    [OrderFilterHandle destroyHandle];
                    [OrderClassHandle destroyHandle];
                    [UsedCarBrandHandle destroyHandle];
                    [AllGoodsHandle destroyHandle];
                    [ServiceMasterHandle destroyHandle];
                    [ServiceCategoryHandle destroyHandle];
                    // 弹出登陆页面
                    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                    keyWindow.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
                }else {
//                    [MBProgressHUD showError:responseObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showError:@"请求失败"];
                PDLog(@"%@", error);
            }];
        }else {
            // 储存一个空的用户信息模型，清空用户信息模型
            MerchantInfoModel *merchantInfo = [[MerchantInfoModel alloc] init];
            // 储存商家信息
            [NSKeyedArchiver archiveRootObject:merchantInfo toFile:AccountPath];
            [MBProgressHUD showError:@"登录过期，请重新登录"];
            // 销毁单利
            [OrderFilterHandle destroyHandle];
            [OrderClassHandle destroyHandle];
            [UsedCarBrandHandle destroyHandle];
            [AllGoodsHandle destroyHandle];
            [ServiceMasterHandle destroyHandle];
            [ServiceCategoryHandle destroyHandle];
            // 弹出登陆页面
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            keyWindow.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        }
    }
}

/** 请求服务师傅 */
+ (void)requestServiceMasterParame:(NSMutableDictionary *)parame success:(void(^)(NSMutableArray *serviceMasterArray))success {
    /*/index.php?c=staff_user&a=list&v=1
     provider_id 	int 	是 	服务商id  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"staff_user", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在加载数据..." falseDate:@"serviceMaster" parentController:nil success:^(id responseObject) {
        PDLog(@"服务师傅%@", responseObject);
        PDLog(@"服务师傅%@", parame);

        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSMutableArray *serviceMasterArray = [MerchantInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (success) {
                success(serviceMasterArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        PDLog(@"sigln%@", error);
        [MBProgressHUD showError:@"请求失败"];
    }];
}




@end
