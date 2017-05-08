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

@end
