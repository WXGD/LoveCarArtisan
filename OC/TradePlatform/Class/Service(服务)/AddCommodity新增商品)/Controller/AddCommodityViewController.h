//
//  AddCommodityViewController.h
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"

@interface AddCommodityViewController : RootViewController

/** 添加新的商品成功 */
@property (strong, nonatomic) void(^addCommoditySuccessBlock)();

@end
