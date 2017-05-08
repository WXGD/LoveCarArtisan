//
//  PendOrderCell.h
//  TradePlatform
//
//  Created by 祝豪杰 on 17/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PendOrderModel.h"
#import "OrderGoodsModel.h"
#import <UIKit/UIKit.h>

@interface PendOrderCell : UITableViewCell
@property(nonatomic, strong) PendOrderModel *model;
@property(nonatomic, strong) NSIndexPath *indP;
@property(copy, nonatomic) void (^deletependOrderClick)(PendOrderModel *pendOrderModel,NSIndexPath *indP);
@property(copy, nonatomic) void (^confirmCashClick)(PendOrderModel *pendOrderModel,NSIndexPath *indP);
@end
