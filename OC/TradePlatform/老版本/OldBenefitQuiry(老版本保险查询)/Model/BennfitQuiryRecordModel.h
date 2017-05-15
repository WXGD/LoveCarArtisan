//
//  BennfitQuiryRecordModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BennfitQuiryRecordModel : NSObject

/**    "car_plate_no" = "豫A88888";
 "end_time" = "2018-03-31";
 "engine_num" = 123456789;
 "license_brand_model" = "一汽大众菠萝1.5L";
 mobile = "";
 "register_time" = "2017-03-01 10:51:01";
 status = 1;
 vin = 654123sdfa5642;    **/


/** 车牌号 */
@property (copy, nonatomic) NSString *car_plate_no;
/** 过期时间 */
@property (copy, nonatomic) NSString *end_time;
/** 发动机号 */
@property (copy, nonatomic) NSString *engine_num;
/** 品牌名称 */
@property (copy, nonatomic) NSString *license_brand_model;
/** 手机号 */
@property (copy, nonatomic) NSString *mobile;
/** 初次登记时间 */
@property (copy, nonatomic) NSString *register_time;
/** 车架号 */
@property (copy, nonatomic) NSString *vin;
/** 状态 */
@property (assign, nonatomic) NSInteger status;

// 下拉刷新,请求保险查询记录
- (void)requestCardTypeListDataParams:(NSMutableDictionary *)params tableView:(UITableView *)tableView success:(void(^)(NSMutableArray *bennfitQuiryRecordArray))success;
// 上啦加载,请求保险查询记录
- (void)userCardLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *bennfitQuiryRecordArray))success;
// 新增车险接口(输入)
+ (void)addBenefitQuiryTextFieldParams:(NSMutableDictionary *)params success:(void(^)())success;
// 新增车险接口(图片上传)
+ (void)addBenefitQuiryImageViewParams:(NSMutableDictionary *)params drivingPermitImage:(UIImage *)drivingPermitImage success:(void(^)())success;

@end
