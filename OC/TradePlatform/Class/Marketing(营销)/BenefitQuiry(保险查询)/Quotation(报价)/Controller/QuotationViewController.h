//
//  QuotationViewController.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "InquiryRecordModel.h"

@interface QuotationViewController : RootViewController
/** 询价记录model **/
@property (strong ,nonatomic) InquiryRecordModel *inquiryModel;
@end
