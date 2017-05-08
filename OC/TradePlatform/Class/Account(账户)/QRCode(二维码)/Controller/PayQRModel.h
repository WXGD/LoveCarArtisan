//
//  PayQRModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayQRModel : NSObject

/**  "order_id": 4  #订单id,
 "order_status": 1  #订单状态 1-未支付 3-待评价 4-已完成  */

/** 订单id, */
@property (copy, nonatomic) NSString *order_id;
/** 订单状态 1-未支付 3-待评价 4-已完成, */
@property (assign, nonatomic) NSInteger order_status;

@end
