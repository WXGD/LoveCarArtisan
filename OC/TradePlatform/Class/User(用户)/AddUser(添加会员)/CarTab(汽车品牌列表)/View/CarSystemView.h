//
//  CarSystemView.h
//  CarRepairFactory
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BrandModel.h"
#import "CarBrandModel.h"
#import "CWFUserCarModel.h"

@interface CarSystemView : UIView

/** 车品牌模型 */
@property (strong, nonatomic) CarBrandModel *carBrandSystem;
/** 车型点击 */
@property (copy, nonatomic) void(^carSystemBlack)(CWFUserCarModel *selectCarSystem);

@end
