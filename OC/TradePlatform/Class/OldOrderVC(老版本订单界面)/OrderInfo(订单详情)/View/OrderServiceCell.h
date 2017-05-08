//
//  OrderServiceCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"

@interface OrderServiceCell : UITableViewCell

/** 商品信息 */
@property (strong, nonatomic) OrderDetailsModel *orderDetailsModel;

@end
