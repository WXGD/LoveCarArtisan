//
//  CommodityShowStyleModel.h
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AlertListModel.h"

@interface CommodityShowStyleModel : AlertListModel 

/** 会员卡支付参数 */
/** 购买次数 */
@property (nonatomic, assign) NSInteger num;
/** 支付金额 */
@property (nonatomic, assign) double total;
/** 优惠金额 */
@property (nonatomic, assign) double saveAmount;

/**新版接口字段
 "goods_id": 1  #商品id,
 "name": "商品1"  #商品名称,
 "price": "12.00"  #商品原价,
 "sale_price": "10.00"  #商品售价,
 "card_num_price": 1  #商品需要支付的次数
 "status": 1  #商品状态 0-下架 1-在售   */
/** 商品id */
@property (nonatomic, assign) NSInteger goods_id;
/** 商品名称 */
@property (nonatomic, copy) NSString *name;
/** 商品原价 */
@property (nonatomic, assign) double price;
/** 商品销售价格 */
@property (nonatomic, assign) double sale_price;
/** 商品需要支付的次数 */
@property (nonatomic, assign) NSInteger card_num_price;
/** 商品状态 0-下架 1-在售 */
@property (nonatomic, assign) NSInteger status;
/** 收银页面添加字段
 "cart_id": 1,
 "actual_sale_price": "12.00"  #商品实际售价(修改后的价格),
 "buy_num": 5  #购买数量,
 "goods_id": 1  #商品id,
 "goods_name": "商品2"  #商品名称   **/
/** 购物车id */
@property (nonatomic, assign) NSInteger cart_id;
/** 商品实际售价(修改后的价格) */
@property (nonatomic, assign) double actual_sale_price;
/** 购买数量 */
@property (nonatomic, assign) NSInteger buy_num;
/** 商品名称 */
@property (nonatomic, copy) NSString *goods_name;

/** 自加参数，*/
/** 标记商品是否选中 */
@property (nonatomic, assign) BOOL checkMark;

// 获取全部商品
+ (void)requesCommodityListDataParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *commodityList))success;

@end
