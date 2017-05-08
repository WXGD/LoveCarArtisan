//
//  EditCommodityWholeView.h
//  TradePlatform
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCommodityWholeView : UIView

/** 商品名称 */
@property (strong, nonatomic) UsedCellView *editCommodityName;
/** 商品原价 */
@property (strong, nonatomic) UsedCellView *editCommodityOriginalPrice;
/** 商品销售价 */
@property (strong, nonatomic) UsedCellView *editCommodityPresentPrice;
/** 聚合信息 */
@property (strong, nonatomic) RACSignal *editAggregationInfo;


@end
