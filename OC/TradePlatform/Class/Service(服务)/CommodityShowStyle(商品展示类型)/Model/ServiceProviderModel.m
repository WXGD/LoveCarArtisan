//
//  ServiceProviderModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServiceProviderModel.h"

@implementation AdminServiceModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"used_goods_category" : [ServiceProviderModel class], @"unUsed_goods_category" : [ServiceProviderModel class]};
}

@end


@implementation ServiceProviderModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods" : [CommodityShowStyleModel class]};
}


- (void)setName:(NSString *)name {
    _name = name;
    self.chioceCategoriesName = name;
    _goods_category_name = name;
}

- (void)setGoods_category_name:(NSString *)goods_category_name {
    _goods_category_name = goods_category_name;
    self.chioceCategoriesName = goods_category_name;
    _name = goods_category_name;
}


- (void)setGoods_category_id:(NSInteger)goods_category_id {
    _goods_category_id = goods_category_id;
    self.chioceCategoriesId = goods_category_id;
}





// 获取全部服务项目(不包含全部类型)
+ (void)requesServiceListDataParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *serviceList))success {
    /*/index.php?c=goods_category&a=list&v=1
     provider_id 	int 	是 	服务商id
     start 	int 	否 	记录开始位置,默认为0
     pageSize 	int 	否 	每页显示条数，默认为0 (代表全部)     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods_category", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在获取商品类型..." falseDate:@"providerService" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *commodityTypeArray = [ServiceProviderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(commodityTypeArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


// 获取全部服务项目(包含全部类型)
+ (void)requestServiceTypeListParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *commodityTypeArray))success {
    /*/index.php?c=goods_category&a=list&v=1
     provider_id 	int 	是 	服务商id
     start 	int 	否 	记录开始位置,默认为0
     pageSize 	int 	否 	每页显示条数，默认为0 (代表全部)     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods_category", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在获取商品类型..." falseDate:@"providerService" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *commodityTypeArray = [ServiceProviderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            ServiceProviderModel *wholeCommodityTypeModel = [[ServiceProviderModel alloc] init];
            wholeCommodityTypeModel.goods_category_id = 0;
            wholeCommodityTypeModel.name = @"全部";
            [commodityTypeArray insertObject:wholeCommodityTypeModel atIndex:0];
            // 请求成功
            if (success) {
                success(commodityTypeArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
    
}


// 获取全部服务商品
+ (void)requestServiceCommodityParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *serviceCommodityArray))success {
    /*/index.php?c=goods_category&a=detail&v=1
     provider_id 	int 	是 	服务商id      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods_category", @"detail", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在获取商品..." falseDate:@"wholeServiceCommodity" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *commodityTypeArray = [ServiceProviderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(commodityTypeArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
    
}


@end
