//
//  WebProgressLayer.h
//  CarRepairFactory
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface WebProgressLayer : CAShapeLayer

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
