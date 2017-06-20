//
//  MerchantInfoModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AlertListModel.h"

@interface MerchantInfoModel : AlertListModel

/*  "provider_id": 1  #服务商id,
 "name": "测试商家"  #服务商名称,
 "address": "郑州蓝宝万"  #服务商地址,
 "thumb_image_url": "http://image.cheweifang.cn/"  #门店缩略图,
 "service_tel": "13021960147"  #服务商联系方式,
 "wxmp_qrcode": ""  #微信公众号图片,
 "wxpay_collection_qrcode": ""  #服务商微信支付二维码,
 "alipay_collection_qrcode": ""  #服务商支付宝支付二维码,
 "login_token": "fd986f645eaac22ba512a69e4695c30d"  #token,
 "staff_user_id": 1  #登陆者id,
 "user_name": "张三"  #登录者的名称,
 "create_time": "2017-02-21 11:13:45"  #服务商注册时间
 "is_initial_provider": "1-总店 0-分店"  */

/** 服务商id */
@property (copy, nonatomic) NSString *provider_id;
/** 服务商名称 */
@property (copy, nonatomic) NSString *name;
/** 当前登陆用户名 */
@property (copy, nonatomic) NSString *user_name;
/** 服务商地址 */
@property (copy, nonatomic) NSString *address;
/** 门店缩略图 */
@property (copy, nonatomic) NSString *thumb_image_url;
/** 服务商联系方式 */
@property (copy, nonatomic) NSString *service_tel;
/** 登陆人联系方式 */
@property (copy, nonatomic) NSString *login_mobile;
/** 微信公众号图片 */
@property (copy, nonatomic) NSString *wxmp_qrcode;
/** 服务商微信支付二维码 */
@property (copy, nonatomic) NSString *wxpay_collection_qrcode;
/** 服务商支付宝支付二维码 */
@property (copy, nonatomic) NSString *alipay_collection_qrcode;
/** token */
@property (copy, nonatomic) NSString *login_token;
/** 登陆者id */
@property (copy, nonatomic) NSString *staff_user_id;
/** 服务商注册时间 */
@property (copy, nonatomic) NSString *create_time;
/** 1-总店 0-分店 */
@property (assign, nonatomic) NSInteger is_initial_provider;
/********************* 自加参数 **********************/
/** 登录过期时间 */
@property (copy, nonatomic) NSString *overdue_timer;
/** 标记是否选中 */
@property (nonatomic, assign) BOOL checkMark;


/** 获取验证码 */
+ (void)requestVerificationParame:(NSMutableDictionary *)parame success:(void(^)())success;
/** 登陆 */
+ (void)loginParame:(NSMutableDictionary *)parame viewController:(UIViewController *)viewController success:(void(^)())success;
/** 刷新接口 */
+ (void)updata:(UIViewController *)oldViewContrller;

/** 请求服务师傅 */
+ (void)requestServiceMasterParame:(NSMutableDictionary *)parame success:(void(^)(NSMutableArray *serviceMasterArray))success;

@end
