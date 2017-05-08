//
//  OrderCellView.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCellView : UIView

/** 服务类型 */
@property (nonatomic, strong) UIImageView *serviceTypeImage;
/** 服务类型名称 */
@property (nonatomic, strong) UILabel *serviceTypeLabel;
/** 订单状态 */
@property (nonatomic, strong) UILabel *orderStateLabel;
/** 订单名称 */
@property (nonatomic, strong) UILabel *orderNameLabel;
/** 订单时间 */
@property (nonatomic, strong) UILabel *orderTimeLabel;
/** 订单价格 */
@property (nonatomic, strong) UILabel *orderPriceLabel;
/** 订单次数 */
@property (nonatomic, strong) UILabel *orderNumLabel;
/** 用户手机号 */
@property (nonatomic, strong) UILabel *phoneLabel;
/** 用户车牌号 */
@property (nonatomic, strong) UILabel *plnLabel;
/** 合计 */
@property (nonatomic, strong) UILabel *orderTotalLabel;
/** 支付方式 */
@property (strong, nonatomic) UILabel *payType;

/** 支付信息view */
@property (strong, nonatomic) UIView *payView;


@end
