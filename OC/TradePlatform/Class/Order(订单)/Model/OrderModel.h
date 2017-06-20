//
//  OrderModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderGoodsModel.h"

@interface OrderModel : NSObject

/** 订单信息 "car_plate_no" = "豫AQ2Q16";
 "create_time" = "2017-04-10 17:00:47";
 mobile = 18737141800;
 "order_category_id" = 4;
 "order_category_name" = "充值";
 "order_detail" =             ( );
 "order_id" = 472;
 "order_no" = K17041000008;
 "order_status" = 3;
 "pay_method_id" = 1;
 "total_actual_price" = "0.01";     **/
/** 车牌号 */
@property (nonatomic, copy) NSString *car_plate_no;
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 订单类别id(2-服务 3-开卡 4-充值) */
@property (nonatomic, assign) NSInteger order_category_id;
/** 订单类型名称 */
@property (nonatomic, copy) NSString *order_category_name;
/** 订单商品列表 */
@property (nonatomic, strong) NSArray *order_detail;
/** 订单ID */
@property (nonatomic, assign) NSInteger order_id;
/** 订单号 */
@property (nonatomic, copy) NSString *order_no;
/** 订单状态(1未支付，2待使用，3待评价，4已完成 6退款) */
@property (nonatomic, assign) NSInteger order_status;
/** 支付方式 1-支付宝 2-微信 3或4-卡支付 6-现金 */
@property (nonatomic, assign) NSInteger pay_method_id;
/** 总金额 */
@property (nonatomic, assign) double total_actual_price;





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
/** 订单编号 */
/** 下单时间 */
/** 订单实际总金额 */
/** 订单状态(1未支付，2待使用，3待评价，4已完成 6退款) */
/** 订单类别名 */
/** 订单类别id(2-服务 3-开卡 4-充值) */
/** 商品名称 */
@property (nonatomic, copy) NSString *goods_name;
/** 购买数量 */
@property (nonatomic, assign) NSInteger buy_num;
/** 单价 */
@property (nonatomic, assign) double sale_price;
/** 支付方式 1-支付宝 2-微信 3或4-卡支付 6-现金 */
/** 订单对应用户手机号 */
/** 订单对应车辆车牌号 */
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
 "coupon_amount" = "0.00"; 优惠券金额
 "staff_user" = "测试号";
 "total_actual_price" = "300.00";
 "total_price" = "300.00"; **/

/** 订单总金额 */
@property (nonatomic, assign) double total_price;
/** 优惠金额 */
@property (nonatomic, assign) double save_amount;
/** 优惠券金额 */
@property (nonatomic, assign) double coupon_amount;
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


// 下拉刷新
- (void)orderRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *orderArray))success;
// 上啦加载
- (void)orderLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *orderArray))success;


@end
