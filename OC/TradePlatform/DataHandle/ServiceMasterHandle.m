//
//  ServiceMasterHandle.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServiceMasterHandle.h"

@implementation ServiceMasterHandle

// 声明一个静态变量
static ServiceMasterHandle *sharedInstance = nil;
+ (ServiceMasterHandle *)sharedInstance {
    if (sharedInstance == nil) {
        // 如果单例对象不存在，那么创建一个单例对象
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self serviceMasterHandleLoadData];
    }
    return self;
}

- (void)serviceMasterHandleLoadData {
    // 获取商户信息user
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    /*/index.php?c=staff_user&a=list&v=1
     provider_id 	int 	是 	服务商id  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"staff_user", @"list", APIEdition];
    // 网络请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"provider_id"] = merchantInfo.provider_id; // 服务id
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"serviceMaster" parentController:nil success:^(id responseObject) {
        PDLog(@"服务师傅%@", responseObject);
        PDLog(@"服务师傅%@", parameters);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            self.serviceMasterArray = [MerchantInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            self.wholeServiceMasterArray = [[NSMutableArray alloc] init];
            [self.wholeServiceMasterArray addObjectsFromArray:self.serviceMasterArray];
            MerchantInfoModel *wholeMerchant = [[MerchantInfoModel alloc] init];
            wholeMerchant.user_name = @"全部职员";
            wholeMerchant.staff_user_id = @"0";
            [self.wholeServiceMasterArray insertObject:wholeMerchant atIndex:0];
            // 网络请求成功回调
            if (_requestSuccessBlock) {
                _requestSuccessBlock();
            }
        }else {
            sharedInstance = nil;
        }
    } failure:^(NSError *error) {
        sharedInstance = nil;
        PDLog(@"sigln%@", error);
    }];
}

/** 销毁单利 */
+ (void)destroyHandle {
    sharedInstance = nil;
}

@end


