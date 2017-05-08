//
//  CommodityInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

// 服务信息页面按钮点击类型
typedef NS_ENUM(NSInteger, SetUpBottonAction) {
    /** 商品名称 */
    CommodityNameBtnAction,
    /** 销售价 */
    PresentPriceBtnAction,
    /** 原价 */
    OriginalPriceBtnAction,
};


#import <UIKit/UIKit.h>

@interface CommodityInfoView : UIView

/** 商品名称 */
@property (strong, nonatomic) UsedCellView *commodityName;
/** 销售价 */
@property (strong, nonatomic) UsedCellView *presentPrice;
/** 原价 */
@property (strong, nonatomic) UsedCellView *originalPrice;

@end
