//
//  UsedCarSeriesModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsedCarBrandModel.h"

@interface UsedCarSeriesModel : NSObject

/**  name = "别克 Buick (进口)";
 "series_version" =       */

/** 所有车系 */
@property (nonatomic, strong) NSArray *series_version;
/** 车系名 */
@property (nonatomic, copy) NSString *name;

@end
