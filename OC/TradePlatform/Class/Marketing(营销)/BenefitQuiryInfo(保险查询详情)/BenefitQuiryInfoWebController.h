//
//  BenefitQuiryInfoWebController.h
//  TradePlatform
//
//  Created by apple on 2017/3/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WebViewController.h"
#import "BennfitQuiryRecordModel.h"

@interface BenefitQuiryInfoWebController : WebViewController

/** url */
@property (nonatomic, copy) NSString *webUrl;
/** 本地路径 */
@property (nonatomic, copy) NSString *localPath;
/** 保险订单模型 */
@property (nonatomic, strong) BennfitQuiryRecordModel *quiryRecordModel;

@end
