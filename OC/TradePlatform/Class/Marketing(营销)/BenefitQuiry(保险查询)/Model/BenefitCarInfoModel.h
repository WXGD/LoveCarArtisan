//
//  BenefitCarInfoModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BenefitCarInfoModel : NSObject

/**  "license_brand_model": "比亚迪Y123"  #车牌型号,
 "engine_num": "11"  #发动机号,
 "vin": "11123333322"  #车架号,
 "register_time": "0000-00-00 00:00:00"  #初次登记时间    **/


/** 车牌型号 */
@property (copy, nonatomic) NSString *license_brand_model;
/** 发动机号 */
@property (copy, nonatomic) NSString *engine_num;
/** 车架号 */
@property (copy, nonatomic) NSString *vin;
/** 初次登记时间 */
@property (copy, nonatomic) NSString *register_time;


// 通过车牌号查询车辆信息接口
+ (void)usePlnQuiryCarInfo:(NSMutableDictionary *)params success:(void(^)(BenefitCarInfoModel *carInfo))success;


@end
