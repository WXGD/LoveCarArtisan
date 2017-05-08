//
//  ShoppingCartCell.h
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"

@interface ShoppingCartCell : UITableViewCell

/** 数量 */
@property (strong, nonatomic) UITextField *numTF;
/** 加号 */
@property (strong, nonatomic) UIButton *addBtn;
/** 减号 */
@property (strong, nonatomic) UIButton *subBtn;
/** 销售价 */
@property (strong, nonatomic) UsedCellView *pretiumView;

/** 购物车商品模型 */
@property (strong, nonatomic) ShoppingCartModel *shoppingCartModel;

@end
