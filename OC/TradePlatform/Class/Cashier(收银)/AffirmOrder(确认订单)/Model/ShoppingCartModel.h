//
//  ShoppingCartModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceProviderModel.h"
#import "UserModel.h"

@interface ShoppingCartModel : NSObject


/** 服务模型 */
@property (strong, nonatomic) ServiceProviderModel *goods_category;
/** 商品模型 */
@property (strong, nonatomic) CommodityShowStyleModel *goods;    
/** 购买数量 */
@property (nonatomic, assign) NSInteger buy_num;

@end
