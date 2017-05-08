//
//  OrderClassModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderClassModel : NSObject

/*  "order_category_id": 1  #订单分类id,
 "name": "活动"  #订单分类名称 */
/** 订单类型id */
@property (nonatomic, assign) NSInteger order_category_id;
/** 订单类型名称 */
@property (nonatomic, copy) NSString *name;
/** 标记商品是否选中 */
@property (nonatomic, assign) BOOL checkMark;

@end
