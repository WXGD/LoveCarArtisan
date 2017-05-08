//
//  UsedCarValuationInfoModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsedCarValuationInfoModel : NSObject


/** "used_date": "2017-01"  #上牌时间,
 "mileage": "0.00"  #行驶里程,
 "purchase_price": "15.00"  #购买价格,
 "sale_price": "18.00"  #出售价格,
 "city_name": "郑州市"  #城市名称,
 "car_model_name": "奥迪SQ5(进口) 2014款 SQ5 3.0TFSI quattro"  #车型名称,
 "purpose_text": "自用"  #用途,
 "car_status_text": "一般"  #车况    **/




/** 上牌时间 */
@property (nonatomic, copy) NSString *used_date;
/** 行驶里程 */
@property (nonatomic, copy) NSString *mileage;
/** 收购价格 */
@property (nonatomic, assign) double purchase_price;
/** 个人交易价格 */
@property (nonatomic, assign) double deal_price;
/** 购买价格 */
@property (nonatomic, assign) double buy_price;
/** 城市名称 */
@property (nonatomic, copy) NSString *city_name;
/** 车型名称 */
@property (nonatomic, copy) NSString *car_model_name;
/** 用途 */
@property (nonatomic, copy) NSString *purpose_text;
/** 车况 */
@property (nonatomic, copy) NSString *car_status_text;
/** 车牌号 */
@property (nonatomic, copy) NSString *car_plate_no;

/** 请求估值详情 */
+ (void)requestUsedCarValuationInfoData:(NSMutableDictionary *)params success:(void(^)(UsedCarValuationInfoModel *valuationInfoModel))success;

@end
