//
//  DailyTurnoverModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyTurnoverModel : NSObject

/* "goods_category_name": "洗车"  #商品类别名称,
 "amount": "25"  #营业额*/


/** 商品类别名称 */
@property (copy, nonatomic) NSString *goods_category_name;
/** 营业额 */
@property (assign, nonatomic) double amount;

/* 请求日营业额数据 */
+ (void)requestDailyTurnoverModelDataParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *dailyTurnoverArray, NSMutableDictionary *options))success;

@end
