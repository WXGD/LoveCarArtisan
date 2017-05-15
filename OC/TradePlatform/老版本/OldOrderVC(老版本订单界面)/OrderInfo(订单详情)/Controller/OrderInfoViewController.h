//
//  OrderInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// 数据模型
#import "OrderInfoModel.h"

@interface OrderInfoViewController : RootViewController

/** 订单编号 */
@property (copy, nonatomic) NSString *orderID;
/** 订单信息 */
@property (copy, nonatomic) OrderModel *orderModel;

@end
