//
//  ShoppingCartFootView.h
//  TradePlatform
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

// 购物车底部按钮点击类型
typedef NS_ENUM(NSInteger, CashierBottonAction) {
    /** 总价按钮 */
    TotalBtnAction,
    /** 确认收款 */
    ConfirmationCollectionBtnAction,
    /** 提交订单 */
    PlaceOrderBtnAction,
    /** 购物车 */
    ShoppingCartBtnAction,
    /** 清空 */
    EmptyBtnAction,
};

#import <UIKit/UIKit.h>

@interface ShoppingCartFootView : UIView

/** 总价 */
@property (strong, nonatomic) UILabel *totalLabel;
/** 总价按钮 */
@property (strong, nonatomic) UIButton *totalBtn;
/** 清空商品 */
@property (strong, nonatomic) UIButton *emptyBtn;
/** 购物车 */
@property (strong, nonatomic) UIButton *shoppingCartBtn;
/** 购物车数量 */
@property (assign, nonatomic) NSInteger shoppingCartNum;
/** 确认收款 */
@property (strong, nonatomic) UIButton *confirmationCollectionBtn;
/** 提交订单 */
@property (strong, nonatomic) UIButton *placeOrderBtn;

@end
