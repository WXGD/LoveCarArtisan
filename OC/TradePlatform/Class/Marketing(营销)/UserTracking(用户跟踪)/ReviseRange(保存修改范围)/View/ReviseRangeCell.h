//
//  ReviseRangeCell.h
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpireModel.h"
// view
#import "RangeView.h"

@interface ReviseRangeCell : UITableViewCell

/** 区间参数 */
@property (strong, nonatomic) ExpireModel *expireModel;
/** cell样式 */
@property (strong, nonatomic) RangeView *rangeView;

@end
