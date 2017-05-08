//
//  AffirmOrderView.h
//  TradePlatform
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AffirmOrderView : UIView

/** 用户手机号 */
@property (strong, nonatomic) UILabel *userPhoneLabel;
/** 用户车牌号 */
@property (strong, nonatomic) UILabel *userPlnLabel;
/** 订单时间 */
@property (strong, nonatomic) UILabel *orderTimeLabel;
/** 服务信息table数据 */
@property (strong, nonatomic) NSMutableArray *serviceInfoArray;
/** 订单总价 */
@property (strong, nonatomic) UILabel *orderTotalLabel;
/** 销售价view */
@property (strong, nonatomic) UsedCellView *pretiumView;
/** 确认收款 */
@property (strong, nonatomic) UIButton *affirmCashierBtn;

@end
