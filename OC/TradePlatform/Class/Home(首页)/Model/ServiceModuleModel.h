//
//  ServiceModuleModel.h
//  TradePlatform
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModuleModel : NSObject

/** 模块名称 */
@property (copy, nonatomic) NSString *name;
/** 模块链接 */
@property (copy, nonatomic) NSString *nav_url;
/** 模块图片链接 */
@property (copy, nonatomic) NSString *image_url;
/** webview链接 */
@property (copy, nonatomic) NSString *web_url;
/** nav_title */
@property (copy, nonatomic) NSString *nav_title;
/** 判断是否需要拼接登陆者ID (0:不需要，1:需要)*/
@property (copy, nonatomic) NSString *web_url_id;


/** 请求服务模块 */
+ (void)requestServiceModuleSuccess:(void(^)(NSMutableArray *moduleArray))success;

@end
