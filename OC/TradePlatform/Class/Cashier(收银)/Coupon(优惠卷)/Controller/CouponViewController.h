//
//  CouponViewController.h
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UserModel.h"
#import "CommodityShowStyleModel.h"
#import "ServiceProviderModel.h"

@interface CouponViewController : RootViewController

/** 用户信息 */
@property (strong, nonatomic) UserModel *userInfo;
/** 商品 */
@property (strong, nonatomic) CommodityShowStyleModel *defaultCommodity;
/** 服务 */
@property (strong, nonatomic) ServiceProviderModel *defaultService;
/** 优惠券选择回调 */
@property (copy, nonatomic) void(^CouponChioceBlock)(NSString *couponID, double offerSum);

@end
