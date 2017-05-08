//
//  UserDataSource.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJBaseDataSource.h"
#import "UserCell.h"

@interface UserDataSource : GJBaseDataSource

// 下拉刷新
- (void)userRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSInteger arrayCount))success;
// 上啦加载
- (void)userLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)())success;

@end
