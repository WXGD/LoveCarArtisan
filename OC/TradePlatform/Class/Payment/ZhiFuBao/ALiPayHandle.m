//
//  ALiPayHandle.m
//  CarRepairFactory
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ALiPayHandle.h"

@implementation ALiPayHandle

+ (instancetype)sharedManager {
    static ALiPayHandle *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (void)aLiPay:(NSDictionary *)aliPayDic {
    if (_delegate && [_delegate respondsToSelector:@selector(aLiPaySuccessCallback:)]) {
        [_delegate aLiPaySuccessCallback:aliPayDic];
    }
}

@end
