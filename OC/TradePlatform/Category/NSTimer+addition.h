//
//  NSTimer+addition.h
//  WYHomeLoopView
//
//  Created by 王启镰 on 16/5/5.
//  Copyright © 2016年 wanglijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)

/**
 * 暂停 
 */
- (void)pause;
/**
 * 恢复
 */
- (void)resume;
/**
 * 恢复的时间间隔
 * @paramet time:时间间隔
 */
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

@end
