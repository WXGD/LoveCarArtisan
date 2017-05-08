//
//  ServiceCategoryHandle.m
//  TradePlatform
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServiceCategoryHandle.h"

@implementation ServiceCategoryHandle

// 声明一个静态变量
static ServiceCategoryHandle *sharedInstance = nil;
+ (ServiceCategoryHandle *)sharedInstance {
    if (sharedInstance == nil) {
        // 如果单例对象不存在，那么创建一个单例对象
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.serviceWholeCategoryArray = [[NSMutableArray alloc] init];
        [self serviceCategoryHandleLoadData];
    }
    return self;
}

- (void)serviceCategoryHandleLoadData {
    // 获取商户信息user
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    /*/index.php?c=goods_category&a=list&v=1
     provider_id 	int 	是 	服务商id
     start 	int 	否 	记录开始位置,默认为0
     pageSize 	int 	否 	每页显示条数，默认为0 (代表全部)     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods_category", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = merchantInfo.provider_id; // 服务商id
    // 发送请求
    [TPNetRequest GET:URL parameters:params ProgressHUD:nil falseDate:@"providerService" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            self.serviceCategoryArray = [ServiceProviderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.serviceWholeCategoryArray addObjectsFromArray:self.serviceCategoryArray];
            
            ServiceProviderModel *wholeCommodityTypeModel = [[ServiceProviderModel alloc] init];
            wholeCommodityTypeModel.goods_category_id = 0;
            wholeCommodityTypeModel.name = @"全部";
            [self.serviceWholeCategoryArray insertObject:wholeCommodityTypeModel atIndex:0];
            // 网络请求成功回调
            if (_requestCategorySuccessBlock) {
                _requestCategorySuccessBlock();
            }
            
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

