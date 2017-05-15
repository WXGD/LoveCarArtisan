//
//  CancellationModel.h
//  TradePlatform
//
//  Created by 弓杰 on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancellationModel : NSObject

/** "available_num" = 1;
 "create_time" = "2017-03-19 13:42:23";
 "goods_name" = "洗车111";
 "order_detail_id" = 271;
 "order_id" = 271;  */



/** 赠品数量 */
@property (assign, nonatomic) NSInteger available_num;
/** 赠品时间 */
@property (copy, nonatomic) NSString *create_time;
/** 赠品名称 */
@property (copy, nonatomic) NSString *goods_name;
/** 赠品详情ID */
@property (assign, nonatomic) NSInteger order_detail_id;
/** 赠品ID */
@property (assign, nonatomic) NSInteger order_id;

/** 使用赠品 */
+ (void)useGifts:(NSMutableDictionary *)params success:(void(^)())success;

@end
