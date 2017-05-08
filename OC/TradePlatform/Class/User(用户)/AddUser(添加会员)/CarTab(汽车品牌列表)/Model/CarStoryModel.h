//
//  CarStoryModel.h
//  CarRepairFactory
//
//  Created by apple on 2016/11/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarStoryModel : NSObject




/*car_brand_series_id = 379;
 name = Terraza;
 pid = 363;*/
/** id标识 */
@property (nonatomic, assign) NSInteger car_brand_series_id;
/** 子品牌名称 */
@property (nonatomic, copy) NSString *name;
/** 车型id */
@property (nonatomic, assign) NSInteger pid;

@end
