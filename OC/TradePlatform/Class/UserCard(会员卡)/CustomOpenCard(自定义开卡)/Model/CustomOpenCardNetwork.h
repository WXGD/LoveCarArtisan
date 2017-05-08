//
//  CustomOpenCardNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpneUserConflictModel.h"

@interface CustomOpenCardNetwork : NSObject

/** 自定义开卡 */
+ (void)customOpenCardParame:(NSMutableDictionary *)parame isCashPay:(BOOL)isCashPay success:(void(^)(NSMutableDictionary *successDic))success conflict:(void(^)(OpneUserConflictModel *userConflict))conflict;



@end
