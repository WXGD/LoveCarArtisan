//
//  ShowDataView.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//
// 首页时时数据点击类型
typedef NS_ENUM(NSInteger, ShowDataBottonAction) {
    /** 扫一扫 */
    ScanBtnAction,
    /** 收款 */
    ReceiptBtnAction,
};

#import <UIKit/UIKit.h>

@interface ShowDataView : UIView

/** 营业额 */
@property (strong, nonatomic) UILabel *turnoverLabel;
/** 消费人数 */
@property (strong, nonatomic) UILabel *csmPleNumLabel;
/** 订单数 */
@property (strong, nonatomic) UILabel *orderNumLabel;
/** 收银，扫一扫view */
@property (strong, nonatomic) UIButton *cashierBtn;
@property (strong, nonatomic) UIButton *scanBtn;

@end
