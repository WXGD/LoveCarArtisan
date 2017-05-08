//
//  CWFUserCarModel.h
//  CarRepairFactory
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWFUserCarModel : NSObject


/*  "provider_user_car_id": 1  #用户车辆id,
 "car_plate_no": "豫A98309"  #车牌号,
 "is_default": 1  #是否是默认车辆 1-默认车辆,
 "car_brand_series": "S5 Coupe"  #车辆品牌型号名,
 "image": ""  #车品牌图片,
 "car_brand_name": ""  #车品牌名称,
 "car_series_name": "S5 Coupe"  #车车系名称 **/

/** 用户车辆id */
@property (nonatomic, copy) NSString *provider_user_car_id;
/** 车牌号 */
@property (nonatomic, copy) NSString *car_plate_no;
/** 是否是默认车辆 1-默认车辆 */
@property (nonatomic, copy) NSString *is_default;
/** 车辆品牌型号名 */
@property (nonatomic, copy) NSString *car_brand_series;
/** 车品牌图片 */
@property (nonatomic, copy) NSString *image;
/** 车品牌名称 */
@property (nonatomic, copy) NSString *car_brand_name;
/** 车车系名称 */
@property (nonatomic, copy) NSString *car_series_name;
/** 添加用户车辆所用数据 */
/** 车品牌ID */
@property (nonatomic, copy) NSString *car_brand_id;
/** 车系ID */
@property (nonatomic, copy) NSString *car_series_id;

@end
