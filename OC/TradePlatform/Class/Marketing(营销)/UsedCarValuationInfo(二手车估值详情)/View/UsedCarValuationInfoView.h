//
//  UsedCarValuationInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsedCarValuationInfoView : UIView

/** 车商收购价 */
@property (strong, nonatomic) UsedCellView *buyPriceView;
/** 个人交易价 */
@property (strong, nonatomic) UsedCellView *dealPriceView;
/** 车牌型号 */
@property (strong, nonatomic) UILabel *carBrandDetails;
/** 所在城市 */
@property (strong, nonatomic) UsedCellView *cityView;
/** 首次上牌 */
@property (strong, nonatomic) UsedCellView *firstFailingView;
/** 行驶里程 */
@property (strong, nonatomic) UsedCellView *mileageView;
/** 车况 */
@property (strong, nonatomic) UsedCellView *conditionView;
/** 车辆用途 */
@property (strong, nonatomic) UsedCellView *carUseView;
/** 车辆购入价 */
@property (strong, nonatomic) UsedCellView *carBuyPriceView;


@end
