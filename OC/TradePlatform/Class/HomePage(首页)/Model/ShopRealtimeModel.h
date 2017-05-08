//
//  ShopRealtimeModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopRealtimeModel : NSObject

/* "count": 2  #消费人数,
 "amount": "25.00"  #营业额 */
/** 消费人数 */
@property (nonatomic, assign) NSInteger count;
/** 营业额 */
@property (nonatomic, assign) float amount;
/** 更新时间 */
@property (nonatomic, copy) NSString *update_time;

// 请求店铺实时数据
+ (void)shopRealtimeRequestSuccess:(void(^)(ShopRealtimeModel *shopRealtime))success noLogin:(void(^)())noLogin failure:(void(^)())failure;

@end
