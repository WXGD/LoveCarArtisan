//
//  CityModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CityModel.h"
#import "FMDB.h"

@interface CityModel ()

@property (nonatomic, strong) FMDatabase *db;


@end

@implementation CityModel

- (instancetype)init {
    self = [super init];
    if (self) {
        // 储存路径
        NSString *cityPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.sqlite"];
        // 打开数据库
        self.db = [FMDatabase databaseWithPath:cityPath];
        [self.db open];
    }
    return self;
}

/** 创建城市列表数据库 */
+ (void)establishCitySqliteForm {
    // 开启一个异步线程
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *cityPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.sqlite"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:cityPath]) { // 文件不存在
            // 创建数据库表
            FMDatabase *db = [FMDatabase databaseWithPath:cityPath];
            [db open];
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS city (id integer PRIMARY KEY, cityName text NOT NULL UNIQUE, cityID text NOT NULL UNIQUE, begins text, phonetic text)"];
            //获取到假数据
            NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dic = [array objectAtIndex:i];
                // 1、转化为可变字符串
                NSMutableString *mutableName = [NSMutableString stringWithString:dic[@"name"]];
                // 2、转化为带音调的拼音
                CFStringTransform((CFMutableStringRef) mutableName, NULL, kCFStringTransformMandarinLatin, NO);
                // 3、去掉音调
                CFStringTransform((CFMutableStringRef) mutableName, NULL, kCFStringTransformStripDiacritics, NO);
                // 4、截取首字母
                NSString *firstName = [mutableName substringToIndex:1];
                NSString *str = [firstName uppercaseString];
                NSString *strmutableName = [mutableName stringByReplacingOccurrencesOfString:@" " withString:@""];
                [db executeUpdateWithFormat:@"INSERT INTO city (cityName, cityID, begins, phonetic) VALUES (%@, %@, %@, %@);", dic[@"name"], dic[@"area_id"], str, strmutableName];
            }
        }
    });
}
/** 添加城市数据 */
- (void)addCityData:(NSArray *)cityArray {
    // 开启一个异步线程
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < cityArray.count; i++) {
            NSDictionary *dic = [cityArray objectAtIndex:i];
            // 转化为可变字符串
            NSMutableString *mutableName = [NSMutableString stringWithString:dic[@"name"]];
            // 转化为带音调的拼音
            CFStringTransform((CFMutableStringRef) mutableName, NULL, kCFStringTransformMandarinLatin, NO);
            // 去掉音调
            CFStringTransform((CFMutableStringRef) mutableName, NULL, kCFStringTransformStripDiacritics, NO);
            // 截取首字母
            NSString *firstName = [mutableName substringToIndex:1];
            // 首字母大写
            NSString *str = [firstName uppercaseString];
            // 拼音去掉空格
            NSString *strmutableName = [mutableName stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self.db executeUpdateWithFormat:@"INSERT INTO city (cityName, cityID, begins, phonetic) VALUES (%@, %@, %@, %@);", dic[@"name"], dic[@"area_id"], str, strmutableName];
        }
    });
}

/** 模糊查询城市数据 */
- (void)fuzzyQueryCityDataQueryText:(NSString *)chineseText englishText:(NSString *)englishText success:(void(^)(NSMutableDictionary *cityDic, NSMutableArray *dicKeys))success {
    // 初始化一个字典，用来保存分组后的所有的模型数据
    NSMutableDictionary *cityDic = [[NSMutableDictionary alloc] init];
    FMResultSet * set = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM city WHERE cityName LIKE '%%%@%%' AND phonetic LIKE '%%%@%%';", chineseText, englishText]];
//    FMResultSet * set = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM city WHERE phonetic LIKE '%%%@%%';", englishText]];
    while (set.next) {
        CityModel *city = [[CityModel alloc] init];
        city.cityName = [set stringForColumn:@"cityName"];
        city.cityID = [set stringForColumn:@"cityID"];
        city.begins = [set stringForColumn:@"begins"];
        if ([cityDic.allKeys containsObject:city.begins]) {
            [cityDic[city.begins] addObject:city];
        }else {
            NSMutableArray *cityArray = [[NSMutableArray alloc] init];
            [cityArray addObject:city];
            [cityDic setObject:cityArray forKey:city.begins];
        }
    }
    // 对分组进行排序
    NSMutableArray *dicKeys = [NSMutableArray arrayWithArray:cityDic.allKeys];
    [dicKeys sortUsingSelector:@selector(compare:)];
    if (success) {
        success(cityDic, dicKeys);
    }
}


/** 获取所有城市模型数据，并进行分组 */
- (void)requestWholeCityDataBlock:(void(^)(NSMutableDictionary *cityDic, NSMutableArray *dicKeys))block {
    // 初始化一个字典，用来保存分组后的所有的模型数据
    NSMutableDictionary *cityDic = [[NSMutableDictionary alloc] init];
    FMResultSet * set = [self.db executeQuery:@"SELECT * FROM city;"];
    while (set.next) {
        CityModel *city = [[CityModel alloc] init];
        city.cityName = [set stringForColumn:@"cityName"];
        city.cityID = [set stringForColumn:@"cityID"];
        city.begins = [set stringForColumn:@"begins"];
        if ([cityDic.allKeys containsObject:city.begins]) {
            [cityDic[city.begins] addObject:city];
        }else {
            NSMutableArray *cityArray = [[NSMutableArray alloc] init];
            [cityArray addObject:city];
            [cityDic setObject:cityArray forKey:city.begins];
        }
    }
    // 对分组进行排序
    NSMutableArray *dicKeys = [NSMutableArray arrayWithArray:cityDic.allKeys];
    [dicKeys sortUsingSelector:@selector(compare:)];
    if (block) {
        block(cityDic, dicKeys);
    }
}

/** 网络请求所有城市数据， */
- (void)networkRequestWholeCityData {
    /* /index.php?c=usedcar_area&a=list&v=1    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_area", @"list", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:nil falseDate:@"error" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [self addCityData:responseObject[@"data"]];
        }else {
            
        }
    } failure:^(NSError *error) {
        PDLog(@"%@", error);
    }];
}


@end
