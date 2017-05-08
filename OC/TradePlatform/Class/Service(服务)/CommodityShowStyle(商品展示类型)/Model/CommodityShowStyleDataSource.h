//
//  CommodityShowStyleDataSource.h
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GJBaseDataSource.h"
#import "CommodityShowStyleModel.h"
#import "CommodityShowStyleCell.h"


@interface CommodityShowStyleDataSource : NSObject

/** cell数 */
@property (nonatomic, strong) NSMutableArray *rowArray;

// 上架服务
- (void)shelvesServiceParams:(NSMutableDictionary *)params success:(void(^)())success;
// 下架服务
- (void)deleServiceParams:(NSMutableDictionary *)params success:(void(^)())success;
// 下拉刷新
- (void)commodityRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSInteger arrayCount))success;
// 上啦加载
- (void)commodityLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)())success;

@end
