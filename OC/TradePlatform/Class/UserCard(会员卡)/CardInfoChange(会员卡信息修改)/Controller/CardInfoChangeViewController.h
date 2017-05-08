//
//  CardInfoChangeViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

// 修改卡信息界面展示类型
typedef NS_ENUM(NSInteger, ChangeCardInfoExhibitionType) {
    /** 卡名称 */
    ChangeCardNameAssignment,
    /** 卡销售价 */
    ChangeCardPresentPriceAssignment,
    /** 卡原价 */
    ChangeCardOriginalPriceAssignment,
    /** 卡可用次数 */
    ChangeCardNumberAssignment,
    /** 卡可用金额 */
    ChangeCardMoneyAssignment,
};

#import "RootViewController.h"
// 模型
#import "CardTypeModel.h"

@interface CardInfoChangeViewController : RootViewController

/** 卡信息模型 */
@property (assign, nonatomic) CardTypeModel *cardInfoModel;
/** 卡信息界面展示类型 */
@property (assign, nonatomic) ChangeCardInfoExhibitionType changeCardInfoType;
/** 修改成功回调 */
@property (copy, nonatomic) void(^CardInfoChangeSuccessBlock)(CardTypeModel *cardInfoModel);

@end
