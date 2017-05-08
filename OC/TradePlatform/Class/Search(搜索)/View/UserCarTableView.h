//
//  UserCarTableView.h
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserCarTableViewDelegate <NSObject>

@optional
- (void)userCarTableDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface UserCarTableView : UIView

/** 客户车辆table */
@property (strong, nonatomic) UITableView *userCarTable;
/** 客户车辆信息数据 */
@property (strong, nonatomic) NSMutableArray *userCarArray;
/** 点击用户车辆代理 */
@property (assign, nonatomic) id<UserCarTableViewDelegate>delegate;

@end
