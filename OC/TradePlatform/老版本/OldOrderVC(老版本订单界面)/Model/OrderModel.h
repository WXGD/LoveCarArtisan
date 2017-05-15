//
//  OrderModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJBaseModel.h"

@interface OrderModel : GJBaseModel

/*"order_id": 1  #订单id,
 "order_no": "X170121000001"  #订单编号,
 "create_time": "2017-01-21 15:02:58"  #下单时间,
 "total_actual_price": "0.00"  #订单实际总金额,
 "order_status": 1  #订单状态(1未支付，2已支付，3待评价，4已完成 6退款),
 "order_category_name": "未知"  #订单类别名,
 "goods_name": "商品1"  #商品名称,
 "buy_num": 1  #购买数量,
 "sale_price": "12.00"  #单价 
 "pay_method_id": 1  #支付方式 1-支付宝 2-微信 3或4-卡支付 6-现金
 "mobile": "18521516231"  #订单对应用户手机号,
 "car_plate_no": "豫AQ2Q11"  #订单对应车辆车牌号 */
/** 订单id */
@property (nonatomic, copy) NSString *order_id;
/** 订单编号 */
@property (nonatomic, copy) NSString *order_no;
/** 下单时间 */
@property (nonatomic, copy) NSString *create_time;
/** 订单实际总金额 */
@property (nonatomic, assign) double total_actual_price;
/** 订单状态(1未支付，2待使用，3待评价，4已完成 6退款) */
@property (nonatomic, assign) NSInteger order_status;
/** 订单类别名 */
@property (nonatomic, copy) NSString *order_category_name;
/** 订单类别id(2-服务 3-开卡 4-充值) */
@property (nonatomic, assign) NSInteger order_category_id;
/** 商品名称 */
@property (nonatomic, copy) NSString *goods_name;
/** 购买数量 */
@property (nonatomic, assign) NSInteger buy_num;
/** 单价 */
@property (nonatomic, assign) double sale_price;
/** 支付方式 1-支付宝 2-微信 3或4-卡支付 6-现金 */
@property (nonatomic, assign) NSInteger pay_method_id;
/** 订单对应用户手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 订单对应车辆车牌号 */
@property (nonatomic, copy) NSString *car_plate_no;
/*订单详情参数 
 "create_time" = "2017-03-19 13:42:23";
 "order_no" = K17031900001;
 "order_status" = 4;
 "pay_time" = "2017-03-19 13:42:23";
 "provider_id" = 1;
 "provider_user_id" = 46;
 remark = "";
 "sale_user" = "测试号";
 "save_amount" = "0.00";
 "staff_user" = "测试号";
 "total_actual_price" = "300.00";
 "total_price" = "300.00"; **/

/** 订单总金额 */
@property (nonatomic, assign) double total_price;
/** 优惠金额 */
@property (nonatomic, assign) double save_amount;
/** 备注 */
@property (nonatomic, copy) NSString *remark;
/** 收银员 */
@property (nonatomic, copy) NSString *staff_user;
/** 服务师傅 */
@property (nonatomic, copy) NSString *sale_user;
/** 用户id */
@property (nonatomic, assign) NSInteger provider_user_id;
/** 服务商ID */
@property (nonatomic, assign) NSInteger provider_id;
/** 付款时间 */
@property (nonatomic, copy) NSString *pay_time;

@end
