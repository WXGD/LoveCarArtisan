//
//  ExpircUserModel.h
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpircUserModel : NSObject

/**  "card_category_id": 1  #卡类别id， 1-次卡 2-余额卡,
 "num": 11  #可用次数,
 "money": "0"  #可用余额,
 "end_time": ""  #过期时间,
 "mobile": "13021960147"  #用户手机号,
 "user_name": ""  #用户名称,
 "car_plate_no": "豫A98300"  #默认车牌号,
 "card_name": "测试"  #卡名称    **/

/** 卡类别id 1-次卡 2-余额卡 */
@property (assign, nonatomic) NSInteger card_category_id;
/** 可用次数 */
@property (assign, nonatomic) NSInteger num;
/** 可用余额 */
@property (assign, nonatomic) double money;
/** 过期时间 */
@property (copy, nonatomic) NSString *end_time;
/** 用户手机号 */
@property (copy, nonatomic) NSString *mobile;
/** 用户名称 */
@property (copy, nonatomic) NSString *user_name;
/** 默认车牌号 */
@property (copy, nonatomic) NSString *car_plate_no;
/** 卡名称 */
@property (copy, nonatomic) NSString *card_name;


// 下拉刷新
- (void)expircUserRefreshRequestData:(NSMutableDictionary *)params tableView:(UITableView *)tableView success:(void(^)(NSMutableArray *expircUserArray))success;
// 上啦加载,请求保险查询记录
- (void)expircUserLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *expircUserArray))success;


@end
