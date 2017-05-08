//
//  NewsModel.h
//  TradePlatform
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

/**  "title": "付款成功通知"  #消息标题,
 "content": "会员消费1元已到帐"  #消息内容,
 "create_time": "2017-02-21 10:56:42"  #发送时间,
 "status": 0  #处理状态 0-未读 1-已读 */
/** 消息标题 */
@property (copy, nonatomic) NSString *title;
/** 消息内容 */
@property (copy, nonatomic) NSString *content;
/** 发送时间 */
@property (copy, nonatomic) NSString *create_time;
/** 处理状态 */
@property (assign, nonatomic) NSInteger status;

// 下拉刷新
- (void)newsRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *newsArray))success;
// 上啦加载
- (void)newsLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *newsArray))success;


@end
