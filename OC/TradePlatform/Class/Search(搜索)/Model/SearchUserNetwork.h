//
//  SearchUserNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface SearchUserNetwork : NSObject


// 下拉刷新
- (void)searchUserRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success;
// 上啦加载
- (void)searchUserLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success;


@end
