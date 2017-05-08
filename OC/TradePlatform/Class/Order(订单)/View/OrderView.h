//
//  OrderView.h
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderPayStateModel.h"
#import "FilterConditionBtn.h"
#import "OrderCell.h"

@protocol OrderDeleSelectDelegate <NSObject>

@optional
- (void)orderDidSelectDelegate:(OrderModel *)orderModel;

@end

@interface OrderView : UIView

/** 背景view */
@property (strong, nonatomic) UIStackView *orderBackView;
/** 筛选展示view */
@property (strong, nonatomic) UIView *screenShowsView;
/** 选中的订单支付状态 */
@property (strong, nonatomic) OrderPayStateModel *orderPayStateModel;
/** 当前选中服务师傅模型 */
@property (strong, nonatomic) MerchantInfoModel *merchantModel;
/** 更多筛选条件 */
@property (strong, nonatomic) FilterConditionBtn *screenExistBtn;
/** 选中筛选条件 */
@property (strong, nonatomic) UILabel *selScreenConditionLabel;
/** 删除筛选展示按钮 */
@property (strong, nonatomic) UIButton *delScreenBtn;
/** 代理 */
@property (assign, nonatomic) id<OrderDeleSelectDelegate>delegate;


/** tableview */
@property (strong, nonatomic) UITableView *orderTableView;
/** 订单数据 */
@property (strong, nonatomic) NSMutableArray *orderTableArray;


@end
