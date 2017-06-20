//
//  CouponModel.h
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject


/** 优惠券数组 */
@property (strong, nonatomic) NSArray *coupons;
/** 可用优惠券总数 */
@property (assign, nonatomic) NSInteger useful_count;
/** 不可用总数 */
@property (assign, nonatomic) NSInteger unuseful_count;

// 下拉刷新
- (void)couponRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(CouponModel *couponModel))success;
// 上啦加载
- (void)couponLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(CouponModel *couponModel))success;

@end


@interface CouponInfoModel : NSObject

/** "coupon_grant_record_id": 3  #用户优惠券id,
 "name": "test"  #优惠券名称,
 "money": "10.00"  #优惠券面值,
 "description": "2222"  #优惠券描述,
 "full_money": "1.00"  #满多少可用，为0.00表示不限制,
 "available_start_time": "2017-06-06"  #可使用开始日期,
 "available_end_time": ""  #可使用结束日期，为空表示不限制 */

/** 用户优惠券id */
@property (assign, nonatomic) NSInteger coupon_grant_record_id;
/** 优惠券名称 */
@property (copy, nonatomic) NSString *name;
/** 优惠券面值 */
@property (assign, nonatomic) double money;
/** 优惠券描述 */
@property (copy, nonatomic) NSString *descri;
/** 满多少可用 */
@property (assign, nonatomic) double full_money;
/** 可使用开始日期 */
@property (copy, nonatomic) NSString *available_start_time;
/** 可使用结束日期 */
@property (copy, nonatomic) NSString *available_end_time;
// 自加字段
/** 当前选中标记 */
@property (nonatomic, assign) BOOL checkMark;
/** 0-不可用 1-可用 默认为1  */
@property (nonatomic, assign) BOOL is_useful;


/**  商家优惠券模型
 "coupon_id": 1  #优惠券id,
 "name": "test"  #优惠券名称,
 "money": "10.00"  #面值,
 "description": "2222"  #描述,
 "available_start_time": "2017-06-08"  #可使用开始日期,
 "available_end_time": "2017-06-09"  #可使用结束日期**/
/** 优惠券id */
@property (assign, nonatomic) NSInteger coupon_id;
/** 标记是否可以赠送 0-不赠送 1-可赠送 */
@property (nonatomic, assign) BOOL markGive;

// 请求商家优惠券列表
+ (void)requestMerchantCouponListParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *couponArray))success;
// 商家赠送优惠券列表
+ (void)merchantGiveCouponListParams:(NSMutableDictionary *)params success:(void(^)())success;

@end
