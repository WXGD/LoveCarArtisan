//
//  OrderTransactInfoModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderTransactInfoModel : NSObject

/* "pay_amount_text": "￥0.00"  #实际支付文本,
 "pay_no": "20170121003444"  #卡/交易号,
 "pay_method_text": "支付宝"  #支付方式文本 */

/** 实际支付文本 */
@property (nonatomic, copy) NSString *pay_amount_text;
/** 卡/交易号 */
@property (nonatomic, copy) NSString *pay_no;
/** 支付方式文本 */
@property (nonatomic, copy) NSString *pay_method_text;

/**  订单详情：订单支付信息
 "pay_amount_text": "￥0.00"  #实际支付文本,
 "pay_no": "20170121003444"  #卡/交易号,
 "pay_method_text": "支付宝"  #支付方式文本
 */

@end
