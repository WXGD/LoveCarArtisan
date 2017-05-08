//
//  CommodityShowStyleViewController.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootViewController.h"
// 商品类型模型
#import "ServiceProviderModel.h"

@interface CommodityShowStyleViewController : RootViewController

/** 服务类型模型 */
@property (nonatomic, strong) ServiceProviderModel *commodityTypeModel;
/** 0-下架 1-在售 2-全部（ */
@property (nonatomic, assign) NSInteger status;

@end
