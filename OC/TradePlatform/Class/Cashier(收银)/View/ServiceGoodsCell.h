//
//  ServiceGoodsCell.h
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityShowStyleModel.h"
#import "ServiceProviderModel.h"
#import "MerchantInfoModel.h"
#import "CardTypeModel.h"
#import "CarConditionModel.h"
#import "CarUseModel.h"
#import "OrderPayStateModel.h"
#import "ExpireModel.h"
#import "CouponGoverModel.h"

@interface ServiceGoodsCell : UITableViewCell

/** 商品数据模型 */
@property (strong, nonatomic) CommodityShowStyleModel *commodityModel;
/** 服务数据模型 */
@property (strong, nonatomic) ServiceProviderModel *serviceModel;
/** 服务师傅模型 */
@property (strong, nonatomic) MerchantInfoModel *serviceMasterModel;
/** 会员卡类型模型 */
@property (strong, nonatomic) CardTypeModel *cardTypeModel;
/** 车况 */
@property (strong, nonatomic) CarConditionModel *carConditionModel;
/** 车辆用途 */
@property (strong, nonatomic) CarUseModel *carUseModel;
/** 订单支付状态 */
@property (strong, nonatomic) OrderPayStateModel *orderPayStateModel;
/** 用户筛选区间 */
@property (strong, nonatomic) ExpireModel *expireModel;
/** 优惠劵类型模型 */
@property (strong, nonatomic) CouponGoverModel *couponTypeModel;

/** 服务，商品，师傅名称 */
@property (strong, nonatomic) UILabel  *serviceNameLabel;

@end
