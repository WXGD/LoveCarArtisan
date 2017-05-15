//
//  OrderDetailsModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailsModel : NSObject

/** "available_num" = 0;
 "buy_num" = 1;
 "goods_name" = "储值1";
 "sale_price" = "300.00";  **/


/** 剩余数量 */
@property (nonatomic, assign) NSInteger available_num;
/** 总数量 */
@property (nonatomic, assign) NSInteger buy_num;
/** 商品名称 */
@property (nonatomic, copy) NSString *goods_name;
/** 商品销售价 */
@property (nonatomic, assign) double sale_price;

@end
