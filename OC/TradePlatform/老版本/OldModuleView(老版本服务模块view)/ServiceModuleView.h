//
//  ServiceModuleView.h
//  TradePlatform
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

// 首页服务模块点击类型
typedef NS_ENUM(NSInteger, ServiceModuleBottonAction) {
    /** 服务管理 */
    ServiceManageBtnAction = 3,
    /** 会员卡 */
    UserCardBtnAction = 4,
    /** 客户 */
    CustomerBtnAction = 5,
    /** 订单 */
    OrderBtnAction = 6,
    /**  营销 */
    MarketingBtnAction = 7,
    /** 报表 */
    ReportBtnAction = 8,
    /** 商城 */
    CommercialCityBtnAction = 9,
    /** 账户 */
    AccountBtnAction = 10,
    /** 门店 */
    StoreBtnAction = 11,
};

#import <UIKit/UIKit.h>
#import "ModuleView.h"

@interface ServiceModuleView : UIView

/** 服务 */
@property (strong, nonatomic) ModuleView *serviceBtn;
/** 会员卡 */
@property (strong, nonatomic) ModuleView *membershipCardBtn;
/** 客户 */
@property (strong, nonatomic) ModuleView *customerBtn;
/**  营销 */
@property (strong, nonatomic) ModuleView *marketingBtn;
/** 报表 */
@property (strong, nonatomic) ModuleView *reportBtn;
/** 订单 */
@property (strong, nonatomic) ModuleView *orderBtn;
/** 商城 */
@property (strong, nonatomic) ModuleView *commercialCityBtn;
/** 账户 */
@property (strong, nonatomic) ModuleView *accountBtn;
/** 门店 */
@property (strong, nonatomic) ModuleView *storeBtn;


@end
