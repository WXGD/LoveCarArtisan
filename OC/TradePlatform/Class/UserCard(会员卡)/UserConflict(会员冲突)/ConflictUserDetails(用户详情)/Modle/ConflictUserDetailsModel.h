//
//  ConflictUserDetailsModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
// 数据模型
#import "UserMemberCardModel.h"
#import "CWFUserCarModel.h"

@interface ConflictUserDetailsModel : NSObject

/**  "user_card":[{}],
 "user_car":[{}],
 "user_card_count": 1  #卡数,
 "user_car_count": 1  #车辆数  */

/** 用户卡列表 */
@property (strong, nonatomic) NSMutableArray *user_card;
/** 用户车列表 */
@property (strong, nonatomic) NSMutableArray *user_car;
/** 卡数 */
@property (assign, nonatomic) NSInteger user_card_count;
/** 车辆数 */
@property (assign, nonatomic) NSInteger user_car_count;

+ (void)requstConflictUserDetailsParams:(NSMutableDictionary *)params success:(void(^)(ConflictUserDetailsModel *conflictUserDetails))success;

@end
