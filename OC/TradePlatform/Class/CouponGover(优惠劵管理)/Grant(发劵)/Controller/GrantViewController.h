//
//  GrantViewController.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// 管理优惠劵模型
#import "CouponGoverModel.h"

@interface GrantViewController : RootViewController

/** 优惠卷模型 */
@property (strong, nonatomic) CouponGoverModel *couponGoverModel;

@end
