//
//  HomePageView.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

// 首页页面按钮点击类型
typedef NS_ENUM(NSInteger, HomePageBottonAction) {
    /** 扫一扫 */
    ScanBtnAction,
    /** 收款 */
    ReceiptBtnAction,
    /** 店铺实时数据 */
    ShowDataBtnAction,
    /** 服务管理 */
    ServiceManageBtnAction,
    /** 会员卡 */
    UserCardBtnAction,
    /** 订单 */
    OrderBtnAction,
    /** 客户 */
    UserBtnAction,
};



#import <UIKit/UIKit.h>
#import "TopBotBtn.h"
#import "ShowDataView.h"

@interface HomePageView : UIView

/** 扫一扫 */
@property (strong, nonatomic) TopBotBtn *scanBtn;
/** 收款 */
@property (strong, nonatomic) TopBotBtn *receiptBtn;
/** 店铺实时数据 */
@property (strong, nonatomic) ShowDataView *showDataView;
/** 服务管理 */
@property (strong, nonatomic) UsedCellView *serviceManageView;
/** 会员卡 */
@property (strong, nonatomic) UsedCellView *userCardView;
/** 订单 */
@property (strong, nonatomic) UsedCellView *orderView;
/** 客户 */
@property (strong, nonatomic) UsedCellView *userView;

@end
