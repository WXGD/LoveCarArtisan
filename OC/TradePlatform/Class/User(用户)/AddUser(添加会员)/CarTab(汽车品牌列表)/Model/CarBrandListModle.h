//
//  CarBrandListModle.h
//  CarRepairFactory
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//  车品牌类别模型

#import <Foundation/Foundation.h>

@interface CarBrandListModle : NSObject

/*"hot_brand":热门品牌
"brand":非热门品牌*/
/** 热门品牌 */
@property (nonatomic, strong) NSArray *hot_brand;
/** 非热门品牌 */
@property (nonatomic, strong) NSArray *brand;

@end
