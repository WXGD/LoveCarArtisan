//
//  CarBrandModel.h
//  CarRepairFactory
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarBrandModel : NSObject

/*"car_brand_series_id": 165  #品牌id,
 "name": "中欧"  #品牌名称,
 "image": "http://image.cheweifang.cn/parentbrand/zhongou.jpg"  #品牌图片,
 "first_letter": "Z"  #首字母*/

/** 品牌id */
@property (nonatomic, assign) NSInteger car_brand_series_id;
/** 品牌名称 */
@property (nonatomic, copy) NSString *name;
/** 品牌logo地址 */
@property (nonatomic, copy) NSString *image;
/** 品牌首字母 */
@property (nonatomic, copy) NSString *first_letter;

@end
