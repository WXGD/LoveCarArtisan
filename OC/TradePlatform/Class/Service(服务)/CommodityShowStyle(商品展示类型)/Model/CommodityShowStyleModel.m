//
//  CommodityShowStyleModel.m
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommodityShowStyleModel.h"

@implementation CommodityShowStyleModel

- (void)setName:(NSString *)name {
    _name = name;
    self.chioceCategoriesName = name;
    _goods_name = name;
}

- (void)setGoods_name:(NSString *)goods_name {
    _goods_name = goods_name;
    self.chioceCategoriesName = goods_name;
    _name = goods_name;
}


- (void)setGoods_id:(NSInteger)goods_id {
    _goods_id = goods_id;
    self.chioceCategoriesId = goods_id;
}





// 获取全部商品
+ (void)requesCommodityListDataParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *commodityList))success {
    /*/index.php?c=goods&a=list&v=1
     provider_id 	int 	是 	服务id
     goods_category_id 	int 	否 	商品分类id，(获取某类商品中必传)  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"goods", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在加载商品数据..." falseDate:@"providerWholeCommodity" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *commodityList = [CommodityShowStyleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(commodityList);
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
