//
//  InquiryRecordModel.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  询价列表接口
 "insurance_query_id": 3  #记录列表id,
 "name": "许"  #姓名,
 "car_plate_no": "豫A12345"  #车牌号,
 "license_brand_model": "22222"  #品牌车型,
 "create_time": "2016-04-30 00:00:00"  #创建时间,
 "status": 3  #报价状态 1-报价中 2-已报价 3,4,5-报价失败,
 "fail_reason": "强制险还在保期"  #报价失败原因,
 "remark": ""  #备注
 **/
@interface InquiryRecordModel : NSObject
/** 记录列表id */
@property(nonatomic, copy) NSString *insurance_query_id;
/** 姓名 */
@property(nonatomic, copy) NSString *name;
/** 车牌号 */
@property(nonatomic, copy) NSString *car_plate_no;
/** 品牌车型 */
@property(nonatomic, copy) NSString *license_brand_model;
/** 备注 */
@property(nonatomic, copy) NSString *remark;
/** 创建时间 */
@property(nonatomic, copy) NSString *create_time;
/** 报价状态 */
@property(nonatomic, assign) NSInteger status;
/** 报价失败原因 */
@property(nonatomic, copy) NSString *fail_reason;
/** 手机号 */
@property(nonatomic, copy) NSString *mobile;

// 下拉刷新
- (void)inquiryRecordRefreshRequestData:(UITableView *)tableView
                         params:(NSMutableDictionary *)params
                 viewController:(UIViewController *)viewController
                        success:(void (^)(NSMutableArray *orderArray))success;
// 上啦加载
- (void)inquiryRecordRequestData:(UITableView *)tableView
                      params:(NSMutableDictionary *)params
              viewController:(UIViewController *)viewController
                     success:(void (^)(NSMutableArray *orderArray))success;

@end
