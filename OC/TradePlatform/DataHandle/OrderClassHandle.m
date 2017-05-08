//
//  OrderClassHandle.m
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderClassHandle.h"

@implementation OrderClassHandle

// 声明一个静态变量
static OrderClassHandle *sharedInstance = nil;
+ (OrderClassHandle *)sharedInstance {
    if (sharedInstance == nil) {
        // 如果单例对象不存在，那么创建一个单例对象
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.orderWholeClassArray = [[NSMutableArray alloc] init];
        [self requesOrderClassData];
    }
    return self;
}

// 获取商家订单类型数据
- (void)requesOrderClassData {
    /*/index.php?c=order_category&a=list&v=1  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order_category", @"list", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:nil falseDate:@"ServiceItems" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            self.orderClassArray = [OrderClassModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.orderWholeClassArray addObjectsFromArray:self.orderClassArray];
            // 全部
            OrderClassModel *wholeClass = [[OrderClassModel alloc] init];
            wholeClass.order_category_id = 0;
            wholeClass.name = @"全部类别";
            [self.orderWholeClassArray insertObject:wholeClass atIndex:0];
            // 请求成功
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


