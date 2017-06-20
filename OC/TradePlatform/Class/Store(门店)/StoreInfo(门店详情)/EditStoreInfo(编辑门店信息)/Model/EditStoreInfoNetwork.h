//
//  EditStoreInfoNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditStoreInfoNetwork : NSObject

/** 修改商户信息 */
+ (void)editMerchantInfoParams:(NSMutableDictionary *)params success:(void(^)())success;

@end
