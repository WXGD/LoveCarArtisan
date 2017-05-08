//
//  AllGoodsHandle.m
//  TradePlatform
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AllGoodsHandle.h"

@implementation AllGoodsHandle

// 声明一个静态变量
static AllGoodsHandle *sharedInstance = nil;
+ (AllGoodsHandle *)sharedInstance {
    if (sharedInstance == nil) {
        // 如果单例对象不存在，那么创建一个单例对象
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self allGoodsHandleLoadData];
    }
    return self;
}

- (void)allGoodsHandleLoadData {
    /*/index.php?c=goods_category&a=detail&v=1
     provider_id 	int 	是 	服务商id      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods_category", @"detail", APIEdition];
    // 获取商户信息user
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    // 请求商品类型
    /*/index.php?c=goods_category&a=detail&v=1
     provider_id 	int 	是 	服务商id      */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = merchantInfo.provider_id; // 服务商id
    // 发送请求
    [TPNetRequest GET:URL parameters:params ProgressHUD:@"加载中..." falseDate:@"wholeServiceCommodity" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            self.wholeServiceGoodsArray = [ServiceProviderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 网络请求成功回调
            if (_requestSuccessBlock) {
                _requestSuccessBlock(self.wholeServiceGoodsArray);
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
