//
//  GrantView.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "SearchView.h"

@interface GrantView : UIView

/** 发劵用户view */
@property (strong, nonatomic) SearchView *grantUserSearchView;
/** 用户table */
@property (strong, nonatomic) UITableView *userTable;
/** 用户table数据 */
@property (strong, nonatomic) NSMutableArray *userArray;
/** 确认发劵 */
@property (strong, nonatomic) UIButton *grantBtn;

@end
