//
//  MyAccountView.h
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "MyAccountHeaderView.h"
#import "PostalRecordCell.h"

@protocol MyAccountDelegate <NSObject>

@optional
// 提现记录cell点击代理
- (void)postalRecordCellDidSelect:(WithdrawRecordModel *)model;

@end

@interface MyAccountView : UIView

/** 代理 */
@property (assign, nonatomic) id<MyAccountDelegate>delegate;

/** 头部view */
@property (strong, nonatomic) MyAccountHeaderView *headerView;
/** 提现记录table */
@property (strong, nonatomic) UITableView *postalRecordTable;

/** 提现记录tableArr */
@property (strong, nonatomic) NSMutableArray *recordArray;
@end
