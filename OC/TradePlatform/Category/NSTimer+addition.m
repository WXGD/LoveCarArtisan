//
//  NSTimer+addition.m
//  WYHomeLoopView
//
//  Created by 王启镰 on 16/5/5.
//  Copyright © 2016年 wanglijinrong. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)
// 暂停
- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}
// 恢复
- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}
// 恢复的时间间隔
- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end
