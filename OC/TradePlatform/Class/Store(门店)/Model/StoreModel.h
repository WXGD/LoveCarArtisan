//
//  StoreModel.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

/**
 {
 "provider_id": 3,
 "name": ""  #服务商名称,
 "address": ""  #服务商地址,
 "thumb_image_url": ""  #服务商门店缩略图,
 "image_url": ""  #服务商门店原图,
 "service_tel": ""  #客服电话,
 "service_mobile": ""  #短信通知电话,
 "wxmp_qrcode": ""  #公众号二维码地址,
 "business_start_time": "00:00"  #营业开始时间,
 "business_end_time": "00:00"  #营业结束时间
 }
 */
#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *service_mobile;

@property (nonatomic, copy) NSString *thumb_image_url;

@property (nonatomic, assign) NSInteger provider_id;

@property (nonatomic, copy) NSString *image_url;

@property (nonatomic, copy) NSString *wxmp_qrcode;

@property (nonatomic, copy) NSString *business_start_time;

@property (nonatomic, copy) NSString *service_tel;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *business_end_time;

- (void)storeRefreshRequestData:(UITableView *)tableView
                         params:(NSMutableDictionary *)params
                 viewController:(UIViewController *)viewController
                        success:(void (^)(NSMutableArray *orderArray))success;
- (void)storeLoadRequestData:(UITableView *)tableView
                      params:(NSMutableDictionary *)params
              viewController:(UIViewController *)viewController
                     success:(void (^)(NSMutableArray *orderArray))success;
@end
