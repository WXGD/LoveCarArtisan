//
//  EditCommodityViewController.h
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//
// 修改商品信息界面展示类型
typedef NS_ENUM(NSInteger, ChangeCommodityInfoExhibitionType) {
    /** 商品名称 */
    ChangeCommodityNameAssignment,
    /** 销售价 */
    ChangePresentPriceAssignment,
    /** 原价 */
    ChangeOriginalPriceAssignment,
};


#import "RootViewController.h"
#import "CommodityShowStyleModel.h"

@interface EditCommodityViewController : RootViewController

// 商品模型
@property (nonatomic, strong) CommodityShowStyleModel *commodityShowModel;
/** 信息界面展示类型 */
@property (assign, nonatomic) ChangeCommodityInfoExhibitionType changeCommodityInfoType;
/** 修改完成回调 */
@property (copy, nonatomic) void(^editCommoditySuccessBlock)(NSString *editContent);

@end
