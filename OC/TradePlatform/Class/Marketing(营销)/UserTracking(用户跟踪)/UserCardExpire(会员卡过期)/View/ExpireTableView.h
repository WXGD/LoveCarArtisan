//
//  ExpireTableView.h
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "ExpireCell.h"
#import "ExpireHeaderView.h"

@protocol ExpireTableDelegate <NSObject>

@optional
- (void)seleAreaBtnAction;

@end

@interface ExpireTableView : UIView

/** 过期array */
@property (strong, nonatomic) NSMutableArray *expireArray;
/** 代理 */
@property (assign, nonatomic) id<ExpireTableDelegate>delegate;
/** tabl头部view */
@property (strong, nonatomic) ExpireHeaderView *expireHeaderView;
/** 过期table */
@property (strong, nonatomic) UITableView *expireTable;
/** cell样式 */
@property (assign, nonatomic) ExpireCellType expireCellType;

@end
