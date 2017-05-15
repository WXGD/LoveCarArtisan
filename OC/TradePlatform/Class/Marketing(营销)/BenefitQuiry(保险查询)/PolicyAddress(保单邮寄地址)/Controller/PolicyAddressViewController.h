//
//  PolicyAddressViewController.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
//model
#import "QuotationModel.h"
#import "InquiryRecordModel.h"

@interface PolicyAddressViewController : RootViewController
/** 询价子类model */
@property (nonatomic, strong)InsuranceQuoteModel *insuranceQuoteModel;
/** 车辆model */
@property (nonatomic, strong)InquiryRecordModel *inquiryRecordModel;
@end
