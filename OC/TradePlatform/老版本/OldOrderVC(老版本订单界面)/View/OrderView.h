//
//  OrderView.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJBaseTabelView.h"
#import "OrderDataSource.h"
#import "AlertListAction.h"
#import "OrderTypeListModel.h"

@protocol OrderCellSelectDelegate  <NSObject>

@optional
// 点击订单cell
- (void)orderRowDidSelectAtIndexPath:(NSIndexPath *)indexPath;
// 修改订单状态或类型
- (void)alertModelChooseActionBoxView;

@end

@interface OrderView : UIView

/** 订单 */
@property (strong, nonatomic) GJBaseTabelView *orderTable;
@property (strong, nonatomic) OrderDataSource *orderDataSource;
t
/** 选中的订单类型 */
@property (strong, nonatomic) OrderTypeListModel *orderPayClassModel;
/** 当前选中服务师傅模型 */
@property (strong, nonatomic) MerchantInfoModel *currentMerchantModel;

/** 订单类型数据 */
@property (strong, nonatomic) NSMutableArray *orderPayClassArray;

@property (assign, nonatomic) id<OrderCellSelectDelegate>delegate;

@end
