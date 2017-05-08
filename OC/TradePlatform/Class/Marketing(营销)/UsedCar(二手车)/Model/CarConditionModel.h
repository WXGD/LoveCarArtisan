//
//  CarConditionModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//
// 车况

#import <Foundation/Foundation.h>

@interface CarConditionModel : NSObject

/**  "car_condition_name" : "较差",
 "car_condition_id" : "3",  **/


/** 车况 */
@property (nonatomic, copy) NSString *car_condition_name;
/** 车况id  */
@property (nonatomic, assign) NSInteger car_condition_id;
/** 自加参数，*/
/** 标记商品是否选中 */
@property (nonatomic, assign) BOOL checkMark;


/** 请求车况类型 */
+ (void)requestCarConditionSuccess:(void(^)(NSMutableArray *carConditionArray))success;


@end
