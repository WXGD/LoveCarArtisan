//
//  CardInfoChangeView.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardInfoChangeView : UIView

/** 修改信息输入框 */
@property (strong, nonatomic) UITextField *changeTextField;

// 修改卡名称名的输入框限制
- (RACSignal *)changeCardNameTextFieldSignal;
// 修改卡原价的输入框限制
- (RACSignal *)changeCardPriceTextFieldSignal;


@end
