//
//  CommodityInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// 下级控制器
#import "EditCommodityViewController.h"

@interface CommodityInfoViewController : RootViewController

// 商品模型
@property (nonatomic, strong) CommodityShowStyleModel *commodityShowModel;

@end
