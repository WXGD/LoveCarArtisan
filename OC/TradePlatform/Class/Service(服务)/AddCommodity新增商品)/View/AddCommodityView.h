//
//  AddCommodityView.h
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//



// 添加商品页面按钮点击类型
typedef NS_ENUM(NSInteger, AddCommodityBottonAction) {
    /** 商品类别 */
    CommodityCategoriesBottonAction,
};


#import <UIKit/UIKit.h>

@interface AddCommodityView : UIView

/** 商品类别 */
@property (strong, nonatomic) UsedCellView *commodityCategories;
/** 商品名称 */
@property (strong, nonatomic) UsedCellView *commodityName;
/** 商品原价 */
@property (strong, nonatomic) UsedCellView *commodityOriginalPrice;
/** 商品销售价 */
@property (strong, nonatomic) UsedCellView *commodityPresentPrice;
/** 聚合信息 */
@property (strong, nonatomic) RACSignal *aggregationInfo;


@end
