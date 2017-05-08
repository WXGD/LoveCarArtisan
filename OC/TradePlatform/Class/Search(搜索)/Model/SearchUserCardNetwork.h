//
//  SearchUserCardNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCarModel.h"

@interface SearchUserCardNetwork : NSObject

// 下拉刷新
- (void)searchUserCardRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success;
// 上啦加载
- (void)searchUserCardLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success;

@end
