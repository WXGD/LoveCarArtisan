//
//  AffirmOrderViewController.h
//  TradePlatform
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

// 确认订单页面来源
typedef NS_ENUM(NSInteger, AffirmOrderVCSource) {
    /** 收银页 */
    CashierAffirmOrderViewSource,
    /** 挂单页 */
    PendOrderAffirmOrderViewSource,
};

#import "RootViewController.h"
#import "CashierUserModel.h"

@interface AffirmOrderViewController : RootViewController

/** 收银用户信息 */
@property (strong, nonatomic) CashierUserModel *cashierUserModel;
/** 用户手机号 */
@property (copy, nonatomic) NSString *userPhone;
/** 用户车牌号 */
@property (copy, nonatomic) NSString *userPln;
/** 服务师傅 */
@property (strong, nonatomic) MerchantInfoModel *serviceMasterModel;
/** 服务商品 */
@property (strong, nonatomic) NSMutableArray *goodsArray;
/** 订单总价 */
@property (assign, nonatomic) double orderTotal;
/** 商品data */
@property (copy, nonatomic) NSString *goodsData;
/** 行驶里程 */
@property (copy, nonatomic) NSString *mileage;
/** 下一次保养时间 */
@property (copy, nonatomic) NSString *nextMaintain;
/** 购物车记录 */
@property (assign, nonatomic) NSInteger cartID;
/** 订单时间 */
@property (copy, nonatomic) NSString *orderTime;
/** 页面来源 */
@property (assign, nonatomic) AffirmOrderVCSource viewSource;

@end
