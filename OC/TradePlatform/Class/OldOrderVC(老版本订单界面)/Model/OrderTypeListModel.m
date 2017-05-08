//
//  OrderTypeListModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderTypeListModel.h"

@implementation OrderTypeListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}



- (void)setOrder_category_id:(NSInteger)order_category_id {
    _order_category_id = order_category_id;
    self.chioceCategoriesId = order_category_id;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.chioceCategoriesName = name;
}


// 获取商家订单类型数据
+ (void)requesOrderTypeListDataSuccess:(void(^)(NSMutableArray *orderList))success {
    /*/index.php?c=order_category&a=list&v=1  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order_category", @"list", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:@"正在加载订单类型..." falseDate:@"ServiceItems" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *orderList = [OrderTypeListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 全部
            OrderTypeListModel *wholeClass = [[OrderTypeListModel alloc] init];
            wholeClass.order_category_id = 0;
            wholeClass.name = @"全部类别";
            wholeClass.currentTitle = YES;
            [orderList insertObject:wholeClass atIndex:0];
            // 请求成功
            if (success) {
                success(orderList);
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
