//
//  CardApplyViewController.h
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

// 会员卡适用范围使用类型
typedef NS_ENUM(NSInteger, CardApplyUseType) {
    /** 新增卡使用 */
    AddCardUseType,
    /** 修改卡信息使用 */
    ChangeCardInfoUseType,
    /** 自定义开卡，修改卡信息使用 */
    CustomOpenCardChangeCardInfoUseType,
};


#import "RootViewController.h"
// view
#import "CardApplyView.h"
// 模型
#import "CardTypeModel.h"

@interface CardApplyViewController : RootViewController

/** 会员卡适用范围View */
@property (strong, nonatomic) CardApplyView *cardApplyView;
/** 会员卡适用范围使用类型 */
@property (assign, nonatomic) CardApplyUseType cardApplyUseType;
/** 选中的商品 */
@property (strong, nonatomic) NSMutableArray *chooseCommodityArray;
/** 选中的服务 */
@property (strong, nonatomic) NSMutableArray *chooseServiceArray;
/** 全部服务商品 */
@property (strong, nonatomic) NSMutableArray *wholeCommodityArray;
/** 选择完成后回diao */
@property (copy, nonatomic) void(^confirmApply)(NSMutableArray *wholeCommodityArray, NSMutableArray *chooseCommodityArray, NSMutableArray *chooseServiceArray);

/** 卡信息模型 */
@property (assign, nonatomic) CardTypeModel *cardInfoModel;

@end
