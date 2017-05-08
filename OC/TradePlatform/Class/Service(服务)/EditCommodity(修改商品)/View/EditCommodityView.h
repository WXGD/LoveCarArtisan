//
//  EditCommodityView.h
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface EditCommodityView : UIView

/** 修改信息输入框 */
@property (strong, nonatomic) UITextField *changeTextField;

// 修改商品名称名的输入框限制
- (RACSignal *)changeCommodityNameTextFieldSignal;
// 修改商品原价的输入框限制
- (RACSignal *)changeOriginalPriceTextFieldSignal;
// 修改商品销售价的输入框限制
- (RACSignal *)changePresentPriceTextFieldSignal;

@end
