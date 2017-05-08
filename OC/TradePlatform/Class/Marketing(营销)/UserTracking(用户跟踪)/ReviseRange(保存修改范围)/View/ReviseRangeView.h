//
//  ReviseRangeView.h
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviseRangeFootView.h"

@protocol ReviseRangeDelegate <NSObject>

@optional
- (void)delReviseRangeDelegate;

@end

@interface ReviseRangeView : UIView

/** 背景table */
@property (strong, nonatomic) UITableView *rangeTableView;
/** 区间数据 */
@property (strong, nonatomic) NSMutableArray *rangeArray;
/** 添加区间数据 */
@property (strong, nonatomic) ReviseRangeFootView *reviseRangeFootView;
/** 代理 */
@property (assign, nonatomic) id<ReviseRangeDelegate>delegate;

@end
