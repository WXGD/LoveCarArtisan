//
//  BenefitQuiryView.h
//  TradePlatform
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple. All rights reserved.
//


// 保险查询按钮点击类型
typedef NS_ENUM(NSInteger, BenefitQuiryAction) {
    /** 提交查询 */
    SubmitQueryBtnAction,
    /** 询价记录 */
    InquiryRecordBtnAction,
    /** 出险记录 */
    DangerRecordBtnAction,
    /** 拍摄 */
    ShotBtnAction,
    /** 车牌号 */
    PlnBtnAction,
    /** 省份简称 */
    CaftaBtnAction,
    /** 品牌车型 */
    CarBrandBtnAction,
    /** 车架号 */
    VinBtnAction,
    /** 发动机号 */
    EngineBtnAction,
    /** 初次登记时间 */
    CheckTimeBtnAction,
    /** 所有人 */
    HoldManBtnAction,
};


#import <UIKit/UIKit.h>
// view
#import "PlnCellView.h"

@interface BenefitQuiryView : UIView

/** 提交查询btn */
@property (strong, nonatomic) UIButton *submitQueryBtn;
/** 询价记录 */
@property (strong, nonatomic) UIButton *inquiryRecordBtn;
/** 出险记录 */
@property (strong, nonatomic) UIButton *dangerRecordBtn;
/** 拍摄 */
@property (strong, nonatomic) UIButton *shotBtn;
/** 行驶证图片 */
@property (strong, nonatomic) UIImageView *cardImg;
/** 更换图片 */
@property (strong, nonatomic) UIButton *changeImgBtn;
/** 车牌号view */
@property (strong, nonatomic) UITextField *plnTF;
@property (strong, nonatomic) UIButton *plnBtn;
@property (strong, nonatomic) CaftaBtn *caftaBtn;
/** 品牌车型 */
@property (strong, nonatomic) UsedCellView *carBrandView;
/** 车架号 */
@property (strong, nonatomic) UsedCellView *vinView;
/** 发动机号 */
@property (strong, nonatomic) UsedCellView *engineView;
/** 注册时间 */
@property (strong, nonatomic) UsedCellView *registerTimeView;
/** 所有人 */
@property (strong, nonatomic) UsedCellView *holdManView;

@end
