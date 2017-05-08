//
//  CarBrandListViewController.h
//  CarRepairFactory
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootViewController.h"
// 车系
#import "CarSystemView.h"
#import "CWFUserCarModel.h"

@interface CarBrandListViewController : RootViewController

/** 车系view */
@property (strong, nonatomic) CarSystemView *carSystemView;
/** 车型点击 */
@property (copy, nonatomic) void(^carSystemBlack)(CWFUserCarModel *selectCarSystem);

@end
