//
//  CarUseModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//
// 车辆用途

#import <Foundation/Foundation.h>

@interface CarUseModel : NSObject

/**  "purpose_name" : "自用",
 "purpose_id" : "1",   **/

/** 车辆用途 */
@property (nonatomic, copy) NSString *purpose_name;
/** 车辆用途id */
@property (nonatomic, assign) NSInteger purpose_id;
/** 自加参数，*/
/** 标记商品是否选中 */
@property (nonatomic, assign) BOOL checkMark;

/** 请求车辆用途 */
+ (void)requestCarPurposeSuccess:(void(^)(NSMutableArray *carPurposeArray))success;

@end
