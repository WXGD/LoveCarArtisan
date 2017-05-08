//
//  AddCarNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeInfoNetWork.h"

@interface AddCarNetwork : NSObject

/** 添加用户车辆 */
+ (void)addUserCarParams:(NSMutableDictionary *)params success:(void(^)(ChangeInfoNetWork *changeUserCar))success;

@end
