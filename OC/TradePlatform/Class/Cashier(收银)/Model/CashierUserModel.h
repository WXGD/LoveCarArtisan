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
/** 是否有用户 -1：没有用户 */
@property (nonatomic, assign) NSInteger exist_user;
/** 是否有冲突用户 1：有冲突 */
@property (nonatomic, assign) NSInteger conflict;
/** 冲突用户id */
@property (nonatomic, copy) NSString *provider_user_id;

/** 根据用户手机号，获取用户信息，用户会员卡信息 (收银页使用)*/
+ (void)foundationUserPhoneObtainUserInfoParams:(NSMutableDictionary *)params success:(void(^)(CashierUserModel *cashierUserModel))success;


@end
