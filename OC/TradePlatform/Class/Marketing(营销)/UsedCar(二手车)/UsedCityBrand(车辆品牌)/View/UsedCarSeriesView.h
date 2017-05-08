//
//  UsedCarSeriesView.h
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsedCarSeriesModel.h"

@protocol UsedCarSeriesDelegate <NSObject>

@optional
- (void)UsedCarSeriesSelectCarSeriesModel:(UsedCarBrandModel *)carSeriesModel carBrandModel:(UsedCarBrandModel *)carBrandModel;

@end

@interface UsedCarSeriesView : UIView

/** 车品牌模型 */
@property (strong, nonatomic) UsedCarBrandModel *usedCarBrandModel;
/** 代理 */
@property (assign, nonatomic) id<UsedCarSeriesDelegate>delegate;

@end
