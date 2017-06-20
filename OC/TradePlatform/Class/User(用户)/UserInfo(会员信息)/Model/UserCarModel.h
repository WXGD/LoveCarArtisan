//
//  UserCarModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCarModel : NSObject


/*  "provider_user_car_id": 1  #用户车辆id,
 "car_plate_no": "豫A98309"  #车牌号,
 "is_default": 1  #是否是默认车辆 1-默认车辆,
 "car_brand_series": "S5 Coupe"  #车辆品牌型号名,
 "image": ""  #车品牌图片,
 "car_brand_name": ""  #车品牌名称,
 "car_series_name": "S5 Coupe"  #车车系名称
 "car_brand_id": ""  #1车品牌id,
 "car_brand_series_id": "2"  #车车系id
 mobile:18737141800 #用户手机号 */

/** 用户车辆id */
@property (copy, nonatomic) NSString *provider_user_car_id;
/** 车辆车牌号 */
@property (copy, nonatomic) NSString *car_plate_no;
// 省份简称
@property (nonatomic, copy) NSString *province_CAFTA;
// 车牌号码
@property (nonatomic, copy) NSString *car_plate_num;
/** 是否是默认车辆 1-默认车辆 */
@property (copy, nonatomic) NSString *is_default;
/** 车辆型号 */
@property (copy, nonatomic) NSString *car_brand_series;
/** 车辆品牌图片 */
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *car_brand_image;
/** 车品牌名称 */
@property (copy, nonatomic) NSString *car_brand_name;
/** 车车系名称 */
@property (copy, nonatomic) NSString *car_series_name;
@property (copy, nonatomic) NSString *car_brand_series_name;
/** 车品牌id */
@property (copy, nonatomic) NSString *car_brand_id;
/** 车系id */
@property (copy, nonatomic) NSString *car_brand_series_id;
/** 用户id */
@property (copy, nonatomic) NSString *provider_user_id;
/** 用户手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 行驶证车牌号 */
@property (nonatomic, copy) NSString *license_img;
/** 收银页使用用户车辆  **/
/** 行驶里程 */
@property (nonatomic, copy) NSString *mileage;
/** 下次保养时间 */
@property (nonatomic, copy) NSString *next_maintain;
/** 自加字段，保险询价页使用用户车辆  **/
/** 车架号 */
@property (nonatomic, copy) NSString *vin;
/** 发动机号 */
@property (nonatomic, copy) NSString *engine;
/** 注册时间 */
@property (nonatomic, copy) NSString *register_time;
/** 所有人 */
@property (nonatomic, copy) NSString *hold_man;
/** 行驶证图片 */
@property (nonatomic, strong) UIImage *license_img_img;

/** 请求会员车辆列表 */
+ (void)requestUsreCarListParame:(NSMutableDictionary *)parame success:(void(^)(NSMutableArray *usreCarListArray))success;

@end
