//
//  PhotographViewController.h
//  TradePlatform
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 apple. All rights reserved.
//



// 扫一扫界面展示类型
typedef NS_ENUM(NSInteger, PhotographViewType) {
    /** 收银使用 */
    CashierAssignment,
    /** 自定义开卡使用 */
    CustomOpenCardAssignment,
    /** 保险查询使用 */
    BenefitQuiryAssignment,
};

#import "RootViewController.h"

@interface PhotographViewController : RootViewController

/** 界面展示类型 */
@property (assign, nonatomic) PhotographViewType photographViewType;
/** 识别成功回调 */
@property (copy, nonatomic) void(^DistinguishSuccessBlock)(NSMutableDictionary *plnPhoto);

@end
