//
//  UserCarOptNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserCarOptNetwork : NSObject


// 下拉刷新
- (void)userCarOptRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCarOptArray))success;
// 上啦加载
- (void)userCarOptLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCarOptArray))success;

@end
