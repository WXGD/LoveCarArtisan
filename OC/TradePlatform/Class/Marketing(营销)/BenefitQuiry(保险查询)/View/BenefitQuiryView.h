//
//  BenefitQuiryView.h
//  TradePlatform
//
//  Created by apple on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//
// 保险查询点击类型
typedef NS_ENUM(NSInteger, BenefitQuiryBottonAction) {
    /** 车牌号 */
    PlnBtnAction,
    /** 品牌车型 */
    CarBrandBtnAction,
    /** 车架号 */
    VinBtnAction,
    /** 发动机号 */
    EngineBtnAction,
    /** 初次登记时间 */
    CheckTimeBtnAction,
    /** 提交查询 */
    SubmitQueryBtnAction,
    /** 拍摄行驶证查询 */
    ShotQueryBtnAction,
};

#import <UIKit/UIKit.h>
#import "QuiryRecordCell.h"

/** 查询历史点击代理 */
@protocol QuiryRecordChoiceDelegate <NSObject>

@optional
- (void)quiryRecordChoiceCell:(NSIndexPath *)indexPath quiryRecordModel:(BennfitQuiryRecordModel *)quiryRecordModel;

@end

@interface BenefitQuiryView : UIView

/** 保险选项卡ScrollView */
@property (strong, nonatomic) UIScrollView *benTabScorllView;
/** 车牌号 */
@property (strong, nonatomic) UsedCellView *plnView;
/** 品牌车型 */
@property (strong, nonatomic) UsedCellView *carBrandView;
/** 车架号 */
@property (strong, nonatomic) UsedCellView *vinView;
/** 发动机号 */
@property (strong, nonatomic) UsedCellView *engineView;
/** 初次登记时间 */
@property (strong, nonatomic) UsedCellView *checkTimeView;
@property (strong, nonatomic) UIButton *checkTimeButton;
/** 提交查询 */
@property (strong, nonatomic) UIButton *submitQueryBtn;
/** 拍摄行驶证查询 */
@property (strong, nonatomic) UIButton *shotQueryBtn;
/** 查询历史点击代理 */
@property (assign, nonatomic) id<QuiryRecordChoiceDelegate>delegate;
/** 查询记录table */
@property (strong, nonatomic) UITableView *quiryRecordTableView;
/** 查询记录数据 */
@property (strong, nonatomic) NSMutableArray *quiryRecordArray;

// tab按钮选择
- (void)benefitTabBtnAction:(UIButton *)button;


@end
