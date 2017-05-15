//
//  QuotationView.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuotationModel.h"
#import "InquiryRecordModel.h"

@interface QuotationView : UIView

/** 方案数 */
@property (strong, nonatomic) NSMutableArray *schemeArray;
/** 方案页全部数据 */
@property (strong, nonatomic) NSMutableArray *dataArray;
/** 询价记录model **/
@property (strong ,nonatomic) InquiryRecordModel *inquiryModel;
/** 选择银行 **/
@property(copy, nonatomic) void (^policyDetail)(InsuranceQuoteModel *insuranceQuoteModel);
@end
