//
//  OrderGoodsModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderGoodsModel : NSObject

/** 订单商品 "buy_num" = 1;
 "goods_category_name" = "";
 "goods_name" = "储值6";
 "sale_price" = "0.01";      **/

/** 订单类别名 */
@property (nonatomic, copy) NSString *goods_category_name;
/** 商品名称 */
@property (nonatomic, copy) NSString *goods_name;
/** 购买数量 */
@property (nonatomic, assign) NSInteger buy_num;
/** 单价 */
@property (nonatomic, assign) double sale_price;

@end
