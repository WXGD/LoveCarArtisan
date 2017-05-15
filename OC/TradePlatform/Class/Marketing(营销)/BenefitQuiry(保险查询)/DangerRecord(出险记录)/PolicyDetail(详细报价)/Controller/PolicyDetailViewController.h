//
//  PolicyDetailViewController.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
//model
#import "QuotationModel.h"
#import "PolicyDetailModel.h"
#import "InquiryRecordModel.h"
#import "DangerRecordModel.h"

@interface PolicyDetailViewController : RootViewController
/** 询价:1  出险：2 */
@property (nonatomic, assign)NSInteger whereFrom;
/** 保险公司信息model */
@property (nonatomic, strong)InsuranceQuoteModel *insuranceQuoteModel;
/** 车辆model */
@property (nonatomic, strong)InquiryRecordModel *inquiryRecordModel;
/**出现列表model */
@property (nonatomic, strong)DangerRecordModel *dangerRecordModel;
@end
