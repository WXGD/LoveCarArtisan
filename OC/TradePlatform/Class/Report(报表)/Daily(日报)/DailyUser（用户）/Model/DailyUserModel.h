//
//  DailyUserModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyUserModel : NSObject

/* "man_count": 1  #男用户数量,
 "woman_count": 1  #女用户数量,
 "unknown": 0  #未知性别数量,
 "count": 2  #总人数 */

/** 男用户数量 */
@property (assign, nonatomic) NSInteger man_count;
/** 女用户数量 */
@property (assign, nonatomic) NSInteger woman_count;
/** 未知性别数量 */
@property (assign, nonatomic) NSInteger unknown;
/** 总人数 */
@property (assign, nonatomic) NSInteger count;

/* 请求日用户数据 */
+ (void)requestDailyUserDataParams:(NSMutableDictionary *)params success:(void(^)(DailyUserModel *dailyUserModel))success;

@end
