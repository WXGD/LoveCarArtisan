//
//  EncryptionMode.h
//  LoveCarMerchant
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionMode : NSObject

- (NSString *)repuestUrlAddSig;
- (NSString *)repuestAuthorization;

/** sigMD5加密 */
+ (NSString *)repuestUrlAddSigParameters:(NSMutableDictionary *)parameters timeStr:(NSString *)timeStr;
/** Authorizationbase64加密 */
+ (NSString *)repuestAuthorizationTimeStr:(NSString *)timeStr ;

@end
