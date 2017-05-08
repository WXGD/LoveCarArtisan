//
//  CashierViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

// 收银页面来源
typedef NS_ENUM(NSInteger, CashierVCSource) {
    /** 首页 */
    HomeCashierViewSource,
    /** 挂单页 */
    PendOrderCashierViewSource,
};

#import "RootViewController.h"

@interface CashierViewController : RootViewController

/** 车牌拍照数据 */
@property (strong, nonatomic) NSMutableDictionary *plnPhoto;
/** 收银页面来源 */
@property (assign, nonatomic) CashierVCSource cashierVCSource;
/********挂单***********/
/** 用户手机号 */
@property (copy, nonatomic) NSString *userPhone;
/** 用户车牌号 */
@property (copy, nonatomic) NSString *userPln;
/** 挂单ID */
@property (assign, nonatomic) NSInteger cartID;
/** 服务师傅 */
@property (strong, nonatomic) MerchantInfoModel *serviceMasterModel;
/** 服务商品 */
@property (strong, nonatomic) NSMutableArray *goodsArray;
/** 行驶里程 */
@property (copy, nonatomic) NSString *mileage;
/** 下一次保养时间 */
@property (copy, nonatomic) NSString *nextMaintain;
/** 购物车总价 */
@property (assign, nonatomic) double shoppingCartTotal;
/** 订单时间 */
@property (copy, nonatomic) NSString *orderTime;

@end
