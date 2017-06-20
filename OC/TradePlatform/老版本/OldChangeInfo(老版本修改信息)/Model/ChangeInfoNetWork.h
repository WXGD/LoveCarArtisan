//
//  ChangeInfoNetWork.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeInfoNetWork : NSObject

/** "provider_user_id":"已存在手机号的用户id",
 "exist_user":"手机号存在标识 1:手机号存在"  */

/** 已存在手机号的用户id */
@property (copy, nonatomic) NSString *provider_user_id;
/** 手机号存在标识 */
@property (assign, nonatomic) NSInteger exist_user;


/** 修改用户信息 */
+ (void)editUserInfoParams:(NSMutableDictionary *)params success:(void(^)(ChangeInfoNetWork *changeUserInfo))success;
/** 修改当前登陆用户密码 */
+ (void)editAccountPasswordParams:(NSMutableDictionary *)params success:(void(^)())success;
/** 修改商户信息 */
+ (void)editMerchantInfoParams:(NSMutableDictionary *)params success:(void(^)())success;
/** 修改用户车辆信息 */
+ (void)editUserCarInfoParams:(NSMutableDictionary *)params success:(void(^)(ChangeInfoNetWork *changeUserCar))success;

@end
