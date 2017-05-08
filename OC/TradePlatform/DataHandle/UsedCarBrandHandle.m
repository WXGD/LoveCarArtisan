//
//  UsedCarBrandHandle.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarBrandHandle.h"

@implementation UsedCarBrandHandle

// 声明一个静态变量
static UsedCarBrandHandle *sharedInstance = nil;
+ (UsedCarBrandHandle *)sharedInstance {
    if (sharedInstance == nil) {
        // 如果单例对象不存在，那么创建一个单例对象
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self usedCarBrandHandleLoadData];
    }
    return self;
}

- (void)usedCarBrandHandleLoadData {
    // 初始化一个字典，用来保存分组后的所有的模型数据
    self.usedCarBrandDic = [[NSMutableDictionary alloc] init];
    /* /index.php?c=usedcar_brand_series&a=list&v=1    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_brand_series", @"list", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:nil falseDate:@"CarBrandTab" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *usedCarBrandArray = [UsedCarBrandModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (UsedCarBrandModel *usedCarBrandModel in usedCarBrandArray) {
                // 转化为可变字符串
                NSMutableString *usedCarBrandName = [NSMutableString stringWithString:usedCarBrandModel.name];
                // 转化为带音调的拼音
                CFStringTransform((CFMutableStringRef) usedCarBrandName, NULL, kCFStringTransformMandarinLatin, NO);
                // 去掉音调
                CFStringTransform((CFMutableStringRef) usedCarBrandName, NULL, kCFStringTransformStripDiacritics, NO);
                // 截取首字母
                NSString *firstName = [usedCarBrandName substringToIndex:1];
                NSString *str = [firstName uppercaseString];
                // 判断字典中是否有当前分组，如果有将品牌模型填入当前分组中，如果没有创建新的分组
                if ([self.usedCarBrandDic.allKeys containsObject:str]) {
                    [self.usedCarBrandDic[str] addObject:usedCarBrandModel];
                }else {
                    NSMutableArray *usedCarBrandArray = [[NSMutableArray alloc] init];
                    [usedCarBrandArray addObject:usedCarBrandModel];
                    [self.usedCarBrandDic setObject:usedCarBrandArray forKey:str];
                }
            }
            // 对分组进行排序
            self.usedCarBrandDicKeys = [NSMutableArray arrayWithArray:self.usedCarBrandDic.allKeys];
            [self.usedCarBrandDicKeys sortUsingSelector:@selector(compare:)];
            // 网络请求成功回调
            if (_requestUsedCarBrandBlock) {
                _requestUsedCarBrandBlock();
            }
        }else {
            // 网络请求成功回调
            if (_requestUsedCarBrandBlock) {
                _requestUsedCarBrandBlock();
            }
            sharedInstance = nil;
        }
    } failure:^(NSError *error) {
        sharedInstance = nil;
        PDLog(@"%@", error);
    }];
}

/** 销毁单利 */
+ (void)destroyHandle {
    sharedInstance = nil;
}

@end

