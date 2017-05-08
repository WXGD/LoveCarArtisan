//
//  AddUserNetWork.h
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddUserNetWork : NSObject

/** "provider_user_id":"存在的用户id",
 "exist_user":"存在标识 1-手机号已存在 2-车牌号已存在"  */

/** 存在的用户id */
@property (copy, nonatomic) NSString *provider_user_id;
/** 存在标识 */
@property (assign, nonatomic) NSInteger exist_user;

/** 新增加用户 */
+ (void)addUserInfoParams:(NSMutableDictionary *)params success:(void(^)(AddUserNetWork *addUser))success;

@end
