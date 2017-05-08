//
//  CardChoiceViewController.h
//  TradePlatform
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UserModel.h"
#import "CommodityShowStyleModel.h"
#import "ServiceProviderModel.h"
// 下级控制器
#import "PaySuccessViewController.h"

@interface CardChoiceViewController : RootViewController

/** 用户信息(修改用户信息时需要) */
@property (strong, nonatomic) UserModel *userInfo;
/** 服务师傅 */
@property (strong, nonatomic) MerchantInfoModel *serviceMasterModel;
/** 会员卡列表数据 */
@property (strong, nonatomic) NSMutableArray *userCardListArray;
/** 商品 */
@property (strong, nonatomic) CommodityShowStyleModel *defaultCommodity;
/** 服务 */
@property (strong, nonatomic) ServiceProviderModel *defaultService;

/** 挂单ID */
@property (assign, nonatomic) NSInteger cartID;
/** 行驶里程 */
@property (copy, nonatomic) NSString *mileage;
/** 下一次保养时间 */
@property (copy, nonatomic) NSString *nextMaintain;
/** 支付成功页面来源 */
@property (assign, nonatomic) PaySuccessVCSource paySuccessVCSource;

@end
