//
//  UserTableView.h
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserTableViewDelegate <NSObject>

@optional
- (void)userTableDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface UserTableView : UIView

/** 客户信息table */
@property (strong, nonatomic) UITableView *userTable;
/** 客户信息数据 */
@property (strong, nonatomic) NSMutableArray *userArray;
/** 点击代理用户代理 */
@property (assign, nonatomic) id<UserTableViewDelegate>delegate;


@end
