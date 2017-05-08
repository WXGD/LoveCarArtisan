//
//  ReviseRangeFootView.h
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RangeView.h"

@interface ReviseRangeFootView : UIView

/** 新增view */
@property (strong, nonatomic) RangeView *addRangeView;
/** 新增标题 */
@property (strong, nonatomic) UILabel *addRangeLabel;

@end
