//
//  OrderInfoModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "OrderModel.h"
#import "OrderTransactInfoModel.h"
#import "OrderCommentModel.h"
#import "OrderDetailsModel.h"

@interface OrderInfoModel : NSObject

/* "user_info":
 "order_info":
 "order_pay_info":
 "order_comment":
 order_detail: */



/** 订单用户信息 */
@property (nonatomic, strong) UserModel *user_info;
/** 订单信息 */
@property (nonatomic, strong) OrderModel *order_info;
/** 订单支付信息 */
@property (nonatomic, strong) OrderTransactInfoModel *order_pay_info;
/** 订单评论 */
@property (nonatomic, strong) OrderCommentModel *order_comment;
/** 订单包含商品 */
@property (nonatomic, strong) NSArray *order_detail;

/** 请求订单详细信息 */
+ (void)requestOrderInfoOrderNo:(NSString *)orderNo success:(void(^)(OrderInfoModel *orderModel))success;


@end
