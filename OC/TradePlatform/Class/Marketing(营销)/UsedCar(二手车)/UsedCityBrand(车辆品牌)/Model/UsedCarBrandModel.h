//
//  UsedCarBrandModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsedCarBrandModel : NSObject

/** "brand_series_id": "2000386"  #品牌车系车型d,
 "name": "AC",
 "image_src": "http://image.cheweifang.cn"  #品牌图标  
 */

/** 品牌id */
@property (nonatomic, assign) NSInteger brand_series_id;
/** 品牌名 */
@property (nonatomic, copy) NSString *name;
/** 品牌图标 */
@property (nonatomic, copy) NSString *image_src;
/** "car_model_id" = 车型id;
 name = 车型名  **/
/** 车型id */
@property (nonatomic, assign) NSInteger car_model_id;


/** 获取所有品牌 */
+ (void)requestWholeCarBrand;


@end
