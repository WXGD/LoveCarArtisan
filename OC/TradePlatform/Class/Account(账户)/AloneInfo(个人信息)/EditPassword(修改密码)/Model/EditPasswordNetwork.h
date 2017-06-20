//
//  EditPasswordNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditPasswordNetwork : NSObject

/** 修改当前登陆用户密码 */
+ (void)editAccountPasswordParams:(NSMutableDictionary *)params success:(void(^)())success;

@end
