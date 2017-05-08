//
//  ValuationNotesModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValuationNotesModel : NSObject

/**  "usedcar_assess_record_id": 1  #估值记录id,
 "car_plate_no": ""  #车牌号,
 "purchase_price": "15.00"  #购买价格,
 "sale_price": "18.00"  #售价,
 "city_name": "郑州市"  #城市名,
 "brand_series_name": "奥迪SQ5(进口)"  #品牌车系名,
 "create_time": "2017-04-14"  #创建时间  **/


/** 估值记录id */
@property (nonatomic, copy) NSString *usedcar_assess_record_id;
/** 车牌号 */
@property (nonatomic, copy) NSString *car_plate_no;
/** 收购价格 */
@property (nonatomic, assign) double purchase_price;
/** 个人交易价格 */
@property (nonatomic, assign) double deal_price;
/** 购买价格 */
@property (nonatomic, assign) double buy_price;
/** 城市名 */
@property (nonatomic, copy) NSString *city_name;
/** 品牌车系名 */
@property (nonatomic, copy) NSString *brand_series_name;
/** 车品牌系名 */
@property (nonatomic, copy) NSString *car_model_name;
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;



// 下拉刷新,请求估值记录
- (void)usedCarValuationListDataParams:(NSMutableDictionary *)params tableView:(UITableView *)tableView success:(void(^)(NSMutableArray *valuationNotesArray))success;
// 上啦加载,请求估值记录
- (void)usedCarValuationLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *valuationNotesArray))success;

// 添加二手车估值
+ (void)AddUsedCarValuation:(NSMutableDictionary *)params success:(void(^)())success;


@end
