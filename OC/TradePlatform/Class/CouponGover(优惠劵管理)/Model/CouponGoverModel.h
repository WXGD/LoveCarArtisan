//
//  CouponGoverModel.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllService.h"

@interface CouponGoverModel : NSObject


/*** "coupon_id": 1  #优惠券id,
 "name": "test"  #优惠券名称,
 "money": "10.00"  #面值,
 "full_money": "10.00"  #满多少可用 0.00代表不限制,
 "description": "2222"  #描述,
 "grant_start_time": "2017-06-08"  #发放日期,
 "grant_end_time": "2017-06-09"  #发放结束日期，空表示不限制,
 "num": 0  #发放总量,为零表示不限制,
 "expire_day": 0  #领取之后可以可使用天数,为0表示不限制,
 "limit_num_type": 1  #0-不限制，一人可领多张 1-限制一人只能领一 ,
 "status": 1  #0-禁用状态 1-启用状态,
 "used_goods":[1,2],
 "is_grant": 1  #1-可发放 0-不可发放**/

/** 优惠券id */
@property (assign, nonatomic) NSInteger coupon_id;
/** 优惠券名称 */
@property (copy, nonatomic) NSString *name;
/** 面值 */
@property (assign, nonatomic) double money;
/** 满多少可用 */
@property (assign, nonatomic) double full_money;
/** 描述 */
@property (copy, nonatomic) NSString *descri;
/** 发放日期 */
@property (copy, nonatomic) NSString *grant_start_time;
/** 发放结束日期，空表示不限制 */
@property (copy, nonatomic) NSString *grant_end_time;
/** 发放总量,为零表示不限制 */
@property (assign, nonatomic) NSInteger num;
/** 可发放数量 */
@property (assign, nonatomic) NSInteger available_num;
/** 领取之后可以可使用天数,为0表示不限制 */
@property (assign, nonatomic) NSInteger expire_day;
/** 0-不限制，一人可领多张 1-限制一人只能领一 */
@property (assign, nonatomic) NSInteger limit_num_type;
/** 0-禁用状态 1-启用状态 */
@property (assign, nonatomic) NSInteger status;
/** 适用服务 **/
@property (nonatomic, strong) AllService *all_service;
/** 1-可发放 0-不可发放 */
@property (assign, nonatomic) NSInteger is_grant;
/** 标记是否选中 */
@property (nonatomic, assign) BOOL checkMark;

/** 下拉刷新 */
- (void)couponGoverRefresh:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *couponListArray))success;
/** 上啦加载 */
- (void)couponGoverLoad:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *couponListArray))success;
/** 编辑优惠劵状态 */
+ (void)editCouponState:(NSMutableDictionary *)params success:(void(^)())success;
/** 请求全部优惠劵种类 */
+ (void)requesWholeCouponType:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *couponListArray))success;

@end




