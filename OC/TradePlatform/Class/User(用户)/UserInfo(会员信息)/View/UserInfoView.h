//
//  UserInfoView.h
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

// 会员信息按钮点击类型
typedef NS_ENUM(NSInteger, StoreInfoBottonAction) {
    /** 会员头像，名称，微信号 */
    UserHeaderBtnAction,
    /** 电话 */
    UserPhoneBtnAction,
    /** 会员卡 */
    UserCodeBtnAction,
    /** 消费记录 */
    PurchaseHistoryBtnAction,
    /** 会员车辆 */
    UserCarBtnAction,
    /** 开卡 */
    OpenCardBtnAction,
};


#import <UIKit/UIKit.h>

@protocol UserCarBtnDelegate <NSObject>

@optional
/** 编辑按钮 */
- (void)editCarInfoBtnDelegate:(UIButton *)button;
/** 二手车估值 */
- (void)useCarValuationBtnDelegate:(UIButton *)button;
/** 查保险 */
- (void)quiryBenefitBtnDelegate:(UIButton *)button;
/** 查看行驶证 */
- (void)seeDrivingLicenseBtnDelegate:(UIButton *)button;

@end

@interface UserInfoView : UIView

/** 会员头像，名称，微信号 */
@property (strong, nonatomic) UsedCellView *userHeaderView;
/** 电话 */
@property (strong, nonatomic) UsedCellView *userPhoneView;
/** 消费记录 */
@property (strong, nonatomic) UsedCellView *purchaseHistoryView;
/** 会员卡 */
@property (strong, nonatomic) UsedCellView *userCodeView;
/** 添加会员车辆 */
@property (strong, nonatomic) UsedCellView *userCarView;
/** 会员车辆列表 */
@property (strong, nonatomic) UITableView *userCarTable;
/** 会员车辆数据 */
@property (strong, nonatomic) NSMutableArray *userCarArray;
/** 开卡 */
@property (strong, nonatomic) UIButton *openCardBtn;
/** 代理 */
@property (assign, nonatomic) id<UserCarBtnDelegate>delegate;

@end
