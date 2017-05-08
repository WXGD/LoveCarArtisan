//
//  ShoppingCartViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"

@interface ShoppingCartViewController : RootViewController

/** 购物车商品 */
@property (strong, nonatomic) NSMutableArray *shoppingCartCommodityArray;
/** 购物车数量 */
@property (assign, nonatomic) NSInteger shoppingCartNum;
/** 购物车总价 */
@property (assign, nonatomic) double shoppingCartTotal;
/** 数据回调 */
@property (copy, nonatomic) void(^ShoppingCartBlock)(NSInteger shoppingCartNum, double shoppingCartTotal);

@end
