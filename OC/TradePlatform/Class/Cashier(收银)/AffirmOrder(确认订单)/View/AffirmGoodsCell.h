//
//  AffirmGoodsCell.h
//  TradePlatform
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"

@interface AffirmGoodsCell : UITableViewCell

/** 购物车商品模型 */
@property (strong, nonatomic) ShoppingCartModel *shoppingCartModel;

@end
