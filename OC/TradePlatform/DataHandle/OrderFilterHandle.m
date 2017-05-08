//
//  OrderFilterHandle.m
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderFilterHandle.h"

@implementation OrderFilterHandle

// 声明一个静态变量
static OrderFilterHandle *sharedInstance = nil;
+ (OrderFilterHandle *)sharedInstance {
    if (sharedInstance == nil) {
        // 如果单例对象不存在，那么创建一个单例对象
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self requesOrderFilterData];
    }
    return self;
}

// 获取订单筛选
- (void)requesOrderFilterData {
    /*/index.php?c=order&a=condition&v=1
     provider_id 	int 	是 	服务商id   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"condition", APIEdition];
    // 获取商户信息user
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = merchantInfo.provider_id; // 服务商id
    // 发送请求
    [TPNetRequest GET:URL parameters:params ProgressHUD:@"加载中..." falseDate:@"FilterCondition" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            self.orderFilterArray = [FilterConditionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (_requestCategorySuccessBlock) {
                _requestCategorySuccessBlock();
            }
            sharedInstance = nil;
        }else {
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



