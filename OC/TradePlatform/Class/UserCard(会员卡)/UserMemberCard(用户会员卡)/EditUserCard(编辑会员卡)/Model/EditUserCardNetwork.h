//
//  EditUserCardNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditUserCardNetwork : NSObject

/** 保存编辑后的用户信息 */
+ (void)preservedEditUserCardParame:(NSMutableDictionary *)parame isCashPay:(BOOL)isCashPay success:(void(^)(NSMutableDictionary *thirdPartyDic))success;

@end
