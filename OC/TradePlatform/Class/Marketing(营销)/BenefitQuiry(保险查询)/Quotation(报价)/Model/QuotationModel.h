//
//  QuotationModel.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  报价列表
  "insurance_categorys": "交强险(50.00万),交强险",
  "insurance_quote":[
     "insurance_quote_id": 20  #报价id,
     "total_price": "0.00"  #合计保费,
     "discount": "0.00"  #折扣,
     "actual_total_price": "0.00"  #实付保费,
     "insurance_company_name": "人保车险"  #保险公司名称,
     "insurance_company_icon": ""  #保险公司图标
    ]
 **/
@class InsuranceQuoteModel;
@interface QuotationModel : NSObject


@property (nonatomic, strong) NSArray<InsuranceQuoteModel *> *insurance_quote;

@property (nonatomic, copy) NSString *insurance_categorys;

// 方案报价
- (void)quotationRefreshRequestData:(UITableView *)tableView
                                 params:(NSMutableDictionary *)params
                         viewController:(UIViewController *)viewController
                                success:(void (^)(NSMutableArray *orderArray))success;
@end


@interface InsuranceQuoteModel : NSObject
/** 折扣 */
@property (nonatomic, assign) double discount;
/** 报价id */
@property (nonatomic, copy) NSString *insurance_quote_id;
/** 保险公司图标 */
@property (nonatomic, copy) NSString *insurance_company_icon;
/** 合计保费 */
@property (nonatomic, assign) double total_price;
/** 实付保费 */
@property (nonatomic, assign) double actual_total_price;
/** 保险公司名称 */
@property (nonatomic, copy) NSString *insurance_company_name;

@end

