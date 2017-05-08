//
//  DateReportCellView.h
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateReportCellView : UIView

/** 日期 */
@property (strong, nonatomic) UILabel *dateLable;
/** 客户数量 */
@property (strong, nonatomic) UILabel *customerNmuLable;
/** 客户数量增长率 */
@property (strong, nonatomic) UILabel *customerNmuGrowthRateLable;
/** 交易额 */
@property (strong, nonatomic) UILabel *turnoverLable;
/** 交易额增长率 */
@property (strong, nonatomic) UILabel *turnoverGrowthRateLable;

@end
