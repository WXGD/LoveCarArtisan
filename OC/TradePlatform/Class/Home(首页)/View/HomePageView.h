//
//  HomePageView.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

// 首页时时数据点击类型
typedef NS_ENUM(NSInteger, SuspensionAction) {
    /** 挂单入口按钮 */
    PendOrderBtnActio = 20,
};

#import <UIKit/UIKit.h>
// view
#import "ShowDataView.h"
#import "ServiceModuleView.h"
#import "BannerView.h"
#import "ScrollBottomView.h"

@interface HomePageView : UIView

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *homePageScrollView;

/** 时时数据 */
@property (strong, nonatomic) ShowDataView *showDataView;
/** 服务模块 */
@property (strong, nonatomic) ServiceModuleView *serviceModuleView;
/** 工匠资讯 */
@property (strong, nonatomic) BannerView *bannerView;
/** 底部提示 */
@property (strong, nonatomic) ScrollBottomView *bottomSignView;
/** 挂单入口按钮 */
@property(strong, nonatomic) UIButton *btnPendOrder;

@end
