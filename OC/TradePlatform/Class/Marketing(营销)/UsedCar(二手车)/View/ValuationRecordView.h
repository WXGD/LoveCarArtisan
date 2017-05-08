//
//  ValuationRecordView.h
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leftRigText.h"

@interface ValuationRecordView : UIView

/** 车牌号 */
@property (strong, nonatomic) UILabel *plnLabel;
/** 车牌型号 */
@property (strong, nonatomic) UILabel *carBrandLabel;
/** 车辆所在地区 */
@property (strong, nonatomic) UILabel *cityLabel;
/** 上牌时间 */
@property (strong, nonatomic) UILabel *failingTimeLabel;
/** 估计View */
@property (strong, nonatomic) UIView *valuationView;
/** 回收价格 */
@property (strong, nonatomic) leftRigText *tecoveryPriceLabel;
/** 销售价格 */
@property (strong, nonatomic) leftRigText *sellingPriceLabel;
/** 估价失败 */
@property (strong, nonatomic) UILabel *valuationErrorView;

@end
