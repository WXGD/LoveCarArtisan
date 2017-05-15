//
//  DangerRecordModel.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "insurance_quote_id": 20  #报价id,
 "owner_name": "11"  #车主姓名,
 "name": "test"  #收件人姓名,
 "mobile": "13021909909"  #收件人手机号,
 "address": "ddddd"  #收件人地址,
 "status": 1  #状态, 1-待支付 2-出保中 3-已出保,
 "car_plate_no": "豫A12345"  #车牌号,
 "license_brand_model": "111"  #车辆型号,
 "total_price": "0.00"  #总保费,
 "discount": "0.00"  #折扣,
 "actual_total_price": "0.00"  #实付金额,
 "insurance_company_name": "人保车险"  #保险公司名称,
 "insurance_company_icon": "http://image.cheweifang.cn/"  #保险公司图标
 **/
@interface DangerRecordModel : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *license_brand_model;

@property (nonatomic, assign) double total_price;

@property (nonatomic, assign) double discount;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *car_plate_no;

@property (nonatomic, copy) NSString *insurance_company_name;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) double actual_total_price;

@property (nonatomic, copy) NSString *insurance_company_icon;

@property (nonatomic, copy) NSString *owner_name;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *insurance_quote_id;


// 下拉刷新
- (void)dangerRecordRefreshRequestData:(UITableView *)tableView
                                params:(NSMutableDictionary *)params
                        viewController:(UIViewController *)viewController
                               success:(void (^)(NSMutableArray *orderArray))success;
// 上啦加载
- (void)dangerRecordRequestData:(UITableView *)tableView
                         params:(NSMutableDictionary *)params
                 viewController:(UIViewController *)viewController
                        success:(void (^)(NSMutableArray *orderArray))success;
@end
