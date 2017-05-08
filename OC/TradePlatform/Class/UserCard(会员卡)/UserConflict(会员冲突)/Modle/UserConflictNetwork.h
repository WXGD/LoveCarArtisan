//
//  UserConflictNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserConflictNetwork : NSObject

/** 查询冲突用户 */
+ (void)queryConflictUserParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success;
/** 合并冲突用户 */
+ (void)mergeConflictUserParams:(NSMutableDictionary *)params success:(void(^)())success;

@end
