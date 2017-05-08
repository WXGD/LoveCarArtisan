//
//  BannerModel.h
//  TradePlatform
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject

/** "image_url": "http://image.cheweifang.cn/banner/1.jpg"  #展示的图片地址,
 "need_login": 1  #是否需要登录 1-需要 0-不需要,
 "redirect_type": 1  #转跳类型：1：web 2：native,
 "redirect_data": "banner/2.jpg"  #若redirect_type=web，则data=url值；若redirect=app,则data=商家id，表示跳转到保养或洗车商家界面,
 "available_share": 0  #是否可分享 0:不可分享 1：可分享,
 "share_url": ""  #分享链接  */


/** 展示的图片地址 */
@property (copy, nonatomic) NSString *image_url;
/** 是否需要登录 1-需要 0-不需要 */
@property (assign, nonatomic) NSInteger need_login;
/** 转跳类型：1：web 2：native */
@property (assign, nonatomic) NSInteger redirect_type;
/** 若redirect_type=web，则data=url值；若redirect=app,则data=商家id，表示跳转到保养或洗车商家界面 */
@property (copy, nonatomic) NSString *redirect_data;
/** 是否可分享 0:不可分享 1：可分享, */
@property (assign, nonatomic) NSInteger available_share;
/** 分享链接 */
@property (copy, nonatomic) NSString *share_url;

// 请求首页轮播图接口
+ (void)requestBannerDataParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *bannerArray))success;

@end
