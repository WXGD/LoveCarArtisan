//
//  ALiPayHandle.h
//  CarRepairFactory
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ALiPayHandleDelegate <NSObject>

@optional

/** 支付成功 */
- (void)aLiPaySuccessCallback:(NSDictionary *)aliPayDic;

@end


@interface ALiPayHandle : NSObject

@property (nonatomic, assign) id<ALiPayHandleDelegate> delegate;

+ (instancetype)sharedManager;

- (void)aLiPay:(NSDictionary *)aliPayDic;

@end
