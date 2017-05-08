//
//  UserCardListNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
// 数据模型
#import "UserMemberCardModel.h"

@interface UserCardListNetwork : NSObject

// 下拉刷新
- (void)cardListRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCardArray))success;
// 上啦加载
- (void)cardListLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCardArray))success;

@end
