//
//  PendOrderModel.h
//  TradePlatform
//
//  Created by 祝豪杰 on 17/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCartModel.h"

@interface PendOrderModel : NSObject

/**  挂单列表接口
 "cart_id": 1  #购物车id,
 "sale_user_id": 1  #服务师傅id,
 "mobile": "13021960148"  #手机号,
 "car_plate_no": "豫A90909"  #车牌号,
 "total_price": "220.00"  #总价,
 "mileage": "10.00"  #行驶里程,
 "next_maintain": "2017-04-27 00:00:00"  #下次保养时间,
 "create_time": "2017-04-28 09:16:04"  #添加时间,
 "detail": [ { "goods":{ },
 "goods_category":{ }  ]
 **/

/** 购物车id */
@property(nonatomic, assign) NSInteger cart_id;
/** 服务师傅id */
@property(nonatomic, assign) NSInteger sale_user_id;
/** 手机号 */
@property(nonatomic, copy) NSString *mobile;
/** 车牌号 */
@property(nonatomic, copy) NSString *car_plate_no;
/** 总价 */
@property(nonatomic, assign) double total_price;
/** 行驶里程 */
@property(nonatomic, copy) NSString *mileage;
/** 下次保养时间 */
@property(nonatomic, copy) NSString *next_maintain;
/** 添加时间 */
@property(nonatomic, copy) NSString *create_time;
/** 挂单商品列表 */
@property(nonatomic, strong) NSArray *detail;


// 下拉刷新
- (void)orderRefreshRequestData:(UITableView *)tableView
                         params:(NSMutableDictionary *)params
                 viewController:(UIViewController *)viewController
                        success:(void (^)(NSMutableArray *orderArray))success;
// 上啦加载
- (void)orderLoadRequestData:(UITableView *)tableView
                      params:(NSMutableDictionary *)params
              viewController:(UIViewController *)viewController
                     success:(void (^)(NSMutableArray *orderArray))success;

// 判断是否有挂单数据
+ (void)judgeCartDataParams:(NSMutableDictionary *)params success:(void(^)(BOOL cart))success;

@end

