//
//  OrderCellView.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderGoodsView.h"

@interface OrderCellView : UIView

/** 服务类型 */
@property (nonatomic, strong) UIImageView *serviceTypeImage;
/** 服务类型名称 */
@property (nonatomic, strong) UILabel *serviceTypeLabel;
/** 订单状态 */
@property (nonatomic, strong) UILabel *orderStateLabel;
/** 订单时间 */
@property (nonatomic, strong) UILabel *orderTimeLabel;
/** 用户手机号 */
@property (nonatomic, strong) UILabel *phoneLabel;
/** 用户车牌号 */
@property (nonatomic, strong) UILabel *plnLabel;
/** 合计 */
@property (nonatomic, strong) UILabel *orderTotalLabel;
/** 支付方式 */
@property (strong, nonatomic) UILabel *payType;
/** 订单商品个数 */
@property (assign, nonatomic) NSInteger orderGoodsNum;

@end
