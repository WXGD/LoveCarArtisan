//
//  CarBrandHandle.m
//  CarRepairFactory
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarBrandHandle.h"
//#import "BrandModel.h"
#import "CarBrandListModle.h"
#import "CarBrandModel.h"

@implementation CarBrandHandle

// 声明一个静态变量
static CarBrandHandle *sharedInstance = nil;
+ (CarBrandHandle *)sharedInstance {
    if (sharedInstance == nil) {
        // 如果单例对象不存在，那么创建一个单例对象
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.groupArray = [[NSMutableArray alloc] init];
        self.modelSectionArray = [[NSMutableArray alloc] init];
        self.hotBrandArray = [[NSMutableArray alloc] init];
        [self carBrandHandleLoadData];
    }
    return self;
}

- (void)carBrandHandleLoadData {
    /*/index.php?c=car_brand_series&a=list&v=1*/
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"car_brand_series", @"list", APIEdition];
    [TPNetRequest GET:URL parameters:nil ProgressHUD:@"正在加载品牌数据..." falseDate:@"CarBrandTab" parentController:nil success:^(id responseObject) {
        PDLog(@"%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            CarBrandListModle *brandModleDic = [CarBrandListModle mj_objectWithKeyValues:responseObject[@"data"]];
            // 保存热门品牌数据
            self.hotBrandArray = brandModleDic.hot_brand;
            // 初始化一个字典，用来保存所有分组后到数据
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            // 便利所有模型，将他们进行分组
            for (CarBrandModel *brand in brandModleDic.brand) {
                // 判断数据字典中是否包含当前模型所在到分组
                if ([dic.allKeys containsObject:brand.first_letter]) {
                    // 如果有，将当前模型添加到对应分组中
                    [dic[brand.first_letter] addObject:brand];
                }else { // 如果没有
                    // 创建一个分组，
                    NSMutableArray *dicValue = [[NSMutableArray alloc] init];
                    // 将当前模型添加到新创建的分组中
                    [dicValue addObject:brand];
                    // 将新创建的分组，添加到数据字典中
                    [dic setValue:dicValue forKey:brand.first_letter];
                }
            }
            // 当字典的key放入一个可辨数组中
            NSMutableArray *dataGroups = [NSMutableArray arrayWithArray:dic.allKeys];
            // 对字典的key进行排序
            [dataGroups sortUsingSelector:@selector(compare:)];
            // 创建的一个数组，用来保存所有的模型分组
            NSMutableArray *modelGroups = [[NSMutableArray alloc] init];
            // 便利排序后字典所有的key
            for (NSString *dKey in dataGroups) {
                // 将key对应的分组，放入模型分组中
                [modelGroups addObject:dic[dKey]];
            }
            // 保存所有模型分组
            self.modelSectionArray = modelGroups;
            // 保存所有字典的key
            self.groupArray = dataGroups;
            // 成功回调
            if (_carBrandNetSucBlock) {
                _carBrandNetSucBlock(self.groupArray, self.modelSectionArray, self.hotBrandArray);
            }
        }else {
            sharedInstance = nil;
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        sharedInstance = nil;
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];

    
    
    
    
    
    
    
    
    
//    // 拼接请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    // 获取用户信息UserInfo
//    UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoRoute];
//    params[@"tel"] = userInfo.vip_mobile;
//    params[@"action"] = @"brand";
//    NSMutableDictionary *parameters = [NetParameter paramsAddThreeKey:params];
//    // 拼接接口
//    NSString *urlStr = [urlAdd stringByAppendingString:@"car_zone.php"];
//    
//    [CWENetwork tokenPOST:urlStr parameters:parameters ProgressHUD:nil falseDate:@"CarTab" parentController:nil success:^(id responseObject) {
//        PDLog(@"%@", urlStr);
//        PDLog(@"%@", parameters);
//        PDLog(@"%@", responseObject);
//        NSString *error_code = [NSString stringWithFormat:@"%@", responseObject[@"result"][@"error_code"]];
//        if ([responseObject[@"status"] isEqualToString:@"3"]) {
//            [MBProgressHUD showError:responseObject[@"code"]];
//            sharedInstance = nil;
//        }else if (![error_code isEqualToString:@"0"]) {
//            [MBProgressHUD showError:responseObject[@"result"][@"reason"]];
//            sharedInstance = nil;
//        }else {
//            NSArray *newModelArray = [BrandModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"result"][@"detail"]];
//            // 初始化一个字典，用来保存所有分组后到数据
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//            // 便利所有模型，将他们进行分组
//            for (BrandModel *brand in newModelArray) {
//                // 判断数据字典中是否包含当前模型所在到分组
//                if ([dic.allKeys containsObject:brand.firstLetter]) {
//                    // 如果有，将当前模型添加到对应分组中
//                    [dic[brand.firstLetter] addObject:brand];
//                }else { // 如果没有
//                    // 创建一个分组，
//                    NSMutableArray *dicValue = [[NSMutableArray alloc] init];
//                    // 将当前模型添加到新创建的分组中
//                    [dicValue addObject:brand];
//                    // 将新创建的分组，添加到数据字典中
//                    [dic setValue:dicValue forKey:brand.firstLetter];
//                }
//            }
//            // 当字典的key放入一个可辨数组中
//            NSMutableArray *dataGroups = [NSMutableArray arrayWithArray:dic.allKeys];
//            // 对字典的key进行排序
//            [dataGroups sortUsingSelector:@selector(compare:)];
//            // 创建的一个数组，用来保存所有的模型分组
//            NSMutableArray *modelGroups = [[NSMutableArray alloc] init];
//            // 便利排序后字典所有的key
//            for (NSString *dKey in dataGroups) {
//                // 将key对应的分组，放入模型分组中
//                [modelGroups addObject:dic[dKey]];
//            }
//            // 保存所有模型分组
//            self.modelSectionArray = modelGroups;
//            // 保存所有字典的key
//            self.groupArray = dataGroups;
//            // 成功回调
//            if (_carBrandNetSucBlock) {
//                _carBrandNetSucBlock(self.groupArray, self.modelSectionArray);
//            }
//        }
//    } failure:^(NSError *error) {
//        sharedInstance = nil;
//    }];
}


@end
