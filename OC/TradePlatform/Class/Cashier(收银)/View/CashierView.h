//
//  CashierView.h
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

// 收银页按钮点击类型
typedef NS_ENUM(NSInteger, CashierBottonAction) {
    /** 确认收款 */
    ConfirmationCollectionBtnAction,
    /** 提交订单 */
    PlaceOrderBtnAction,
    /** 手机号 */
    PhoneBtnAction,
    /** 车牌号 */
    PlnBtnAction,
    /** 省份简称 */
    CaftaBtnAction,
    /** 用户名 */
    UserNameBtnAction,
    /** 类别 */
    ClassBtnAction,
    /** 服务 */
    ServiceBtnAction,
    /** 添加商品 */
    AddGoodsBtnAction,
    /** 购物车 */
    ShoppingCartBtnAction,
    /** 服务师傅 */
    ServiceMasterBtnAction,
};

#import <UIKit/UIKit.h>
#import "AddSubNumView.h"
#import "CaftaBtn.h"

@protocol CashierViewDelegate <NSObject>

@optional
/** 修改销售价 */
- (void)editPretiumDelegate;

@end

@interface CashierView : UIView

/** 确认收款 */
@property (strong, nonatomic) UIButton *confirmationCollectionBtn;
/** 提交订单 */
@property (strong, nonatomic) UIButton *placeOrderBtn;
/** 手机号view */
@property (strong, nonatomic) UITextField *phoneTF;
@property (strong, nonatomic) UIButton *phoneBtn;
/** 车牌号view */
@property (strong, nonatomic) UITextField *plnTF;
@property (strong, nonatomic) UIButton *plnBtn;
@property (strong, nonatomic) CaftaBtn *caftaBtn;
/** 用户名 */
@property (strong, nonatomic) UsedCellView *userNameView;
/** 类别view */
@property (strong, nonatomic) UsedCellView *classView;
/** 服务view */
@property (strong, nonatomic) UsedCellView *serviceView;
/** 数量操作 */
@property (strong, nonatomic) AddSubNumView *numberOperationBtn;
/** 价格view */
@property (strong, nonatomic) UsedCellView *priceView;
/** 销售价view */
@property (strong, nonatomic) UsedCellView *pretiumView;
/** 总价view */
@property (strong, nonatomic) UsedCellView *totalView;
/** 添加商品 */
@property (strong, nonatomic) UIButton *addGoodsBtn;
/** 购物车 */
@property (strong, nonatomic) UIButton *shoppingCartBtn;
/** 购物车数量 */
@property (assign, nonatomic) NSInteger shoppingCartNum;
/** 服务师傅 */
@property (strong, nonatomic) UsedCellView *serviceMasterView;
/** 行驶里程 */
@property (strong, nonatomic) UsedCellView *mileageView;
/** 下次保养时间 */
@property (strong, nonatomic) UsedCellView *nextTimeView;
/** 收银代理 */
@property (assign, nonatomic) id<CashierViewDelegate>delegate;

@end
