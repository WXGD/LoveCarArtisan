//
//  ExpireModel.h
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpireModel : NSObject

/** "user_track_id": 2  #列表id,
 "max_value": 60  #区间最大值,
 "min_value": 20  #区间最小值,
 "unit": "天"  #区间单位   **/

/** 列表id */
@property (assign, nonatomic) NSInteger user_track_id;
/** 区间最大值 */
@property (copy, nonatomic) NSString *max_value;
/** 区间最小值 */
@property (copy, nonatomic) NSString *min_value;
/** 区间单位 */
@property (copy, nonatomic) NSString *unit;
/** 标记是否选中 */
@property (nonatomic, assign) BOOL checkMark;


/** 获取数据区间信息 */
+ (void)requestDataSection:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *sectionArray))success;
/** 添加数据区间信息 */
+ (void)addDataSection:(NSMutableDictionary *)params success:(void(^)())success;
/** 删除数据区间信息 */
+ (void)delDataSection:(NSMutableDictionary *)params success:(void(^)())success;

@end
