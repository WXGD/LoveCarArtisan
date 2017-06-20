//
//  AddCarNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCarNetwork : NSObject

/** "provider_user_id":"已存在手机号的用户id",
 "exist_user":"手机号存在标识 1:手机号存在"  */

/** 已存在手机号的用户id */
@property (copy, nonatomic) NSString *provider_user_id;
/** 手机号存在标识 */
@property (assign, nonatomic) NSInteger exist_user;

/** 添加用户车辆 */
+ (void)addUserCarParams:(NSMutableDictionary *)params success:(void(^)(AddCarNetwork *addCarNetwork))success;

@end
