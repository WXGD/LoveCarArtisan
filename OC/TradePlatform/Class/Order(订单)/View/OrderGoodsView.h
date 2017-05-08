//
//  OrderGoodsView.h
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderGoodsView : UIView

/** 商品类别名称 */
@property (nonatomic, copy) NSString *goodsClassName;
/** 商品名称 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
/** 商品数量 */
@property (nonatomic, strong) UILabel *goodsNumLabel;
/** 商品价格 */
@property (nonatomic, strong) UILabel *goodsPriceLabel;

@end
