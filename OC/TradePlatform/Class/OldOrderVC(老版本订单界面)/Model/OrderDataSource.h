//
//  OrderDataSource.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJBaseDataSource.h"
#import "OrderModel.h"
#import "OrderCell.h"

@interface OrderDataSource : GJBaseDataSource

// 下拉刷新
- (void)orderRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSInteger arrayCount))success;
// 上啦加载
- (void)orderLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)())success;
 
@end
