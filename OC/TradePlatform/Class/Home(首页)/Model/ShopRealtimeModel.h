//
//  ShopRealtimeModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopRealtimeModel : NSObject

/*  "order_count": 1  #订单数,
 "user_count": 1  #消费人数,
 "amount": "25.00"  #营业额 */
/** 订单数 */
@property (nonatomic, assign) NSInteger order_count;
/** 营业额 */
@property (nonatomic, assign) float amount;
/** 消费人数 */
@property (nonatomic, assign) NSInteger user_count;
/** 更新时间 */
@property (nonatomic, copy) NSString *update_time;


// 请求店铺实时数据
+ (void)shopRealtimeRequestParame:(NSMutableDictionary *)parame success:(void(^)(ShopRealtimeModel *shopRealtime))success scrollView:(UIScrollView *)scrollView noLogin:(void(^)())noLogin failure:(void(^)())failure;

@end
