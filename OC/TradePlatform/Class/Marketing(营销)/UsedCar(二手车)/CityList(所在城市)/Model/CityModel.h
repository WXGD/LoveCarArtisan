//
//  CityModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

/** 城市名 */
@property (nonatomic, copy) NSString *cityName;
/** 城市ID */
@property (nonatomic, copy) NSString *cityID;
/** 城市名首字母 */
@property (nonatomic, copy) NSString *begins;
/** 添加城市数据 */
- (void)addCityData:(NSArray *)cityArray;
/** 获取所有城市模型数据，并进行分组 */
- (void)requestWholeCityDataBlock:(void(^)(NSMutableDictionary *cityDic, NSMutableArray *dicKeys))block;
/** 模糊查询城市数据 */
- (void)fuzzyQueryCityDataQueryText:(NSString *)chineseText englishText:(NSString *)englishText success:(void(^)(NSMutableDictionary *cityDic, NSMutableArray *dicKeys))success;
/** 网络请求所有城市数据， */
- (void)networkRequestWholeCityData;
/** 创建城市列表数据库 */
+ (void)establishCitySqliteForm;

@end
