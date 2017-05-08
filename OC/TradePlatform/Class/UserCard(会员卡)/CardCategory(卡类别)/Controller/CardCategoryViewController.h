//
//  CardCategoryViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

// 卡类别界面展示类型
typedef NS_ENUM(NSInteger, CardCategoryExhibitionType) {
    /** 修改卡类别 */
    ChangeCardCategoryAssignment,
    /** 不修改卡类别 */
    NOChangeCardCategoryAssignment,
};

#import "RootViewController.h"
#import "CardCategoryDataSource.h"
// 模型
#import "CardTypeModel.h"

@interface CardCategoryViewController : RootViewController

@property (strong, nonatomic) void(^CardTypeChioceBlock)(CardCategoryModel *cardCategoryModel);
/** 当前选中的卡类别名称 */
@property (copy, nonatomic) NSString *cardCategoryName;
/** 会员卡类别列表 */
@property (strong, nonatomic) NSMutableArray *cardCategoryArray;
/** 卡类别界面展示 */
@property (assign, nonatomic) CardCategoryExhibitionType cardCategoryType;
/** 卡信息模型 */
@property (assign, nonatomic) CardTypeModel *cardInfoModel;

@end
