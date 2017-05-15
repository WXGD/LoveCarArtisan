//
//  OrderTypeListModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AlertListModel.h"

@interface OrderTypeListModel : AlertListModel

/*  "order_category_id": 1  #订单分类id,
 "name": "活动"  #订单分类名称 */
/** 订单类型id */
@property (nonatomic, assign) NSInteger order_category_id;
/** 订单类型名称 */
@property (nonatomic, copy) NSString *name;

// 获取商家已卖出商品数量统计数据
+ (void)requesOrderTypeListDataSuccess:(void(^)(NSMutableArray *orderList))success;

@end
