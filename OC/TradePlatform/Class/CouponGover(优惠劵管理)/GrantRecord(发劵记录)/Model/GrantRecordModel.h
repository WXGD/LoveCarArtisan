//
//  GrantRecordModel.h
//  TradePlatform
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrantRecordModel : NSObject

/** "coupon_grant_record_id": 3  #用户优惠券id,
 "coupon_record_no": "00166593"  #用户优惠券编码,
 "name": "test"  #优惠券名称,
 "money": "10.00"  #优惠券面值,
 "available_start_time": "2017-06-06"  #可使用开始日期,
 "available_end_time": ""  #可使用结束日期，为空表示不限制,
 "mobile": "18790522222"  #用户手机号,
 "car_plate_no": "豫GME000"  #用户默认车牌号,
 "status": 0  #使用状态 0-待使用 1-已使用 **/

/** 用户优惠券id */
@property (assign, nonatomic) NSInteger coupon_grant_record_id;
/** 用户优惠券编码 */
@property (assign, nonatomic) NSInteger coupon_record_no;
/** 优惠券名称 */
@property (copy, nonatomic) NSString *name;
/** 面值 */
@property (assign, nonatomic) double money;
/** 可使用开始日期 */
@property (copy, nonatomic) NSString *available_start_time;
/** 可使用结束日期，为空表示不限制 */
@property (copy, nonatomic) NSString *available_end_time;
/** 用户手机号 */
@property (copy, nonatomic) NSString *mobile;
/** 用户默认车牌号 */
@property (copy, nonatomic) NSString *car_plate_no;
/** 使用状态 0-待使用 1-已使用 */
@property (assign, nonatomic) NSInteger status;

// 下拉刷新
- (void)grantRecordRefresh:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *grantRecordArray))success;
// 上啦加载
- (void)grantRecordLoad:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *grantRecordArray))success;
/** 作废用户优惠卷 */
+ (void)invalidUserCoupon:(NSMutableDictionary *)params success:(void(^)())success;

@end
