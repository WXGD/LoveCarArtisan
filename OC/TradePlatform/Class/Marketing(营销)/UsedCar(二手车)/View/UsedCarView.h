//
//  UsedCarView.h
//  TradePlatform
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

// 二手车估值点击类型
typedef NS_ENUM(NSInteger, UsedCarValuationBottonAction) {
    /** 车辆型号 */
    CarBrandBtnAction,
    /** 所在城市 */
    CityBtnAction,
    /** 车况 */
    ConditionBtnAction,
    /** 车辆用途 */
    CarUseBtnAction,
    /** 开始估值 */
    StartValuationBtnAction,
};

#import <UIKit/UIKit.h>
// view
#import "ValuationRecordCell.h"

/** 二手车估值详情点击代理 */
@protocol UsedCarValuationInfoChoiceDelegate <NSObject>

@optional
- (void)usedCarValuationInfoChoiceCell:(ValuationNotesModel *)valuationNotesModel;

@end

@interface UsedCarView : UIView

/** 二手车选项卡ScrollView */
@property (strong, nonatomic) UIScrollView *usedCarTabScorllView;
/** 二手车查询历史 */
@property (strong, nonatomic) UIButton *usedCarHistoryBtn;
/** 车辆型号 */
@property (strong, nonatomic) UILabel *carBrandDetails;
@property (strong, nonatomic) UIButton *carBrandBtn;
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
/** 开始估值 */
@property (strong, nonatomic) UIButton *startValuationBtn;
/** 二手车估值详情点击代理 */
@property (assign, nonatomic) id<UsedCarValuationInfoChoiceDelegate>delegate;
/** 查询记录table */
@property (strong, nonatomic) UITableView *valuationRecordTableView;
/** 查询记录数据 */
@property (strong, nonatomic) NSMutableArray *valuationRecordArray;

// tab按钮选择
- (void)usedCarTabBtnAction:(UIButton *)button;

@end
