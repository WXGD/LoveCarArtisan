//
//  BenefitFirmModel.h
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BenefitFirmModel : NSObject

/** "insurance_company_id": 1  #保险公司id,
 "name": "阳光保险"  #保险公司名称,
 "icon_thumb": ""  #保险公司图标**/
/** 保险公司id */
@property (assign, nonatomic) NSInteger insurance_company_id;
/** 险种名称 */
@property (copy, nonatomic) NSString *name;
/** 保险公司图标 */
@property (copy, nonatomic) NSString *icon_thumb;
/***** 自加字段 *******/
/** 选中标记 */
@property (nonatomic, assign) BOOL checkMark;

// 请求保险公司
+ (void)requestBenefitFirmSuccess:(void(^)(NSMutableArray *benefitFirmArray))success;
// 添加保险询价
+ (void)addBenefitInquiryParame:(NSMutableDictionary *)parame modifyImage:(UIImage *)modifyImage success:(void(^)())success;

@end
