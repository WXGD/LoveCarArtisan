//
//  PremiumModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
// 模型
#import "ServiceProviderModel.h"

@interface PremiumModel : NSObject

/** 服务模型 */
@property (nonatomic, strong) ServiceProviderModel *serviceModel;
/** 商品模型 */
@property (nonatomic, strong) CommodityShowStyleModel *goodsModel;
/** 赠送次数 */
@property (nonatomic, assign) NSInteger premiumNum;

@end
