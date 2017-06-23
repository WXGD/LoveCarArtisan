//
//  UserModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJBaseModel.h"
// 用户卡模型
#import "UserMemberCardModel.h"
// 赠品模型
#import "CancellationModel.h"
// 用户车辆模型
#import "UserCarModel.h"

@interface UserModel : GJBaseModel

/*   "provider_user_id": 1  #用户id,
 "mobile": "13021960147"  #用户手机号,
 "name": "许继雪"  #用户名称,
 "gender": "未知"  #用户性别,
 "avatar_thumb": "http://image.cheweifang.cn/"  #用户头像,
 "card_num": 1  #会员卡数,
 "car_plate_no": "豫A98309"  #用户默认车辆车牌号,
 "car_brand_series": "奥迪S5 Coupe"  #车辆型号,
 "car_brand_image": "http://image.cheweifang.cn/parentbrand/aodi.jpg"  #车辆品牌图标 */

/** 用户id */
@property (nonatomic, assign) NSInteger provider_user_id;
/** 用户手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 用户名 */
@property (nonatomic, copy) NSString *name;
/** 用户性别 */
@property (nonatomic, copy) NSString *gender;
/** 用户头像 */
@property (nonatomic, copy) NSString *avatar_thumb;
/** 会员卡数 */
@property (nonatomic, assign) NSInteger card_num;
/** 用户默认车辆车牌号 */
@property (nonatomic, copy) NSString *car_plate_no;
// 省份简称
@property (nonatomic, copy) NSString *province_CAFTA;
// 车牌号码
@property (nonatomic, copy) NSString *car_plate_num;
/** 车辆品牌图标 */
@property (nonatomic, copy) NSString *car_brand_image;
/** 车辆型号 */
@property (nonatomic, copy) NSString *car_brand_series;
/** 用户车辆列表 */
@property (nonatomic, strong) NSMutableArray *car;


/*"name": ""  #用户名,
 "mobile": "13021960147"  #用户手机号,
 "avatar_original": ""  #用户头像,
 "car_plate_no": "123333"  #默认车辆车牌号*/
/** 用户头像 */
@property (nonatomic, copy) NSString *avatar_original;

/***  订单详情中 的用户信息
 "name": "许继雪"  #用户名称,
 "mobile": "13021960147"  #用户手机号,
 "car_plate_no": ""  #用户车牌号
  status = "-1"; #用户状态（-1:已删除。1:没有删除）
 */
/** 用户状态（-1:已删除。1:没有删除）） */
@property (nonatomic, assign) NSInteger status;

/**** 收银查询用户信息
 "car_plate_no" = "";
 "is_completed" = 0;
 mobile = 18521516231;
 name = "";
 "provider_user_id" = 25; **/
/** 用户信息是否完善 （0:不完善。1:完善） */
@property (nonatomic, assign) NSInteger is_completed;

/**  "provider_user_id": 1  #用户id,
 "name": "许继雪"  #用户姓名,
 "mobile": "13021960147"  #用户手机号,
 "avatar_thumb": "http://image.cheweifang.cn/"  #用户头像
 "consume_time": "2017-03-07"  #最后一次消费时间*/
/** 最后一次消费时间 */
@property (nonatomic, copy) NSString *consume_time;
// 自加字段
/** 当前选中标记 */
@property (nonatomic, assign) BOOL checkMark;

/** 获取用户详细信息 */
+ (void)requestUserDetailsInfo:(NSMutableDictionary *)params success:(void(^)(UserModel *userInfo))success;
/** 删除用户 */
+ (void)deleteUserParams:(NSMutableDictionary *)params success:(void(^)())success;
/** 获取用户手机号和车牌号 （开卡，自定义开卡） */
+ (void)requestUserPhoneAndPln:(NSMutableDictionary *)params success:(void(^)(UserModel *userInfo))success;

/** 下拉刷新 */
- (void)userRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success;
/** 上啦加载 */
- (void)userLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *userArray))success;

@end

