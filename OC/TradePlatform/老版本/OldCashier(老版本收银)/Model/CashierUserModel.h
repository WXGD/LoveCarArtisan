//
//  CashierUserModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserModel.h"
#import "CancellationModel.h"
#import "UserMemberCardModel.h"


@interface CashierUserModel : NSObject


/**   "available_order" =         ({});
 cards =         ({});
 "user_info" =         {};
 **/

/** 赠品 */
@property (nonatomic, strong) NSArray *available_order;
/** 用户卡 */
@property (nonatomic, strong) NSArray *cards;
/** 用户信息 */
@property (nonatomic, strong) UserModel *user_info;

/** 根据用户手机号，获取用户信息，用户会员卡信息 (收银页使用)*/
+ (void)foundationUserPhoneObtainUserInfoParams:(NSMutableDictionary *)params success:(void(^)(CashierUserModel *cashierUserModel))success;


@end
